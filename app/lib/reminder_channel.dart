/// An invitation transport. It does not measure posture or movement.
abstract class ReminderChannel {
  bool get supported;
  String get scopeLabel;
  set onOpen(void Function(int invitationId)? callback);
  Future<bool> requestPermission();
  Future<void> show(int invitationId);
  Future<void> cancel();
  void dispose();
}
