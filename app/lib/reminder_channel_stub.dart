import 'reminder_channel.dart';

ReminderChannel createReminderChannel() => UnavailableReminderChannel();

class UnavailableReminderChannel extends ReminderChannel {
  @override
  bool get supported => false;
  @override
  String get scopeLabel =>
      'En este destino puedes abrir una pausa manualmente.';
  @override
  set onOpen(void Function(int)? callback) {}
  @override
  Future<bool> requestPermission() async => false;
  @override
  Future<void> show(int invitationId) async {
    throw UnsupportedError('Este canal no está implementado.');
  }

  @override
  Future<void> cancel() async {}
  @override
  void dispose() {}
}
