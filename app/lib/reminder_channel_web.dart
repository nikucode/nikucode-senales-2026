import 'dart:js_interop';

import 'reminder_channel.dart';

@JS('globalThis.Notification')
external JSAny? get notificationConstructor;

@JS('window.focus')
external void _focusWindow();

@JS('Notification')
extension type _BrowserNotification._(JSObject _) implements JSObject {
  external factory _BrowserNotification(
    JSString title,
    _NotificationOptions options,
  );
  external static JSString get permission;
  external static JSPromise<JSString> requestPermission();
  external set onclick(JSFunction? value);
  external void close();
}

@JS()
extension type _NotificationOptions._(JSObject _) implements JSObject {
  external factory _NotificationOptions({JSString body, JSString tag});
}

ReminderChannel createReminderChannel() => BrowserReminderChannel();

class BrowserReminderChannel extends ReminderChannel {
  _BrowserNotification? _notice;
  void Function(int)? _onOpen;

  @override
  bool get supported => notificationConstructor != null;
  @override
  String get scopeLabel =>
      'Navegador: esta pestaña debe seguir abierta. El sistema puede retrasar '
      'avisos en segundo plano; no funciona con la app cerrada.';
  @override
  set onOpen(void Function(int)? callback) => _onOpen = callback;

  @override
  Future<bool> requestPermission() async {
    if (!supported) return false;
    if (_BrowserNotification.permission.toDart == 'granted') return true;
    return (await _BrowserNotification.requestPermission().toDart).toDart ==
        'granted';
  }

  @override
  Future<void> show(int invitationId) async {
    await cancel();
    if (!supported || _BrowserNotification.permission.toDart != 'granted') {
      throw StateError('No hay permiso de notificaciones.');
    }
    // Some mobile browsers reject this API even with permission. Surface that
    // failure rather than pretending a service worker or local alarm exists.
    final notice = _BrowserNotification(
      '¿Un momento para moverte?'.toJS,
      _NotificationOptions(
        body: 'Hay una propuesta breve. Tú eliges el momento.'.toJS,
        tag: 'nikucode-pausa'.toJS,
      ),
    );
    notice.onclick = (() {
      // Only an explicit click requests focus, never notification arrival.
      _focusWindow();
      _onOpen?.call(invitationId);
    }).toJS;
    _notice = notice;
  }

  @override
  Future<void> cancel() async {
    _notice?.onclick = null;
    _notice?.close();
    _notice = null;
  }

  @override
  void dispose() {
    _notice?.onclick = null;
    _notice?.close();
    _notice = null;
    _onOpen = null;
  }
}
