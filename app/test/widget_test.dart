import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nikucode_senales/main.dart';
import 'package:nikucode_senales/pause_view_model.dart';
import 'package:nikucode_senales/reminder_channel_stub.dart';

void main() {
  for (final width in [390.0, 1200.0]) {
    testWidgets('recorrido completo y rechazo en ancho $width', (tester) async {
      tester.view.physicalSize = Size(width, 1100);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        PauseApp(
          viewModel: PauseViewModel(channel: UnavailableReminderChannel()),
        ),
      );
      await tester.tap(find.text('Ver una pausa'));
      await tester.pump();
      expect(find.text('Caminar un momento'), findsOneWidget);
      await tester.ensureVisible(find.text('Cambiar propuesta'));
      await tester.tap(find.text('Cambiar propuesta'));
      await tester.pump();
      expect(find.text('Tu movimiento habitual'), findsOneWidget);
      await tester.tap(find.text('Empezar guía'));
      await tester.pump();
      expect(find.text('Puedes dejar la pantalla'), findsOneWidget);
      await tester.ensureVisible(find.text('Detener guía'));
      await tester.tap(find.text('Detener guía'));
      await tester.pump();
      expect(find.text('Guía detenida'), findsOneWidget);
      await tester.tap(find.text('Volver al inicio'));
      await tester.pump();
      await tester.ensureVisible(find.text('Ver una pausa'));
      await tester.tap(find.text('Ver una pausa'));
      await tester.pump();
      await tester.ensureVisible(find.text('Ahora no'));
      await tester.tap(find.text('Ahora no'));
      await tester.pump();
      expect(find.text('Ver una pausa'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('texto al 200% y canal ausente permiten salir', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(
      PauseApp(
        viewModel: PauseViewModel(channel: UnavailableReminderChannel()),
      ),
    );
    await tester.ensureVisible(find.text('Preparar un aviso'));
    await tester.tap(find.text('Preparar un aviso'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile)).onChanged,
      isNull,
    );
    await tester.tap(find.text('Cerrar'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
