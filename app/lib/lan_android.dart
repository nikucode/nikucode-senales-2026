import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interaction_history.dart';
import 'lan_pause.dart';

class AndroidLanPause extends LanPause with WidgetsBindingObserver {
  AndroidLanPause._(this._history) {
    WidgetsBinding.instance.addObserver(this);
    _refreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      unawaited(_refreshQueue());
      unawaited(_drainEvents());
      unawaited(_refreshConnectionStatus());
    });
  }

  static const _channel = MethodChannel('cl.nikucode/lan');
  static const _queueKey = 'lan.pending.v1';

  static Future<AndroidLanPause> load(InteractionHistory history) async {
    final storage = SharedPreferencesAsync();
    final result = AndroidLanPause._(history);
    try {
      final saved = await storage.getString(_queueKey);
      if (saved != null) {
        await _channel.invokeMethod<int>('queueImport', saved);
        await storage.remove(_queueKey);
      }
    } catch (_) {}
    await result._refreshQueue();
    await result._drainEvents();
    try {
      if (await _channel.invokeMethod<bool>('isPaired') == true) {
        result._confirmed = 'Omarchy';
        result._status = 'Android emparejado. Esperando conexión con Omarchy.';
      }
    } catch (_) {}
    return result;
  }

  final InteractionHistory _history;
  Timer? _refreshTimer;
  bool _serviceRunning = false;
  DateTime? _sharedReminderAt;
  int? _sharedReminderId;
  final List<Map<String, dynamic>> _queue = [];
  List<LanDesktop> _desktops = [];
  String? _verificationCode;
  bool _pairingPending = false;
  bool _phoneConfirmed = false;
  String _status = 'Abre la app en la misma WiFi para conectar con Omarchy.';
  String? _confirmed;

  @override
  bool get available => true;
  @override
  bool get isPhone => true;
  @override
  bool get paired => _confirmed != null;
  @override
  bool get canSchedule => paired;
  @override
  String get status => _status;
  @override
  String? get pendingLabel => _queue.isEmpty
      ? null
      : '${_queue.length} pausa${_queue.length == 1 ? '' : 's'} pendiente${_queue.length == 1 ? '' : 's'} de confirmar';
  @override
  List<LanDesktop> get desktops => _desktops;
  @override
  String? get verificationCode => _verificationCode;
  @override
  bool get pairingPending => _pairingPending;
  @override
  bool get confirming => _phoneConfirmed;
  @override
  bool get serviceRunning => _serviceRunning;
  @override
  DateTime? get sharedReminderAt => _sharedReminderAt;
  @override
  int? get sharedReminderId => _sharedReminderId;

  Future<void> _refreshQueue() async {
    try {
      final raw = await _channel.invokeMethod<String>('queueSnapshot');
      final data = jsonDecode(raw ?? '{}') as Map<String, dynamic>;
      final local = data['localReminder'];
      if (local is Map<String, dynamic>) {
        final dueAt = local['dueAtMs'];
        final id = local['notificationId'];
        _sharedReminderAt = dueAt is int
            ? DateTime.fromMillisecondsSinceEpoch(dueAt)
            : null;
        _sharedReminderId = id is int ? id : null;
      } else {
        _sharedReminderAt = null;
        _sharedReminderId = null;
      }
      _queue
        ..clear()
        ..addAll(
          (data['schedules'] as List<dynamic>? ?? [])
              .whereType<Map<String, dynamic>>(),
        );
      notifyListeners();
    } catch (_) {}
  }

  Future<void> _drainEvents() async {
    try {
      final raw = await _channel.invokeMethod<String>('queueEvents');
      final acknowledged = <String>[];
      for (final item in jsonDecode(raw ?? '[]') as List<dynamic>) {
        if (item is! Map<String, dynamic>) continue;
        final id = item['id'];
        final kind = item['kind'];
        final at = DateTime.tryParse('${item['at']}');
        if (id is! String || kind is! String || at == null) continue;
        final index = InteractionKind.values.indexWhere(
          (entry) => entry.name == kind,
        );
        if (index < 0) continue;
        if (await _history.recordRemote(
          id,
          InteractionKind.values[index],
          at,
        )) {
          acknowledged.add(id);
        }
      }
      if (acknowledged.isNotEmpty) {
        await _channel.invokeMethod<bool>('queueAck', acknowledged);
      }
    } catch (_) {}
  }

  Future<void> _refreshConnectionStatus() async {
    try {
      final running = await _channel.invokeMethod<bool>('lanRunning') == true;
      final trusted = await _channel.invokeMethod<bool>('isPaired') == true;
      final state = running
          ? await _channel.invokeMapMethod<String, dynamic>('pairingState')
          : null;
      _serviceRunning = running;
      _confirmed = trusted ? 'Omarchy' : null;
      if (trusted) {
        _status = !running
            ? 'Conexión con Omarchy detenida.'
            : state?['connected'] == true
            ? 'Conectado con Omarchy.'
            : 'Omarchy sin conexión. Se reconectará en la misma WiFi.';
      }
      notifyListeners();
    } catch (_) {}
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_refreshQueue());
      unawaited(_drainEvents());
      unawaited(_refreshConnectionStatus());
    }
  }

  @override
  Future<void> scanDesktops() async {
    final trusted = await _channel.invokeMethod<bool>('isPaired') == true;
    _serviceRunning = await _channel.invokeMethod<bool>('lanRunning') == true;
    if (!trusted && !_serviceRunning) {
      await startService();
    }
    if (!trusted && !_pairingPending) {
      final entries = await _channel.invokeListMethod<dynamic>(
        'discoverDesktops',
      );
      _desktops = (entries ?? [])
          .whereType<Map<dynamic, dynamic>>()
          .map((item) => LanDesktop('${item['id']}', '${item['name']}'))
          .toList();
    }
    final state = await _channel.invokeMapMethod<String, dynamic>(
      'pairingState',
    );
    _verificationCode = state?['code'] as String?;
    _pairingPending = state?['pending'] == true;
    if (!_pairingPending) _phoneConfirmed = false;
    if (trusted) {
      _confirmed = 'Omarchy';
      await stopScan();
      _status = !_serviceRunning
          ? 'Conexión con Omarchy detenida.'
          : state?['connected'] == true
          ? 'Conectado con Omarchy.'
          : 'Omarchy sin conexión. Se reconectará en la misma WiFi.';
      await _refreshQueue();
      await _drainEvents();
    }
    notifyListeners();
  }

  @override
  Future<void> stopScan() async {
    try {
      await _channel.invokeMethod<bool>('stopDiscovery');
    } catch (_) {}
  }

  @override
  Future<void> requestPair(String id) async {
    if (await _channel.invokeMethod<bool>('beginPair', id) != true) {
      throw StateError('No se pudo solicitar el emparejamiento.');
    }
    _pairingPending = true;
    _phoneConfirmed = false;
    _status = 'Esperando la conexión de Omarchy.';
    notifyListeners();
  }

  @override
  Future<void> confirmPair() async {
    if (await _channel.invokeMethod<bool>('confirmPair') != true) {
      throw StateError('La solicitud ya no está disponible.');
    }
    _phoneConfirmed = true;
    _status = 'Esperando confirmación en Omarchy.';
    notifyListeners();
  }

  @override
  Future<void> rejectPair() async {
    await _channel.invokeMethod<bool>('rejectPair');
    _pairingPending = false;
    _phoneConfirmed = false;
    _verificationCode = null;
    notifyListeners();
  }

  @override
  Future<LanPairingInfo?> pairingInfo() async {
    return null;
  }

  @override
  Future<void> pair(String address, int port, String code, String pin) async {}

  @override
  Future<void> unpair() async {
    if (await _channel.invokeMethod<bool>('unpair') != true) {
      throw StateError('No se pudo retirar el emparejamiento.');
    }
    _confirmed = null;
    _queue.clear();
    _sharedReminderAt = null;
    _sharedReminderId = null;
    _serviceRunning = false;
    _desktops = [];
    _pairingPending = false;
    _phoneConfirmed = false;
    _verificationCode = null;
    _status = 'Equipo desvinculado.';
    notifyListeners();
  }

  @override
  Future<void> schedule(Duration delay) async {
    if (delay <= Duration.zero) return;
    await _add(DateTime.now().add(delay), immediate: false);
  }

  @override
  Future<void> scheduleSharedReminder(DateTime dueAt, int invitationId) async {
    if (!_serviceRunning) await startService();
    await _add(dueAt, immediate: false, invitationId: invitationId);
  }

  @override
  Future<void> startNow() => _add(DateTime.now(), immediate: true);

  Future<void> _add(
    DateTime dueAt, {
    required bool immediate,
    int? invitationId,
  }) async {
    if (_queue.length >= 32) {
      _status = 'Hay demasiadas solicitudes pendientes; espera la conexión o retíralas.';
      notifyListeners();
      throw StateError(_status);
    }
    final id =
        '${DateTime.now().microsecondsSinceEpoch}-${Random.secure().nextInt(1 << 32)}';
    final request = <String, dynamic>{
      'id': id,
      'dueAt': dueAt.toUtc().toIso8601String(),
      'immediate': immediate,
    };
    if (invitationId != null) {
      request['notificationId'] = invitationId;
      request['dueAtMs'] = dueAt.millisecondsSinceEpoch;
    }
    await _channel.invokeMethod<int>('queueAdd', jsonEncode(request));
    _queue.add(request);
    if (invitationId != null) {
      _sharedReminderAt = dueAt;
      _sharedReminderId = invitationId;
    }
    _status = 'Pausa pendiente de confirmación en Omarchy.';
    notifyListeners();
  }

  @override
  Future<void> cancelPending() async {
    if (await _channel.invokeMethod<bool>('queueCancel') != true) {
      throw StateError('No se pudieron retirar las solicitudes.');
    }
    _queue.clear();
    _sharedReminderAt = null;
    _sharedReminderId = null;
    _status = 'Programaciones pendientes retiradas.';
    notifyListeners();
  }

  @override
  Future<void> startService() async {
    await _channel.invokeMethod<bool>('startLan');
    _serviceRunning = true;
    notifyListeners();
  }

  @override
  Future<void> recordSession(String id, String kind) async {}

  @override
  void dispose() {
    _refreshTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
