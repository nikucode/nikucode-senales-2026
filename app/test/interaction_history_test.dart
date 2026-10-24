import 'package:flutter_test/flutter_test.dart';
import 'package:nikucode_senales/interaction_history.dart';

void main() {
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
}
