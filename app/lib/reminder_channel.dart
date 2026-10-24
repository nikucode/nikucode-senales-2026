/// An invitation transport. It does not measure posture or movement.
abstract class ReminderChannel {
  bool get supported;
  String get scopeLabel;
  set onOpen(void Function(int invitationId)? callback);

  /// Receives a native-validated invitation from the Activity's launch intent.
  /// Other transports do not expose a cold-start notification intent.
  set onInitialOpen(void Function(int invitationId)? callback) {}

  Future<bool> requestPermission();
  Future<void> show(int invitationId);
  Future<void> cancel();
  void dispose();
}
