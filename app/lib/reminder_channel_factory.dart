import 'reminder_channel.dart';
import 'reminder_channel_stub.dart'
    if (dart.library.io) 'reminder_channel_io.dart'
    if (dart.library.js_interop) 'reminder_channel_web.dart'
    as platform;

ReminderChannel createReminderChannel() => platform.createReminderChannel();
