import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nikucode_senales/reminder_channel_io.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const methodChannel = MethodChannel('cl.nikucode/reminders');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  tearDown(() {
    messenger.setMockMethodCallHandler(methodChannel, null);
  });

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
      channel.onInitialOpen = received.add;
      expect(received, [7101]);

      // A consumed initial intent cannot be emitted to the callback twice.
      channel.onInitialOpen = received.add;
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
    channel.onInitialOpen = received.add;
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
      channel.onOpen = received.add;
      expect(received, [7102]);
      channel.onOpen = received.add;
      expect(received, [7102]);
    },
  );
}
