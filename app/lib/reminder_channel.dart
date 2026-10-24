/// An invitation transport. It does not measure posture or movement.
abstract class ReminderChannel {
  bool get supported;
  String get scopeLabel;
  set onOpen(void Function(int invitationId)? callback);

  /// Receives an invitation already validated by the Android transport, from
  /// either the initial intent or a resumed Activity's intent.
  set onValidatedOpen(void Function(int invitationId)? callback) {}

  /// Reports a failed native invitation lookup without blocking manual use.
  set onOpenError(void Function()? callback) {}

  Future<bool> requestPermission();
  Future<void> show(int invitationId);
  Future<void> cancel();
  void dispose();
}
