import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import 'reminder_channel.dart';
import 'reminder_channel_stub.dart';

ReminderChannel createReminderChannel() => switch (Platform.operatingSystem) {
  'android' => AndroidReminderChannel(),
  'linux' => LinuxReminderChannel(),
  _ => UnavailableReminderChannel(),
};

/// Android notifications while the app session is active.
class AndroidReminderChannel extends ReminderChannel {
  static const _methodChannel = MethodChannel('cl.nikucode/reminders');
  void Function(int)? _onValidatedOpen;
  void Function()? _onOpenError;
  int? _queuedValidatedId;
  bool _queuedOpenError = false;
  bool _disposed = false;
  int _invitationRevision = 0;

  AndroidReminderChannel() {
    _methodChannel.setMethodCallHandler(_handleNativeCall);
    unawaited(_loadInitialReminder());
  }

  Future<void> _loadInitialReminder() async {
    final revision = _invitationRevision;
    try {
      final id = await _methodChannel.invokeMethod<Object?>(
        'consumeInitialReminder',
      );
      if (_disposed || revision != _invitationRevision) return;
      if (id == null) return;
      if (id is! int || id <= 0) {
        _deliverOpenError();
        return;
      }
      _deliverValidatedOpen(id);
    } on PlatformException {
      if (!_disposed && revision == _invitationRevision) _deliverOpenError();
    } on MissingPluginException {
      if (!_disposed && revision == _invitationRevision) _deliverOpenError();
    }
  }

  void _deliverOpenError() {
    if (_disposed) return;
    final callback = _onOpenError;
    if (callback == null) {
      _queuedOpenError = true;
    } else {
      callback();
    }
  }

  void _invalidateQueuedInvitations() {
    _invitationRevision++;
    _queuedValidatedId = null;
    _queuedOpenError = false;
  }

  void _deliverValidatedOpen(int id) {
    final callback = _onValidatedOpen;
    if (callback == null) {
      _queuedValidatedId ??= id;
    } else {
      callback(id);
    }
  }

  Future<Object?> _handleNativeCall(MethodCall call) async {
    if (_disposed) return null;
    if (call.method == 'reminderOpened') {
      final id = call.arguments;
      if (id is int && id > 0) {
        _deliverValidatedOpen(id);
      } else {
        _deliverOpenError();
      }
    } else if (call.method == 'reminderOpenFailed') {
      _deliverOpenError();
    }
    return null;
  }

  @override
  bool get supported => true;

  @override
  String get scopeLabel =>
      'Android: el temporizador requiere que la app siga abierta y puede '
      'retrasarse al suspenderla. Una invitación ya publicada puede abrirse '
      'al tocarla; la entrega depende del sistema.';

  @override
  // Android uses the callback for native-validated IDs, including warm taps.
  set onOpen(void Function(int)? callback) {}

  @override
  set onValidatedOpen(void Function(int)? callback) {
    _onValidatedOpen = callback;
    final id = _queuedValidatedId;
    if (callback != null && id != null) {
      _queuedValidatedId = null;
      callback(id);
    }
  }

  @override
  set onOpenError(void Function()? callback) {
    _onOpenError = callback;
    if (!_disposed && callback != null && _queuedOpenError) {
      _queuedOpenError = false;
      callback();
    }
  }

