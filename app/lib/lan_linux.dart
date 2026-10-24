import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';

import 'lan_pause.dart';
import 'lan_discovery.dart';

class LinuxLanPause extends LanPause {
  LinuxLanPause._();

  static Future<LinuxLanPause> load() async {
    final service = LinuxLanPause._();
    await service._reload();
    await service.scanDesktops();
    return service;
  }

  late final File _identityFile = File(
    '${Platform.environment['XDG_DATA_HOME'] ?? '${Platform.environment['HOME']}/.local/share'}/nikucode-pausa/peer.json',
  );
  late final File _stateFile = File('${_identityFile.parent.path}/state.json');
  late final File _desktopIdFile = File(
    '${_identityFile.parent.path}/desktop-id',
  );
  late final File _controlFile = File(
    '${Platform.environment['XDG_RUNTIME_DIR'] ?? _identityFile.parent.path}/nikucode-pausa.sock',
  );
  late final File _controlLockFile = File('${_controlFile.path}.lock');
  ServerSocket? _controlServer;
  RandomAccessFile? _controlLock;
  bool _remote = false;
  Map<String, dynamic> _remoteState = {};
  Map<String, dynamic>? _device;
  String? _desktopId;
  Process? _advertisement;
  SecureSocket? _pairSocket;
  StreamIterator<String>? _pairLines;
  String? _verificationCode;
  String? _pairAddress;
  int? _pairPort;
  DateTime? _pairDeadline;
  bool _confirming = false;
  final Map<String, Map<String, dynamic>> _sessions = {};
  final List<Map<String, dynamic>> _events = [];
  int? _cancelGeneration;
  final Set<String> _notifying = {};
  Timer? _timer;
  bool _busy = false;
  String? _lastDiscoveryReport;
  DateTime? _lastDiscoveryReportAt;
  String _status = 'Empareja tu Android para recibir pausas.';
  String? _activeSession;
  Future<void> _writes = Future<void>.value();

  @override
  bool get available => true;
  @override
  bool get isPhone => false;
  @override
  bool get paired => _remote ? _remoteState['paired'] == true : _device != null;
  @override
  bool get canSchedule => false;
  @override
  String get status =>
      _remote ? '${_remoteState['status'] ?? _status}' : _status;
  @override
  String? get pendingLabel => _remote
      ? _remoteState['pendingLabel'] as String?
      : _sessions.values.where((s) => s['state'] == 'pending').isEmpty
      ? null
      : 'Pausa programada en este equipo';
  String? get activeSession => _activeSession;
  @override
  String? get verificationCode =>
      _remote ? _remoteState['code'] as String? : _verificationCode;
  @override
  bool get pairingPending =>
      _remote ? _remoteState['pairingPending'] == true : _pairSocket != null;
  @override
  bool get confirming =>
      _remote ? _remoteState['confirming'] == true : _confirming;

  Future<void> _reload() async {
    try {
      final raw = await _readIdentity();
      if (raw != null) _device = jsonDecode(raw) as Map<String, dynamic>;
      final stateRaw = await _readPrivateFile(_stateFile);
      if (stateRaw != null && _device != null) {
        final state = jsonDecode(stateRaw) as Map<String, dynamic>;
        if (state['peer'] == _peerHash(_device)) {
          _cancelGeneration = state['cancelGeneration'] as int?;
          for (final value in state['sessions'] as List<dynamic>? ?? []) {
            if (value is Map<String, dynamic> && value['id'] is String) {
              if (value['state'] == 'started') {
                value['state'] = 'pending';
              }
              _sessions[value['id'] as String] = value;
            }
          }
          _events.addAll(
            (state['events'] as List<dynamic>? ?? [])
                .whereType<Map<String, dynamic>>(),
          );
        }
      }
      if (_device != null) {
        _status = 'Android emparejado. Esperando conexión WiFi.';
      }
      _desktopId = await _readPrivateFile(_desktopIdFile);
      if (_desktopId == null ||
          !RegExp(r'^[0-9a-f]{32}$').hasMatch(_desktopId!)) {
        final random = Random.secure();
        _desktopId = List<int>.generate(
          16,
          (_) => random.nextInt(256),
        ).map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
        await _writePrivateFile(_desktopIdFile, _desktopId!);
      }
    } catch (_) {
      _status = 'No se pudieron leer los datos de conexión local.';
    }
  }

