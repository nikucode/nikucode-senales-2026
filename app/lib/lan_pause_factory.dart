import 'lan_pause.dart';
import 'lan_pause_factory_stub.dart'
    if (dart.library.io) 'lan_pause_factory_io.dart'
    as implementation;
import 'interaction_history.dart';

Future<LanPause> createLanPause(InteractionHistory history) =>
    implementation.createLanPause(history);