  @override
  Future<bool> requestPermission() async {
    try {
      return await _methodChannel.invokeMethod<bool>('requestPermission') ??
          false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  @override
  Future<void> show(int invitationId) {
    _invalidateQueuedInvitations();
    return _methodChannel.invokeMethod<void>('showReminder', invitationId);
  }

  @override
  Future<void> cancel() {
    _invalidateQueuedInvitations();
    return _methodChannel.invokeMethod<void>('cancelReminders');
  }

  @override
  void dispose() {
    _disposed = true;
    _onValidatedOpen = null;
    _onOpenError = null;
    _invalidateQueuedInvitations();
    _methodChannel.setMethodCallHandler(null);
  }
}

/// Desktop notifications while this process is alive. No background daemon,
/// persistence, exact alarm, or focus change is implied.
class LinuxReminderChannel extends ReminderChannel {
  Process? _process;
  int? _notificationId;
  void Function(int)? _onOpen;
  int _operation = 0;

  @override
  bool get supported =>
      File('/usr/bin/notify-send').existsSync() &&
      File('/usr/bin/busctl').existsSync();
  @override
  String get scopeLabel =>
      'Escritorio Linux: requiere esta app abierta y un servidor de avisos. '
      'Cerrar detiene la programación; suspender puede retrasar la señal. '
      'Al tocar el aviso se solicita abrir la ventana; si el sistema no lo permite, vuelve a la app. '
      'Preferencias solo de sesión.';
  @override
  set onOpen(void Function(int)? callback) => _onOpen = callback;

  @override
  Future<bool> requestPermission() async {
    if (!supported) return false;
    final result = await Process.run('/usr/bin/busctl', const [
      '--user',
      '--timeout=3s',
      'call',
      'org.freedesktop.Notifications',
      '/org/freedesktop/Notifications',
      'org.freedesktop.Notifications',
      'GetCapabilities',
    ]);
    // An unavailable session bus is not a granted permission.
    return result.exitCode == 0 && result.stdout.toString().contains('actions');
  }

  @override
  Future<void> show(int invitationId) async {
    await cancel();
    final operation = _operation;
    final process = await Process.start('/usr/bin/notify-send', const [
      '--print-id',
      '--wait',
      '--expire-time=15000',
      '--app-name=nikucode',
      '--action=open=Ver pausa',
      '¿Un momento para moverte?',
      'Hay una propuesta breve. Tú eliges el momento.',
    ]);
    _process = process;
    final ready = Completer<void>();
    process.stderr.drain<void>();
    process.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(
          (line) {
            final id = int.tryParse(line.trim());
            if (id != null && operation == _operation) {
              _notificationId = id;
              if (!ready.isCompleted) ready.complete();
            } else if (line.trim() == 'open' && operation == _operation) {
              unawaited(_presentAndOpen(invitationId, operation));
            }
          },
          onError: (Object error) {
            if (!ready.isCompleted) ready.completeError(error);
          },
        );
    unawaited(
      process.exitCode.then((code) {
        if (!ready.isCompleted) {
          ready.completeError(StateError('El servidor no confirmó el aviso.'));
        }
        if (identical(_process, process)) _process = null;
      }),
    );
    try {
      await ready.future.timeout(const Duration(seconds: 4));
    } catch (_) {
      await cancel();
      rethrow;
    }
  }

  Future<void> _presentAndOpen(int invitationId, int operation) async {
    try {
      await const MethodChannel('cl.nikucode/desktop')
          .invokeMethod<void>('present');
    } on PlatformException {
      // A desktop policy can deny activation. The proposal remains available
      // when the person returns manually; do not force focus on arrival.
    } on MissingPluginException {
      // The interface still works when hosted without the Linux runner.
    }
    if (operation == _operation) _onOpen?.call(invitationId);
  }

  @override
  Future<void> cancel() async {
    _operation++;
    final id = _notificationId;
    _notificationId = null;
    final process = _process;
    _process = null;
    try {
      if (id != null) {
        final result = await Process.run('/usr/bin/busctl', [
          '--user',
          '--timeout=3s',
          'call',
          'org.freedesktop.Notifications',
          '/org/freedesktop/Notifications',
          'org.freedesktop.Notifications',
          'CloseNotification',
          'u',
          '$id',
        ]);
        if (result.exitCode != 0) {
          throw StateError('No se pudo confirmar la retirada del aviso.');
        }
      }
    } finally {
      process?.kill();
    }
  }

  @override
  void dispose() {
    _onOpen = null;
    unawaited(cancel().catchError((Object _) {}));
  }
}