  Future<void> _persist() {
    final payload = jsonEncode({
      'peer': _peerHash(_device),
      'sessions': _sessions.values.toList(),
      'events': _events,
      'cancelGeneration': _cancelGeneration,
    });
    final work = _writes.then((_) => _writePrivateFile(_stateFile, payload));
    _writes = work.catchError((Object _) {});
    return work;
  }

  Future<String?> _readIdentity() async => _readPrivateFile(_identityFile);

  String? _peerHash(Map<String, dynamic>? peer) => peer == null
      ? null
      : sha256
            .convert(utf8.encode('${peer['fingerprint']}:${peer['token']}'))
            .toString();

  Future<String?> _readPrivateFile(File file) async =>
      await file.exists() ? file.readAsString() : null;

  Future<void> _writePrivateFile(File file, String contents) async {
    await file.parent.create(recursive: true);
    final directoryMode = await Process.run('/usr/bin/chmod', [
      '700',
      file.parent.path,
    ]);
    if (directoryMode.exitCode != 0) {
      throw StateError('No se pudo proteger el directorio local.');
    }
    final temporary = File('${file.path}.tmp.$pid');
    try {
      await temporary.create();
      final mode = await Process.run('/usr/bin/chmod', ['600', temporary.path]);
      if (mode.exitCode != 0) {
        throw StateError('No se pudo proteger la clave local.');
      }
      await temporary.writeAsString(contents, flush: true);
      await temporary.rename(file.path);
    } finally {
      if (await temporary.exists()) await temporary.delete();
    }
  }

  Future<Map<String, dynamic>?> _controlRequest(String op) async {
    Socket? socket;
    try {
      socket = await Socket.connect(
        InternetAddress(_controlFile.path, type: InternetAddressType.unix),
        0,
        timeout: const Duration(milliseconds: 500),
      );
      final lines = StreamIterator<String>(
        socket
            .cast<List<int>>()
            .transform(utf8.decoder)
            .transform(const LineSplitter()),
      );
      socket.write('${jsonEncode({'op': op})}\n');
      await socket.flush();
      if (!await lines.moveNext().timeout(
        Duration(seconds: op == 'status' ? 3 : 65),
      )) {
        return null;
      }
      return jsonDecode(lines.current) as Map<String, dynamic>;
    } catch (_) {
      return null;
    } finally {
      socket?.destroy();
    }
  }

  Map<String, dynamic> _controlState() => {
    'paired': _device != null,
    'status': _status,
    'pendingLabel': _sessions.values.any((s) => s['state'] == 'pending')
        ? 'Pausa programada en este equipo'
        : null,
    'pairingPending': _pairSocket != null,
    'confirming': _confirming,
    'code': _verificationCode,
  };

  Future<void> _handleControl(Socket socket) async {
    try {
      final lines = StreamIterator<String>(
        socket
            .cast<List<int>>()
            .transform(utf8.decoder)
            .transform(const LineSplitter()),
      );
      if (!await lines.moveNext().timeout(const Duration(seconds: 3))) return;
      final request = jsonDecode(lines.current) as Map<String, dynamic>;
      switch (request['op']) {
        case 'confirm':
          await confirmPair();
        case 'reject':
          await rejectPair();
        case 'unpair':
          await unpair();
        case 'status':
          break;
        default:
          throw StateError('Operación local desconocida.');
      }
      socket.write('${jsonEncode(_controlState())}\n');
      await socket.flush();
    } catch (failure) {
      socket.write('${jsonEncode({'error': '$failure'})}\n');
      try {
        await socket.flush();
      } catch (_) {}
    } finally {
      socket.destroy();
    }
  }

  @override
  Future<void> scanDesktops() async {
    if (_controlServer != null) return;
    final state = await _controlRequest('status');
    if (state != null && state['error'] == null) {
      _remote = true;
      _remoteState = state;
      notifyListeners();
    } else {
      _remote = false;
      _status = 'Inicia el servicio de usuario de nikucode en Omarchy.';
      notifyListeners();
    }
  }

  @override
  Future<LanPairingInfo?> pairingInfo() async => null;

