import 'package:flutter/foundation.dart';

class LanPairingInfo {
  const LanPairingInfo({
    required this.address,
    required this.port,
    required this.code,
    required this.pin,
  });
  final String address;
  final int port;
  final String code;
  final String pin;
}

class LanDesktop {
  const LanDesktop(this.id, this.name);
  final String id;
  final String name;
}

/// The connection is optional; local pause controls remain available.
abstract class LanPause extends ChangeNotifier {
  bool get available;
  bool get isPhone;
  bool get paired;
  bool get canSchedule;
  String get status;
  String? get pendingLabel;
  List<LanDesktop> get desktops => const [];
  String? get verificationCode => null;
  bool get pairingPending => false;
  bool get confirming => false;
  bool get serviceRunning => true;
  DateTime? get sharedReminderAt => null;
  int? get sharedReminderId => null;
  Future<void> scanDesktops() async {}
  Future<void> stopScan() async {}
  Future<void> requestPair(String id) async {}
  Future<void> confirmPair() async {}
  Future<void> rejectPair() async {}
  Future<LanPairingInfo?> pairingInfo();
  Future<void> pair(String address, int port, String code, String pin);
  Future<void> unpair();
  Future<void> schedule(Duration delay);
  Future<void> scheduleSharedReminder(DateTime dueAt, int invitationId) async {}
  Future<void> startNow();
  Future<void> cancelPending();
  Future<void> startService();
  void Function(String id)? onStartPause;
  void Function()? onPairingRequested;
  Future<void> recordSession(String id, String kind);
}

class NoLanPause extends LanPause {
  @override
  bool get available => false;
  @override
  bool get isPhone => false;
  @override
  bool get paired => false;
  @override
  bool get canSchedule => false;
  @override
  String get status => 'La conexión local está disponible en Android y Linux.';
  @override
  String? get pendingLabel => null;
  @override
  Future<LanPairingInfo?> pairingInfo() async => null;
  @override
  Future<void> pair(String address, int port, String code, String pin) async {}
  @override
  Future<void> unpair() async {}
  @override
  Future<void> schedule(Duration delay) async {}
  @override
  Future<void> startNow() async {}
  @override
  Future<void> cancelPending() async {}
  @override
  Future<void> startService() async {}
  @override
  Future<void> recordSession(String id, String kind) async {}
}
