import 'dart:io';

import 'interaction_history.dart';
import 'lan_android.dart';
import 'lan_linux.dart';
import 'lan_pause.dart';

Future<LanPause> createLanPause(InteractionHistory history) async =>
    Platform.isAndroid
    ? await AndroidLanPause.load(history)
    : Platform.isLinux
    ? await LinuxLanPause.load()
    : NoLanPause();
