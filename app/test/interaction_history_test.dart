import 'package:flutter_test/flutter_test.dart';
import 'package:nikucode_senales/interaction_history.dart';
// These are the async test-platform APIs used by shared_preferences itself.
// ignore: depend_on_referenced_packages
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  late InMemorySharedPreferencesAsync preferencesStore;

  setUp(() {
    preferencesStore = InMemorySharedPreferencesAsync.empty();
    SharedPreferencesAsyncPlatform.instance = preferencesStore;
  });

  tearDown(() {
    SharedPreferencesAsyncPlatform.instance = null;
  });

  test('agrupa por semana local y conserva categorías distintas', () async {
    var now = DateTime(2026, 10, 25, 23, 59); // Domingo.
    final history = InteractionHistory.memory(now: () => now);
    history.record(InteractionKind.proposalOpened);
    history.record(InteractionKind.dismissed);
    now = DateTime(2026, 10, 26, 0, 1); // Lunes.
    history.record(InteractionKind.proposalOpened);
    history.record(InteractionKind.guideStarted);

    expect(
      history.totalsForWeek(
        InteractionHistory.weekStart(DateTime(2026, 10, 25)),
      ),
      [1, 0, 0, 0, 0, 1],
    );
    expect(history.totalsForWeek(InteractionHistory.weekStart(now)), [
      1,
      1,
      0,
      0,
      0,
      0,
    ]);
    await history.clear();
    expect(history.totalsForWeek(InteractionHistory.weekStart(now)), [
      0,
      0,
      0,
      0,
      0,
      0,
    ]);
    history.dispose();
  });

  test('un resultado remoto se cuenta una vez en su fecha real', () async {
    final history = InteractionHistory.memory(
      now: () => DateTime(2026, 10, 26),
    );
    final at = DateTime(2026, 10, 23, 19, 30);
    expect(
      await history.recordRemote(
        'pausa-1:final',
        InteractionKind.guideFinished,
        at,
      ),
      isTrue,
    );
    expect(
      await history.recordRemote(
        'pausa-1:final',
        InteractionKind.guideFinished,
        at,
      ),
      isTrue,
    );
    expect(history.totalsForWeek(InteractionHistory.weekStart(at)), [
      0,
      0,
      1,
      0,
      0,
      0,
    ]);
    expect(
      history.totalsForWeek(
        InteractionHistory.weekStart(DateTime(2026, 10, 26)),
      ),
      [0, 0, 0, 0, 0, 0],
    );
    history.dispose();
  });

  test('guarda y vuelve a cargar los conteos semanales', () async {
    final monday = DateTime(2026, 10, 26);
    final history = await InteractionHistory.load(now: () => monday);
    addTearDown(history.dispose);

    history.record(InteractionKind.proposalOpened);
    history.record(InteractionKind.guideStarted);
    await history.flush();

    final reloaded = await InteractionHistory.load(now: () => monday);
    addTearDown(reloaded.dispose);
    expect(reloaded.totalsForWeek(InteractionHistory.weekStart(monday)), [
      1,
      1,
      0,
      0,
      0,
      0,
    ]);
  });

  test('deduplica un resultado remoto después de volver a cargar', () async {
    final monday = DateTime(2026, 10, 26);
    final occurredAt = DateTime(2026, 10, 23, 19, 30);
    final history = await InteractionHistory.load(now: () => monday);
    addTearDown(history.dispose);

    expect(
      await history.recordRemote(
        'pausa-persistida:final',
        InteractionKind.guideFinished,
        occurredAt,
      ),
      isTrue,
    );
    await history.flush();

    final reloaded = await InteractionHistory.load(now: () => monday);
    addTearDown(reloaded.dispose);
    expect(
      await reloaded.recordRemote(
        'pausa-persistida:final',
        InteractionKind.guideFinished,
        occurredAt,
      ),
      isTrue,
    );
    expect(reloaded.totalsForWeek(InteractionHistory.weekStart(occurredAt)), [
      0,
      0,
      1,
      0,
      0,
      0,
    ]);
  });

  test('borrar elimina los conteos al volver a cargar', () async {
    final monday = DateTime(2026, 10, 26);
    final history = await InteractionHistory.load(now: () => monday);
    addTearDown(history.dispose);

    history.record(InteractionKind.dismissed);
    await history.flush();
    await history.clear();

    final reloaded = await InteractionHistory.load(now: () => monday);
    addTearDown(reloaded.dispose);
    expect(reloaded.totalsForWeek(InteractionHistory.weekStart(monday)), [
      0,
      0,
      0,
      0,
      0,
      0,
    ]);
  });
}