  @override
  Future<void> pair(String address, int port, String code, String pin) async {
    final expected = code.replaceAll(RegExp('[^0-9A-Fa-f]'), '').toUpperCase();
    final pairingPin = pin.replaceAll(RegExp('[^0-9A-Fa-f]'), '').toUpperCase();
    if (expected.length != 16 ||
        pairingPin.length != 16 ||
        port < 1 ||
        port > 65535 ||
        InternetAddress.tryParse(address) == null) {
      throw const FormatException(
        'Ingresa IP, puerto y código de 16 caracteres válidos.',
      );
    }
    final socket = await _connect(address, port, expected);
    try {
      final fingerprint = _fingerprint(socket.peerCertificate!);
      final lines = StreamIterator<String>(
        socket
            .cast<List<int>>()
            .transform(utf8.decoder)
            .transform(const LineSplitter()),
      );
      socket.write('${jsonEncode({'op': 'pair', 'pin': pairingPin})}\n');
      await socket.flush();
      if (!await lines.moveNext()) {
        throw const SocketException('El móvil cerró la conexión.');
      }
      final reply = jsonDecode(lines.current) as Map<String, dynamic>;
      final token = reply['token'];
      if (token is! String || !RegExp(r'^[0-9a-f]{64}$').hasMatch(token)) {
        throw StateError('Android no aceptó el emparejamiento.');
      }
      _sessions.clear();
      _events.clear();
      _device = {
        'address': address,
        'port': port,
        'fingerprint': fingerprint,
        'token': token,
      };
      await _writePrivateFile(_identityFile, jsonEncode(_device));
      _status = 'Android emparejado. Buscando conexión WiFi.';
      notifyListeners();
    } finally {
      socket.destroy();
    }
  }

  @override
  Future<void> unpair() async {
    if (_remote) {
      final state = await _controlRequest('unpair');
      if (state == null || state['error'] != null) {
        throw StateError('${state?['error'] ?? 'El servicio no respondió.'}');
      }
      _remoteState = state;
      notifyListeners();
      return;
    }
    final peer = _device;
    if (peer != null) {
      try {
        final socket = await _connect(
          peer['address'] as String,
          peer['port'] as int,
          peer['fingerprint'] as String,
        );
        socket.write(
          '${jsonEncode({'op': 'unpair', 'token': peer['token']})}\n',
        );
        await socket.flush();
        final lines = StreamIterator<String>(
          socket
              .cast<List<int>>()
              .transform(utf8.decoder)
              .transform(const LineSplitter()),
        );
        await lines.moveNext().timeout(const Duration(seconds: 3));
        socket.destroy();
      } catch (_) {
        // Android may be offline; its local unpair control still revokes trust.
      }
    }
    _device = null;
    _sessions.clear();
    _events.clear();
    _activeSession = null;
    if (await _identityFile.exists()) await _identityFile.delete();
    if (await _stateFile.exists()) await _stateFile.delete();
    _status = 'Android desvinculado.';
    notifyListeners();
  }

  String _fingerprint(X509Certificate certificate) =>
      sha256.convert(certificate.der).toString().toUpperCase();

  Future<SecureSocket> _connect(
    String address,
    int port,
    String fingerprint,
  ) async {
    final socket = await SecureSocket.connect(
      address,
      port,
      timeout: const Duration(seconds: 4),
      onBadCertificate: (certificate) =>
          _fingerprint(certificate).startsWith(fingerprint),
    );
    if (!_fingerprint(socket.peerCertificate!).startsWith(fingerprint)) {
      socket.destroy();
      throw const HandshakeException('El certificado del móvil no coincide.');
    }
    return socket;
  }

