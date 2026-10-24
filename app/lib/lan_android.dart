import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interaction_history.dart';
import 'lan_pause.dart';

class AndroidLanPause extends LanPause {
  AndroidLanPause._(this._storage, this._history) {
    _channel.setMethodCallHandler(_handleNative);
  }

  static const _channel = MethodChannel('cl.nikucode/lan');
  static const _queueKey = 'lan.pending.v1';

  static Future<AndroidLanPause> load(InteractionHistory history) async {
    final storage = SharedPreferencesAsync();
    final result = AndroidLanPause._(storage, history);
    try {
      final saved = await storage.getString(_queueKey);
      if (saved != null) {
        for (final item in jsonDecode(saved) as List<dynamic>) {
          if (item is Map<String, dynamic> &&
              item['id'] is String &&
              item['dueAt'] is String) {
            result._queue.add(item);
          }
        }
      }
    } catch (_) {}
    try {
      if (await _channel.invokeMethod<bool>('isPaired') == true) {
        result._confirmed = 'Omarchy';
        result._status = 'Android emparejado. Esperando conexión con Omarchy.';
      }
    } catch (_) {}
    return result;
  }

  final SharedPreferencesAsync _storage;
  final InteractionHistory _history;
  final List<Map<String, dynamic>> _queue = [];
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
  Future<LanPairingInfo?> pairingInfo() async {
    try {
      final raw = await _channel.invokeMapMethod<String, dynamic>(
        'pairingInfo',
      );
      if (raw == null) throw StateError('Servidor local no disponible');
      if ((raw['address'] as String? ?? '').isEmpty) {
        throw StateError('Conecta el móvil a una red WiFi local.');
      }
      final diagnostic = raw['error'] as String? ?? '';
      if (diagnostic.isNotEmpty) {
        _status = diagnostic;
        notifyListeners();
      }
      return LanPairingInfo(
        address: raw['address'] as String? ?? '',
        port: raw['port'] as int? ?? 0,
        code: raw['code'] as String? ?? '',
        pin: raw['pin'] as String? ?? '',
      );
    } catch (error) {
      _status = error is StateError
          ? error.message
          : 'No se pudo iniciar el emparejamiento en Android.';
      notifyListeners();
      return null;
    }
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
    await _save();
    _status = 'Equipo desvinculado.';
    notifyListeners();
  }

  @override
  Future<void> schedule(Duration delay) async {
    if (delay <= Duration.zero) return;
    await _add(DateTime.now().add(delay), immediate: false);
  }

  @override
  Future<void> startNow() => _add(DateTime.now(), immediate: true);

  Future<void> _add(DateTime dueAt, {required bool immediate}) async {
    if (_queue.length >= 32) {
      _status = 'Hay demasiadas solicitudes pendientes; espera la conexión o retíralas.';
      notifyListeners();
      return;
    }
    final id =
        '${DateTime.now().microsecondsSinceEpoch}-${Random.secure().nextInt(1 << 32)}';
    _queue.add({
      'id': id,
      'dueAt': dueAt.toUtc().toIso8601String(),
      'immediate': immediate,
    });
    await _save();
    _status = 'Pausa pendiente de confirmación en Omarchy.';
    notifyListeners();
  }

  @override
  Future<void> cancelPending() async {
    _queue.clear();
    await _save();
    _status = 'Programaciones pendientes retiradas.';
    notifyListeners();
  }

  Future<void> _save() => _storage.setString(_queueKey, jsonEncode(_queue));

  Future<Object?> _handleNative(MethodCall call) async {
    if (call.method == 'lanSnapshot') {
      return jsonEncode({'schedules': _queue});
    }
    if (call.method == 'lanApply') {
      try {
        final data =
            jsonDecode(call.arguments as String) as Map<String, dynamic>;
        final accepted = (data['accepted'] as List<dynamic>? ?? [])
            .whereType<String>()
            .toSet();
        final expired = (data['expired'] as List<dynamic>? ?? [])
            .whereType<String>()
            .toSet();
        final events = data['events'] as List<dynamic>? ?? [];
        final acknowledged = <String>[];
        for (final raw in events) {
          if (raw is! Map<String, dynamic>) continue;
          final id = raw['id'];
          final kind = raw['kind'];
          final at = raw['at'];
          if (id is! String || kind is! String || at is! String) continue;
          final index = InteractionKind.values.indexWhere(
            (entry) => entry.name == kind,
          );
          final date = DateTime.tryParse(at);
          if (index < 0 || date == null) continue;
          final saved = await _history.recordRemote(
            id,
            InteractionKind.values[index],
            date,
          );
          if (!saved) throw StateError('No se pudo guardar la interacción.');
          acknowledged.add(id);
        }
        _queue.removeWhere(
          (item) =>
              accepted.contains(item['id']) || expired.contains(item['id']),
        );
        await _save();
        _confirmed = 'Omarchy';
        _status = expired.isNotEmpty
            ? 'Una pausa venció antes de sincronizarse. Elige una hora nueva.'
            : accepted.isNotEmpty
            ? 'Pausa confirmada en Omarchy.'
            : 'Conectado con Omarchy.';
        notifyListeners();
        return jsonEncode({'acknowledged': acknowledged});
      } catch (_) {
        return jsonEncode({'error': 'sync_failed'});
      }
    }
    return null;
  }

  @override
  Future<void> startService() async {}
  @override
  Future<void> recordSession(String id, String kind) async {}

  @override
  void dispose() {
    _channel.setMethodCallHandler(null);
    super.dispose();
  }
}
