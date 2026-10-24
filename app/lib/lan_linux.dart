import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';

import 'lan_pause.dart';

class LinuxLanPause extends LanPause {
  LinuxLanPause._();

  static Future<LinuxLanPause> load() async {
    final service = LinuxLanPause._();
    await service._reload();
    return service;
  }

  late final File _identityFile = File(
    '${Platform.environment['XDG_DATA_HOME'] ?? '${Platform.environment['HOME']}/.local/share'}/nikucode-pausa/peer.json',
  );
  late final File _stateFile = File('${_identityFile.parent.path}/state.json');
  Map<String, dynamic>? _device;
  final Map<String, Map<String, dynamic>> _sessions = {};
  final List<Map<String, dynamic>> _events = [];
  final Set<String> _notifying = {};
  Timer? _timer;
  bool _busy = false;
  String _status = 'Empareja tu Android para recibir pausas.';
  String? _activeSession;
  Future<void> _writes = Future<void>.value();

  @override
  bool get available => true;
  @override
  bool get isPhone => false;
  @override
  bool get paired => _device != null;
  @override
  bool get canSchedule => false;
  @override
  String get status => _status;
  @override
  String? get pendingLabel =>
      _sessions.values.where((s) => s['state'] == 'pending').isEmpty
      ? null
      : 'Pausa programada en este equipo';
  String? get activeSession => _activeSession;

  Future<void> _reload() async {
    try {
      final raw = await _readIdentity();
      if (raw != null) _device = jsonDecode(raw) as Map<String, dynamic>;
      final stateRaw = await _readPrivateFile(_stateFile);
      if (stateRaw != null && _device != null) {
        final state = jsonDecode(stateRaw) as Map<String, dynamic>;
        if (state['peer'] == _peerHash(_device)) {
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
    } catch (_) {
      _status = 'No se pudieron leer los datos de conexión local.';
    }
  }

  Future<void> _persist() {
    final payload = jsonEncode({
      'peer': _peerHash(_device),
      'sessions': _sessions.values.toList(),
      'events': _events,
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
      _status = 'Android emparejado. Las pausas llegarán mientras la app móvil esté abierta.';
      notifyListeners();
    } finally {
      socket.destroy();
    }
  }

  @override
  Future<void> unpair() async {
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
        _activeSession = null;
        _device = current;
        await _persist();
      }
      _device = current;
      if (_device != null) {
        await _deliverDue();
        await _sync();
      }
    } catch (_) {
      _status =
          'Sin conexión con Android; las pausas confirmadas siguen en Omarchy.';
      notifyListeners();
    } finally {
      _busy = false;
    }
  }

  Future<void> _sync() async {
    final peer = _device!;
    final address = (await _discover()) ?? peer['address'] as String;
    final socket = await _connect(
      address,
      peer['port'] as int,
      peer['fingerprint'] as String,
    );
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
      final accepted = <String>[];
      final expired = <String>[];
      final now = DateTime.now().toUtc();
      for (final raw in snapshot['schedules'] as List<dynamic>? ?? []) {
        if (raw is! Map<String, dynamic>) continue;
        final id = raw['id'];
        final date = DateTime.tryParse('${raw['dueAt']}')?.toUtc();
        final immediate = raw['immediate'] == true;
        if (id is! String || id.length > 100 || date == null) continue;
        if (_sessions.containsKey(id)) {
          accepted.add(id);
        } else if (date.isBefore(
          immediate ? now.subtract(const Duration(minutes: 1)) : now,
        )) {
          expired.add(id);
        } else {
          _sessions[id] = {
            'id': id,
            'dueAt': date.toIso8601String(),
            'state': 'pending',
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
      if (address != peer['address']) {
        final latest = await _readIdentity();
        if (latest != null &&
            (jsonDecode(latest) as Map<String, dynamic>)['token'] ==
                peer['token']) {
          peer['address'] = address;
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

  Future<String?> _discover() async {
    if (!File('/usr/bin/avahi-browse').existsSync()) return null;
    final process = await Process.start('/usr/bin/avahi-browse', const [
      '-rtp',
      '_nikucode-pause._tcp',
    ]);
    final output = process.stdout.transform(utf8.decoder).join();
    try {
      await process.exitCode.timeout(const Duration(seconds: 2));
    } on TimeoutException {
      process.kill();
    }
    final text = await output;
    for (final line in const LineSplitter().convert(text)) {
      final fields = line.split(';');
      if (fields.length > 8 &&
          fields.first == '=' &&
          fields[2] == 'IPv4' &&
          fields[3].startsWith('nikucode-pausa')) {
        final address = fields[7];
        final port = int.tryParse(fields[8]);
        if (InternetAddress.tryParse(address) != null &&
            port == _device?['port']) {
          return address;
        }
      }
    }
    return null;
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
      final process = await Process.start('/usr/bin/notify-send', const [
        '--wait',
        '--expire-time=30000',
        '--app-name=nikucode',
        '--action=start=Iniciar pausa',
        '--action=postpone=Posponer 10 min',
        'Es momento de realizar una pausa activa',
        'Puedes iniciarla ahora o posponerla.',
      ]);
      final answer = await process.stdout.transform(utf8.decoder).join();
      await process.exitCode;
      final session = _sessions[id];
      if (session == null || session['state'] != 'pending') return;
      if (answer.trim() == 'postpone') {
        session['dueAt'] = DateTime.now()
            .toUtc()
            .add(const Duration(minutes: 10))
            .toIso8601String();
        await _record(id, 'postponed');
      } else if (answer.trim() == 'start') {
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

  Future<void> _record(String sessionId, String kind) async {
    _events.add({
      'id': '$sessionId:$kind:${DateTime.now().microsecondsSinceEpoch}',
      'kind': kind,
      'at': DateTime.now().toUtc().toIso8601String(),
    });
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
    super.dispose();
  }
}