  @override
  Future<void> startService() async {
    if (_timer != null) return;
    if (await _controlRequest('status') != null) {
      _remote = true;
      return;
    }
    await _controlFile.parent.create(recursive: true);
    final lock = await _controlLockFile.open(mode: FileMode.append);
    try {
      await lock.lock(FileLock.exclusive);
    } on FileSystemException {
      await lock.close();
      _remote = true;
      _status = 'El servicio de nikucode ya está iniciando.';
      notifyListeners();
      return;
    }
    _controlLock = lock;
    await Process.run('/usr/bin/chmod', ['600', _controlLockFile.path]);
    try {
      await _controlFile.delete();
    } on FileSystemException {
      // No stale socket is present.
    }
    try {
      _controlServer = await ServerSocket.bind(
        InternetAddress(_controlFile.path, type: InternetAddressType.unix),
        0,
      );
    } catch (_) {
      await lock.unlock();
      await lock.close();
      _controlLock = null;
      rethrow;
    }
    await Process.run('/usr/bin/chmod', ['600', _controlFile.path]);
    _controlServer!.listen((socket) => unawaited(_handleControl(socket)));
    if (File('/usr/bin/avahi-publish-service').existsSync()) {
      _advertisement = await Process.start('/usr/bin/avahi-publish-service', [
        'nikucode-${Platform.localHostname}',
        '_nikucode-desktop._tcp',
        '9',
        'id=$_desktopId',
      ]);
      unawaited(_advertisement!.stdout.drain<void>());
      unawaited(_advertisement!.stderr.drain<void>());
    } else {
      _status = 'Instala Avahi para encontrar este computador desde Android.';
      notifyListeners();
    }
    await _tick();
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => unawaited(_tick()),
    );
  }

  Future<void> _tick() async {
    if (_busy) return;
    _busy = true;
    try {
      // The pairing window can save the peer while the service is already up.
      final raw = await _readIdentity();
      final current = raw == null
          ? null
          : jsonDecode(raw) as Map<String, dynamic>;
      if (current?['fingerprint'] != _device?['fingerprint'] ||
          current?['token'] != _device?['token']) {
        _sessions.clear();
        _events.clear();
        _cancelGeneration = null;
        _activeSession = null;
        _device = current;
        await _persist();
      }
      _device = current;
      if (_device != null) {
        await _deliverDue();
        await _sync();
      } else if (_pairSocket == null) {
        await _lookForPair();
      } else if (DateTime.now().isAfter(_pairDeadline!)) {
        await rejectPair();
      }
    } catch (error, stackTrace) {
      stderr.writeln('nikucode LAN: $error');
      stderr.writeln(stackTrace);
      _status = 'No se pudo conectar con Android: $error';
      notifyListeners();
    } finally {
      _busy = false;
    }
  }

  Future<void> _sync() async {
    final peer = _device!;
    final found = await _discover();
    var address = found?.address ?? peer['address'] as String;
    var port = found?.port ?? peer['port'] as int;
    SecureSocket socket;
    try {
      socket = await _connect(address, port, peer['fingerprint'] as String);
    } on SocketException {
      if (found == null ||
          (address == peer['address'] && port == peer['port'])) {
        rethrow;
      }
      socket = await _connect(
        peer['address'] as String,
        peer['port'] as int,
        peer['fingerprint'] as String,
      );
      address = peer['address'] as String;
      port = peer['port'] as int;
    }
    try {
      final lines = StreamIterator<String>(
        socket
            .cast<List<int>>()
            .transform(utf8.decoder)
            .transform(const LineSplitter()),
      );
      socket.write('${jsonEncode({'op': 'sync', 'token': peer['token']})}\n');
      await socket.flush();
      if (!await lines.moveNext()) return;
      final snapshot = jsonDecode(lines.current) as Map<String, dynamic>;
      if (snapshot['error'] != null) throw StateError('${snapshot['error']}');
      final latestCancellation = snapshot['cancelGeneration'] as int? ?? 0;
      if (latestCancellation != _cancelGeneration) {
        if (_cancelGeneration != null) {
          for (final session in _sessions.values) {
            if (session['state'] == 'pending') session['state'] = 'cancelled';
          }
        }
        _cancelGeneration = latestCancellation;
      }
      final accepted = <String>[];
      final expired = <String>[];
      final now = DateTime.now().toUtc();
      for (final raw in snapshot['schedules'] as List<dynamic>? ?? []) {
        if (raw is! Map<String, dynamic>) continue;
        final id = raw['id'];
        final date = DateTime.tryParse('${raw['dueAt']}')?.toUtc();
        if (id is! String || id.length > 100 || date == null) continue;
        if (_sessions.containsKey(id)) {
          accepted.add(id);
        } else if (date.isBefore(now.subtract(const Duration(minutes: 1)))) {
          expired.add(id);
        } else {
          _sessions[id] = {
            'id': id,
            'dueAt': date.toIso8601String(),
            'state': 'pending',
            'generation': latestCancellation,
          };
          accepted.add(id);
        }
      }
      await _persist();
      socket.write(
        '${jsonEncode({'op': 'commit', 'accepted': accepted, 'expired': expired, 'events': _events})}\n',
      );
      await socket.flush();
      if (!await lines.moveNext()) return;
      final result = jsonDecode(lines.current) as Map<String, dynamic>;
      if (result['error'] != null) return;
      final acknowledged = (result['acknowledged'] as List<dynamic>? ?? [])
          .whereType<String>()
          .toSet();
      _events.removeWhere((event) => acknowledged.contains(event['id']));
      await _persist();
      if (address != peer['address'] || port != peer['port']) {
        final latest = await _readIdentity();
        if (latest != null &&
            (jsonDecode(latest) as Map<String, dynamic>)['token'] ==
                peer['token']) {
          peer['address'] = address;
          peer['port'] = port;
          await _writePrivateFile(_identityFile, jsonEncode(peer));
        }
      }
      _status = 'Conectado con Android.';
      notifyListeners();
      await _deliverDue();
    } finally {
      socket.destroy();
    }
  }

  Future<LanAnnouncement?> _discover() async {
    if (!File('/usr/bin/avahi-browse').existsSync()) {
      _reportDiscovery('No está instalado avahi-browse.');
      return null;
    }
    final process = await Process.start('/usr/bin/avahi-browse', const [
      '-rtp',
      '_nikucode-pause._tcp',
    ]);
    final output = process.stdout.transform(utf8.decoder).join();
    final errors = process.stderr.transform(utf8.decoder).join();
    int? exitCode;
    try {
      exitCode = await process.exitCode.timeout(const Duration(seconds: 6));
    } on TimeoutException {
      process.kill();
    }
    final text = await output;
    final errorText = (await errors).trim();
    if (exitCode != null && exitCode != 0) {
      _reportDiscovery('Avahi falló ($exitCode): $errorText');
      return null;
    }
    final found = parseLanAnnouncement(
      text,
      requiredTarget: _device == null ? _desktopId : null,
    );
    if (_device == null) {
      _reportDiscovery(
        found != null
            ? 'Solicitud para este computador: ${found.address}:${found.port}.'
            : text.contains('nikucode-pausa-')
            ? 'Hay una solicitud visible, pero su destino o código no coincide.'
            : text.contains('nikucode-pausa')
            ? 'Teléfono visible; esperando su solicitud de emparejamiento.'
            : 'No aparece el teléfono en Avahi.',
      );
    }
    return found;
  }

  void _reportDiscovery(String message) {
    final now = DateTime.now();
    if (message == _lastDiscoveryReport &&
        _lastDiscoveryReportAt != null &&
        now.difference(_lastDiscoveryReportAt!) < const Duration(seconds: 20)) {
      return;
    }
    stderr.writeln('nikucode LAN: $message');
    _lastDiscoveryReport = message;
    _lastDiscoveryReportAt = now;
  }

  Future<void> _lookForPair() async {
    final found = await _discover();
    final id = _desktopId;
    if (found == null ||
        id == null ||
        found.target != id ||
        !RegExp(r'^[0-9a-f]{32}$').hasMatch(found.nonce ?? '')) {
      return;
    }
    final socket = await SecureSocket.connect(
      found.address,
      found.port,
      timeout: const Duration(seconds: 4),
      onBadCertificate: (_) => true,
    );
    try {
      final certificate = socket.peerCertificate;
      if (certificate == null) {
        throw const HandshakeException('Falta certificado TLS.');
      }
      final clientNonce = List<int>.generate(
        16,
        (_) => Random.secure().nextInt(256),
      ).map((value) => value.toRadixString(16).padLeft(2, '0')).join();
      final digest = sha256
          .convert([
            ...certificate.der,
            ...utf8.encode(found.nonce!),
            ...utf8.encode(clientNonce),
          ])
          .bytes
          .take(8)
          .map((value) => value.toRadixString(16).padLeft(2, '0'))
          .join()
          .toUpperCase();
      final lines = StreamIterator<String>(
        socket
            .cast<List<int>>()
            .transform(utf8.decoder)
            .transform(const LineSplitter()),
      );
      socket.write(
        '${jsonEncode({'op': 'pairBegin', 'id': id, 'nonce': found.nonce, 'clientNonce': clientNonce})}\n',
      );
      await socket.flush();
      if (!await lines.moveNext().timeout(const Duration(seconds: 6))) {
        throw const SocketException('Android cerró el emparejamiento.');
      }
      final reply = jsonDecode(lines.current) as Map<String, dynamic>;
      if (reply['ready'] != true) {
        throw StateError('Android rechazó la solicitud.');
      }
      _pairSocket = socket;
      _pairLines = lines;
      _pairAddress = found.address;
      _pairPort = found.port;
      _pairDeadline = DateTime.now().add(const Duration(seconds: 55));
      _verificationCode = digest;
      _status = 'Compara esta clave en Android y Omarchy.';
      notifyListeners();
      unawaited(_notifyPair());
    } catch (_) {
      socket.destroy();
      rethrow;
    }
  }

  Future<void> _notifyPair() async {
    try {
      final process = await Process.start('/usr/bin/notify-send', const [
        '--wait',
        '--expire-time=60000',
        '--app-name=nikucode',
        '--action=open=Revisar clave',
        'nikucode · emparejamiento',
        'Android quiere conectarse con este computador.',
      ]);
      final answer = await process.stdout.transform(utf8.decoder).join();
      await process.exitCode;
      if (answer.trim() == 'open' && _pairSocket != null) {
        await const MethodChannel('cl.nikucode/desktop')
            .invokeMethod<void>('present');
        onPairingRequested?.call();
      }
    } catch (_) {}
  }

  @override
  Future<void> confirmPair() async {
    if (_remote) {
      final state = await _controlRequest('confirm');
      if (state == null || state['error'] != null) {
        throw StateError('${state?['error'] ?? 'El servicio no respondió.'}');
      }
      _remoteState = state;
      notifyListeners();
      return;
    }
    final socket = _pairSocket;
    final lines = _pairLines;
    final code = _verificationCode;
    if (socket == null ||
        lines == null ||
        code == null ||
        DateTime.now().isAfter(_pairDeadline!)) {
      throw StateError('La solicitud de emparejamiento venció.');
    }
    if (_confirming) return;
    _confirming = true;
    _status = 'Esperando confirmación en Android.';
    notifyListeners();
    try {
      socket.write('${jsonEncode({'op': 'pairConfirm', 'code': code})}\n');
      await socket.flush();
      if (!await lines.moveNext().timeout(const Duration(seconds: 60))) {
        throw const SocketException('Android cerró el emparejamiento.');
      }
      final reply = jsonDecode(lines.current) as Map<String, dynamic>;
      final token = reply['token'];
      if (token is! String || !RegExp(r'^[0-9a-f]{64}$').hasMatch(token)) {
        throw StateError('Android no confirmó el emparejamiento.');
      }
      final peer = {
        'address': _pairAddress,
        'port': _pairPort,
        'fingerprint': _fingerprint(socket.peerCertificate!),
        'token': token,
      };
      await _writePrivateFile(_identityFile, jsonEncode(peer));
      socket.write('${jsonEncode({'op': 'pairStored'})}\n');
      await socket.flush();
      if (!await lines.moveNext().timeout(const Duration(seconds: 6))) {
        throw const SocketException('Android no confirmó el guardado.');
      }
      final confirmation = jsonDecode(lines.current) as Map<String, dynamic>;
      if (confirmation['paired'] != true) {
        await _identityFile.delete();
        throw StateError('Android no pudo guardar el emparejamiento.');
      }
      _device = peer;
      _sessions.clear();
      _events.clear();
      _status = 'Android emparejado. Buscando conexión WiFi.';
      notifyListeners();
    } finally {
      await rejectPair();
    }
  }

  @override
  Future<void> rejectPair() async {
    if (_remote) {
      final state = await _controlRequest('reject');
      if (state == null || state['error'] != null) {
        throw StateError('${state?['error'] ?? 'El servicio no respondió.'}');
      }
      _remoteState = state;
      notifyListeners();
      return;
    }
    _pairSocket?.destroy();
    _confirming = false;
    _pairSocket = null;
    _pairLines = null;
    _pairAddress = null;
    _pairPort = null;
    _pairDeadline = null;
    _verificationCode = null;
    notifyListeners();
  }

  Future<void> _deliverDue() async {
    if (_activeSession != null || _notifying.isNotEmpty) return;
    final now = DateTime.now().toUtc();
    for (final session in _sessions.values.toList()) {
      if (session['state'] != 'pending') continue;
      final due = DateTime.tryParse('${session['dueAt']}');
      if (due == null || due.isAfter(now)) continue;
      final id = session['id'] as String;
      if (now.difference(due) > const Duration(minutes: 30)) {
        session['state'] = 'missed';
        await _persist();
        continue;
      }
      if (_notifying.add(id)) {
        unawaited(_notifySession(id));
        break;
      }
    }
  }

  Future<void> _notifySession(String id) async {
    try {
      // Omarchy invokes the "default" action when the notification card is clicked.
      final process = await Process.start('/usr/bin/notify-send', const [
        '--wait',
        '--expire-time=30000',
        '--app-name=nikucode',
        '--action=default=Abrir propuesta',
        '--action=start=Elegir una pausa',
        '--action=postpone=Posponer 10 min',
        '--action=skip=Ahora no',
        '¿Es un buen momento para una pausa?',
        'Puedes abrir una propuesta o dejar pasar esta señal; no tienes que responder.',
      ]);
      final answer = await process.stdout.transform(utf8.decoder).join();
      await process.exitCode;
      final session = _sessions[id];
      if (session == null || session['state'] != 'pending') return;
      if (answer.trim() == 'postpone') {
        final dueAt = DateTime.now().toUtc().add(const Duration(minutes: 10));
        session['dueAt'] = dueAt.toIso8601String();
        await _record(
          id,
          'postponed',
          dueAt: dueAt,
          notificationId: DateTime.now().microsecondsSinceEpoch,
          generation: session['generation'] as int?,
        );
      } else if (answer.trim() == 'skip') {
        session['state'] = 'dismissed';
        await _record(id, 'dismissed');
      } else if (answer.trim() == 'start' || answer.trim() == 'default') {
        session['state'] = 'started';
        _activeSession = id;
        await _record(id, 'proposalOpened');
        try {
          await const MethodChannel('cl.nikucode/desktop')
              .invokeMethod<void>('present');
        } catch (_) {}
        onStartPause?.call(id);
      } else {
        // No action was chosen; do not turn silence into a completed pause.
        session['state'] = 'unanswered';
      }
      await _persist();
      notifyListeners();
    } catch (_) {
      _status = 'No se pudo mostrar el aviso de Omarchy.';
      notifyListeners();
    } finally {
      _notifying.remove(id);
    }
  }

  Future<void> _record(
    String sessionId,
    String kind, {
    DateTime? dueAt,
    int? notificationId,
    int? generation,
  }) async {
    final event = <String, dynamic>{
      'id': '$sessionId:$kind:${DateTime.now().microsecondsSinceEpoch}',
      'kind': kind,
      'at': DateTime.now().toUtc().toIso8601String(),
    };
    if (dueAt != null) event['dueAtMs'] = dueAt.millisecondsSinceEpoch;
    if (notificationId != null) event['notificationId'] = notificationId;
    if (generation != null) event['generation'] = generation;
    _events.add(event);
    await _persist();
  }

  @override
  Future<void> recordSession(String id, String kind) async {
    final session = _sessions[id];
    if (session == null || session['state'] != 'started') return;
    if (kind == 'guideStarted') {
      await _record(id, kind);
      return;
    }
    if (kind == 'guideFinished' || kind == 'guideStopped') {
      session['state'] = kind == 'guideFinished' ? 'finished' : 'stopped';
      _activeSession = null;
      await _record(id, kind);
      notifyListeners();
    } else if (kind == 'dismissed') {
      session['state'] = 'dismissed';
      _activeSession = null;
      await _record(id, kind);
      notifyListeners();
    }
  }

  @override
  Future<void> schedule(Duration delay) async {}
  @override
  Future<void> startNow() async {}
  @override
  Future<void> cancelPending() async {}

  @override
  void dispose() {
    _timer?.cancel();
    _controlServer?.close();
    if (_controlServer != null) unawaited(_controlFile.delete());
    if (_controlLock != null) {
      unawaited(_controlLock!.unlock().then((_) => _controlLock!.close()));
    }
    _advertisement?.kill();
    _pairSocket?.destroy();
    super.dispose();
  }
}
