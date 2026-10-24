import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:nikucode_senales/pause_view_model.dart';
import 'package:nikucode_senales/reminder_channel.dart';

class FakeChannel extends ReminderChannel {
  bool permission = true;
  bool failShow = false;
  bool failPermission = false;
  bool failCancel = false;
  bool available = true;
  Completer<bool>? permissionRequest;
  Completer<void>? showing;
  Completer<void>? cancelling;
  final shown = <int>[];
  int cancellations = 0;
  bool disposed = false;
  void Function(int)? callback;

  @override
  bool get supported => available;
  @override
  String get scopeLabel => 'Canal de prueba: requiere proceso abierto';
  @override
  set onOpen(void Function(int)? value) => callback = value;
  @override
  Future<bool> requestPermission() async {
    if (failPermission) throw StateError('permission failed');
    return permissionRequest?.future ?? permission;
  }

  @override
  Future<void> show(int id) async {
    if (failShow) throw StateError('show failed');
    if (showing != null) await showing!.future;
    shown.add(id);
  }

  @override
  Future<void> cancel() async {
    cancellations++;
    if (cancelling != null) await cancelling!.future;
    if (failCancel) throw StateError('cancel failed');
  }

  @override
  void dispose() => disposed = true;
}

void main() {
  testWidgets('native-validated session invitation opens only once', (
    tester,
  ) async {
    final channel = FakeChannel();
    final model = PauseViewModel(channel: channel);
    await model.setRemindersEnabled(true);
    await model.scheduleReminder(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    final id = channel.shown.single;
    model.openFromValidatedReminder(id);
    expect(model.stage, PauseStage.proposal);
    model.dismissProposal();
    model.openFromValidatedReminder(id);
    expect(model.stage, PauseStage.home);
    expect(model.activity.proposalsOpened, 1);
    model.dispose();
    await tester.pump();
  });

  testWidgets('cancellation failure is reported without a success message', (
    tester,
  ) async {
    final channel = FakeChannel();
    final model = PauseViewModel(channel: channel);
    await model.setRemindersEnabled(true);
    await model.scheduleReminder(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    final id = channel.shown.single;
    channel.failCancel = true;

    final cancelling = model.cancelReminder();
    expect(model.message, contains('Se está solicitando'));
    await cancelling;
    expect(model.message, contains('No se pudo confirmar'));
    expect(model.hasPendingReminder, isFalse);
    channel.callback!(id);
    expect(model.stage, PauseStage.home);
    channel.failCancel = false;
    model.dispose();
    await tester.pump();
  });

  testWidgets('failed withdrawal prevents preparing a replacement', (
    tester,
  ) async {
    final channel = FakeChannel()..failCancel = true;
    final model = PauseViewModel(channel: channel);
    await model.setRemindersEnabled(true);
    await model.scheduleReminder(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 2));

    expect(model.hasPendingReminder, isFalse);
    expect(channel.shown, isEmpty);
    expect(model.message, contains('No se preparó otro aviso'));
    model.openProposal();
    expect(model.stage, PauseStage.proposal);
    channel.failCancel = false;
    model.dispose();
    await tester.pump();
  });

  testWidgets('manual opening supersedes scheduling awaiting withdrawal', (
    tester,
  ) async {
    final cancellation = Completer<void>();
    final channel = FakeChannel()..cancelling = cancellation;
    final model = PauseViewModel(channel: channel);
    await model.setRemindersEnabled(true);
    final scheduling = model.scheduleReminder(const Duration(seconds: 1));
    await tester.pump();
    model.openProposal();
    cancellation.complete();
    await scheduling;
    await tester.pump(const Duration(seconds: 2));
    expect(model.stage, PauseStage.proposal);
    expect(model.hasPendingReminder, isFalse);
    expect(channel.shown, isEmpty);
    model.dispose();
    await tester.pump();
  });

  testWidgets('a delayed initial invitation cannot undo a manual choice', (
    tester,
  ) async {
    final model = PauseViewModel(channel: FakeChannel());
    model.openProposal();
    model.dismissProposal();
    model.openFromValidatedReminder(7103);
    expect(model.stage, PauseStage.home);
    expect(model.activity.proposalsOpened, 1);
    model.dispose();
    await tester.pump();
  });

  testWidgets('replacement shows only the latest invitation', (tester) async {
    final channel = FakeChannel();
    final model = PauseViewModel(channel: channel);
    await model.setRemindersEnabled(true);
    await model.scheduleReminder(const Duration(seconds: 2));
    await tester.pump(const Duration(seconds: 1));
    await model.scheduleReminder(const Duration(seconds: 3));
    await tester.pump(const Duration(seconds: 1));
    expect(channel.shown, isEmpty);
    await tester.pump(const Duration(seconds: 2));
    expect(channel.shown, hasLength(1));
    expect(model.hasPendingReminder, isFalse);
    expect(model.reminderAt, isNull);
    model.dispose();
    await tester.pump();
  });

  testWidgets('opening manually cancels the scheduled invitation', (
    tester,
  ) async {
    final channel = FakeChannel();
    final model = PauseViewModel(channel: channel);
    await model.setRemindersEnabled(true);
    await model.scheduleReminder(const Duration(seconds: 2));
    model.openProposal();
    model.goHome();
    await tester.pump(const Duration(seconds: 3));
    expect(channel.shown, isEmpty);
    expect(model.hasPendingReminder, isFalse);
    expect(model.stage, PauseStage.home);
    model.dispose();
    await tester.pump();
  });

  testWidgets('delivered invitation remains valid after its scheduled time', (
    tester,
  ) async {
    final channel = FakeChannel();
    final model = PauseViewModel(channel: channel);
    await model.setRemindersEnabled(true);
    await model.scheduleReminder(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 3));
    channel.callback!(channel.shown.single);
    expect(model.stage, PauseStage.proposal);
    model.dismissProposal();
    channel.callback!(channel.shown.single);
    expect(model.stage, PauseStage.home);
    expect(model.activity.proposalsOpened, 1);
    model.dispose();
    await tester.pump();
  });

  testWidgets(
    'cold-start invitation opens once without enabling future alerts',
    (tester) async {
      final channel = FakeChannel();
      final model = PauseViewModel(channel: channel);

      model.openFromValidatedReminder(7001);
      expect(model.stage, PauseStage.proposal);
      expect(model.remindersEnabled, isFalse);
      expect(model.activity.proposalsOpened, 1);

      model.dismissProposal();
      model.openFromValidatedReminder(7001);
      expect(model.stage, PauseStage.home);
      expect(model.activity.proposalsOpened, 1);
      model.dispose();
      await tester.pump();
    },
  );

  testWidgets('invalid cold-start invitation IDs are ignored', (tester) async {
    final model = PauseViewModel(channel: FakeChannel());
    model.openFromValidatedReminder(0);
    model.openFromValidatedReminder(-1);

    expect(model.stage, PauseStage.home);
    expect(model.activity.proposalsOpened, 0);
    model.dispose();
    await tester.pump();
  });

  testWidgets('cold-start invitation does not interrupt an active guide', (
    tester,
  ) async {
    final channel = FakeChannel();
    final model = PauseViewModel(channel: channel);
    model.openProposal();
    model.startGuide();

    model.openFromValidatedReminder(7002);
    expect(model.stage, PauseStage.guide);
    expect(model.activity.proposalsOpened, 1);
    model.dispose();
    await tester.pump();
  });

  testWidgets('replaced delivered invitation cannot reopen the flow', (
    tester,
  ) async {
    final channel = FakeChannel();
    final model = PauseViewModel(channel: channel);
    await model.setRemindersEnabled(true);
    await model.scheduleReminder(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    final oldId = channel.shown.single;
    await model.scheduleReminder(const Duration(seconds: 2));
    channel.callback!(oldId);
    expect(model.stage, PauseStage.home);
    expect(model.hasPendingReminder, isTrue);
    await model.cancelReminder();
    await tester.pump(const Duration(seconds: 3));
    expect(channel.shown, hasLength(1));
    model.dispose();
    await tester.pump();
  });

  testWidgets('denied permission does not schedule or reenable implicitly', (
    tester,
  ) async {
    final channel = FakeChannel()..permission = false;
    final model = PauseViewModel(channel: channel);
    await model.setRemindersEnabled(true);
    model.openProposal();
    await model.scheduleReminder(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 2));
    expect(model.remindersEnabled, isFalse);
    expect(model.hasPendingReminder, isFalse);
    expect(model.stage, PauseStage.proposal);
    expect(channel.shown, isEmpty);
    expect(model.message, contains('No se programó'));
    expect(model.message, isNot(contains('Aviso preparado')));
    model.dispose();
    await tester.pump();
  });

  testWidgets('disable cancels pending and invalidates delivered actions', (
    tester,
  ) async {
    final channel = FakeChannel();
    final model = PauseViewModel(channel: channel);
    await model.setRemindersEnabled(true);
    await model.scheduleReminder(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    final id = channel.shown.single;
    await model.scheduleReminder(const Duration(seconds: 2));
    await model.setRemindersEnabled(false);
    channel.callback!(id);
    await tester.pump(const Duration(seconds: 3));
    expect(channel.shown, hasLength(1));
    expect(model.stage, PauseStage.home);
    expect(model.hasPendingReminder, isFalse);
    model.dispose();
    await tester.pump();
  });

  testWidgets('show failure is reported without fabricated delivery', (
    tester,
  ) async {
    final channel = FakeChannel()..failShow = true;
    final model = PauseViewModel(channel: channel);
    await model.setRemindersEnabled(true);
    await model.scheduleReminder(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    expect(model.message, contains('No se pudo mostrar'));
    expect(model.hasPendingReminder, isFalse);
    expect(model.stage, PauseStage.home);
    expect(channel.shown, isEmpty);
    expect(model.message, isNot(contains('Se solicitó mostrar')));
    model.dispose();
    await tester.pump();
  });

  testWidgets('unsupported and permission errors do not enable reminders', (
    tester,
  ) async {
    final unsupported = FakeChannel()..available = false;
    final model = PauseViewModel(channel: unsupported);
    await model.setRemindersEnabled(true);
    expect(model.remindersEnabled, isFalse);
    expect(model.message, contains('no tiene un canal'));
    model.dispose();
    final failure = FakeChannel()..failPermission = true;
    final failingModel = PauseViewModel(channel: failure);
    await failingModel.setRemindersEnabled(true);
    expect(failingModel.remindersEnabled, isFalse);
    expect(failingModel.message, contains('No se pudo comprobar'));
    failingModel.dispose();
    await tester.pump();
  });

  testWidgets('late permission completion cannot undo explicit disable', (
    tester,
  ) async {
    final permission = Completer<bool>();
    final channel = FakeChannel()..permissionRequest = permission;
    final model = PauseViewModel(channel: channel);
    final enabling = model.setRemindersEnabled(true);
    await model.setRemindersEnabled(false);
    permission.complete(true);
    await enabling;
    expect(model.remindersEnabled, isFalse);
    model.dispose();
    await tester.pump();
  });

  testWidgets('cancel follows an in-flight show and stale click is ignored', (
    tester,
  ) async {
    final showing = Completer<void>();
    final channel = FakeChannel()..showing = showing;
    final model = PauseViewModel(channel: channel);
    await model.setRemindersEnabled(true);
    await model.scheduleReminder(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    final cancellationsBefore = channel.cancellations;
    model.openProposal();
    showing.complete();
    await tester.pump();
    expect(channel.cancellations, greaterThan(cancellationsBefore));
    model.dismissProposal();
    channel.callback!(channel.shown.single);
    expect(model.stage, PauseStage.home);
    model.dispose();
    await tester.pump();
  });

  testWidgets('flow distinguishes stop and finish without counting activity', (
    tester,
  ) async {
    final channel = FakeChannel();
    final model = PauseViewModel(channel: channel);
    model.openProposal();
    final first = model.proposal;
    model.changeProposal();
    expect(model.proposal, isNot(same(first)));
    model.startGuide();
    expect(model.stage, PauseStage.guide);
    model.openProposal();
    expect(model.stage, PauseStage.guide);
    model.stopGuide();
    expect(model.stage, PauseStage.stopped);
    model.goHome();
    model.openProposal();
    model.startGuide();
    model.finishGuide();
    expect(model.stage, PauseStage.finished);
    model.dispose();
    await tester.pump();
    expect(channel.disposed, isTrue);
    expect(channel.callback, isNull);
  });
}
