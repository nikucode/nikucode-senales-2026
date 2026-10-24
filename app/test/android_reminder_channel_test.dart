import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nikucode_senales/pause_view_model.dart';
import 'package:nikucode_senales/reminder_channel_io.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const methodChannel = MethodChannel('cl.nikucode/reminders');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  tearDown(() {
    messenger.setMockMethodCallHandler(methodChannel, null);
  });

  test('concurrent permission requests share one native response', () async {
    final permission = Completer<Object?>();
    var requests = 0;
    messenger.setMockMethodCallHandler(methodChannel, (call) async {
      if (call.method == 'requestPermission') {
        requests++;
        return permission.future;
      }
      return null;
    });
    final model = PauseViewModel(channel: AndroidReminderChannel());
    final first = model.setRemindersEnabled(true);
    final second = model.setRemindersEnabled(true);
    await Future<void>.delayed(Duration.zero);
    expect(requests, 1);
    permission.complete(true);
    await Future.wait([first, second]);
    expect(model.remindersEnabled, isTrue);
    model.dispose();
    await Future<void>.delayed(Duration.zero);
  });

  test('malformed permission response is not a grant', () async {
    messenger.setMockMethodCallHandler(methodChannel, (call) async {
      return call.method == 'requestPermission' ? 'true' : null;
    });
    final channel = AndroidReminderChannel();
    addTearDown(channel.dispose);
    expect(await channel.requestPermission(), isFalse);
  });

  test(
    'native-validated warm event can reach a newly created model once',
    () async {
      messenger.setMockMethodCallHandler(methodChannel, (call) async => null);
      final model = PauseViewModel(channel: AndroidReminderChannel());
      await Future<void>.delayed(Duration.zero);
      final event = methodChannel.codec.encodeMethodCall(
        const MethodCall('reminderOpened', 7301),
      );
      await messenger.handlePlatformMessage(methodChannel.name, event, (_) {});
      expect(model.stage, PauseStage.proposal);
      expect(model.remindersEnabled, isFalse);
      model.dismissProposal();
      await messenger.handlePlatformMessage(methodChannel.name, event, (_) {});
      expect(model.stage, PauseStage.home);
      expect(model.activity.proposalsOpened, 1);
      model.dispose();
      await Future<void>.delayed(Duration.zero);
    },
  );

  for (final operation in ['cancel', 'replace', 'dispose']) {
    test('late initial lookup is ignored after $operation', () async {
      final initialResult = Completer<Object?>();
      messenger.setMockMethodCallHandler(methodChannel, (call) async {
        if (call.method == 'consumeInitialReminder') {
          return initialResult.future;
        }
        return null;
      });
      final channel = AndroidReminderChannel();
      addTearDown(channel.dispose);
      final received = <int>[];
      channel.onValidatedOpen = received.add;
      await Future<void>.delayed(Duration.zero);
      switch (operation) {
        case 'cancel':
          await channel.cancel();
        case 'replace':
          await channel.show(7202);
        case 'dispose':
          channel.dispose();
      }
      initialResult.complete(7201);
      await Future<void>.delayed(Duration.zero);
      expect(received, isEmpty);
    });
  }

  test(
    'cancel clears IDs already buffered before the model is ready',
    () async {
      messenger.setMockMethodCallHandler(methodChannel, (call) async {
        return call.method == 'consumeInitialReminder' ? 7203 : null;
      });
      final channel = AndroidReminderChannel();
      addTearDown(channel.dispose);
      await Future<void>.delayed(Duration.zero);
      await messenger.handlePlatformMessage(
        methodChannel.name,
        methodChannel.codec.encodeMethodCall(
          const MethodCall('reminderOpened', 7204),
        ),
        (_) {},
      );
      await channel.cancel();
      final received = <int>[];
      channel.onValidatedOpen = received.add;
      expect(received, isEmpty);
    },
  );

  for (final failure in ['platform', 'missing', 'malformed']) {
    test(
      'initial lookup $failure failure leaves manual opening usable',
      () async {
        messenger.setMockMethodCallHandler(methodChannel, (call) async {
          if (call.method != 'consumeInitialReminder') return null;
          if (failure == 'platform') {
            throw PlatformException(code: 'validation_failed');
          }
          if (failure == 'missing') throw MissingPluginException();
          return 'not-an-id';
        });
        final model = PauseViewModel(channel: AndroidReminderChannel());
        await Future<void>.delayed(Duration.zero);
        expect(model.stage, PauseStage.home);
        expect(model.message, contains('No se pudo comprobar la invitación'));
        model.openProposal();
        expect(model.stage, PauseStage.proposal);
        expect(model.activity.proposalsOpened, 1);
        model.dispose();
        await Future<void>.delayed(Duration.zero);
      },
    );
  }

  test(
    'initial intent is buffered until the model callback is ready',
    () async {
      final initialResult = Completer<int?>();
      messenger.setMockMethodCallHandler(methodChannel, (call) {
        expect(call.method, 'consumeInitialReminder');
        return initialResult.future;
      });

      final channel = AndroidReminderChannel();
      addTearDown(channel.dispose);
      await Future<void>.delayed(Duration.zero);
      initialResult.complete(7101);
      await Future<void>.delayed(Duration.zero);

      final received = <int>[];
      channel.onValidatedOpen = received.add;
      expect(received, [7101]);

      // A consumed initial intent cannot be emitted to the callback twice.
      channel.onValidatedOpen = received.add;
      expect(received, [7101]);
    },
  );

  test('initial lookup with no valid invitation opens nothing', () async {
    messenger.setMockMethodCallHandler(methodChannel, (call) async {
      expect(call.method, 'consumeInitialReminder');
      return null;
    });

    final channel = AndroidReminderChannel();
    addTearDown(channel.dispose);
    final received = <int>[];
    channel.onValidatedOpen = received.add;
    await Future<void>.delayed(Duration.zero);

    expect(received, isEmpty);
  });

  test(
    'onNewIntent bridge event is queued and delivered once to its callback',
    () async {
      messenger.setMockMethodCallHandler(methodChannel, (call) async => null);
      final channel = AndroidReminderChannel();
      addTearDown(channel.dispose);
      await Future<void>.delayed(Duration.zero);

      final data = methodChannel.codec.encodeMethodCall(
        const MethodCall('reminderOpened', 7102),
      );
      await messenger.handlePlatformMessage(methodChannel.name, data, (_) {});

      final received = <int>[];
      channel.onValidatedOpen = received.add;
      expect(received, [7102]);
      channel.onValidatedOpen = received.add;
      expect(received, [7102]);
    },
  );
}
