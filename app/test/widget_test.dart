import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nikucode_senales/app_preferences.dart';
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
          preferences: AppPreferencesController.memory(),
        ),
      );
      await tester.tap(find.text('Ver una pausa'));
      await tester.pumpAndSettle();
      expect(find.text('Caminar un momento'), findsOneWidget);
      await tester.ensureVisible(find.text('Cambiar propuesta'));
      await tester.tap(find.text('Cambiar propuesta'));
      await tester.pump();
      expect(find.text('Tu movimiento habitual'), findsOneWidget);
      await tester.tap(find.text('Empezar guía'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Puedes dejar la pantalla'), findsOneWidget);
      await tester.ensureVisible(find.text('Detener guía').last);
      await tester.tap(find.text('Detener guía').last);
      await tester.pumpAndSettle();
      expect(find.text('Guía detenida'), findsOneWidget);
      await tester.tap(find.text('Volver al inicio'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Ver una pausa'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Ahora no'));
      await tester.tap(find.text('Ahora no'));
      await tester.pumpAndSettle();
      expect(find.text('Ver una pausa'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('menu orgánico abre perfil, panorama y pausa', (tester) async {
    tester.view.physicalSize = const Size(390, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      PauseApp(
        viewModel: PauseViewModel(channel: UnavailableReminderChannel()),
        preferences: AppPreferencesController.memory(),
      ),
    );

    await tester.tap(find.byKey(const Key('radialMenuButton')));
    await tester.pumpAndSettle();
    expect(find.text('Pausa ahora'), findsOneWidget);
    expect(find.text('Mi panorama'), findsOneWidget);
    expect(find.text('Mi espacio'), findsOneWidget);

    await tester.tap(find.byKey(const Key('radialAction3')));
    await tester.pumpAndSettle();
    expect(find.text('Interacciones de esta sesión'), findsOneWidget);
    expect(find.text('No conectado en esta demo.'), findsNothing);
    expect(find.textContaining('No conectado en esta demo'), findsOneWidget);
    await tester.ensureVisible(find.text('Cerrar panorama'));
    await tester.tap(find.text('Cerrar panorama'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('radialMenuButton')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('radialAction2')));
    await tester.pumpAndSettle();
    expect(find.text('Caminar un momento'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('perfil local y preferencias se editan sin cuenta', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final preferences = AppPreferencesController.memory();
    await tester.pumpWidget(
      PauseApp(
        viewModel: PauseViewModel(channel: UnavailableReminderChannel()),
        preferences: preferences,
      ),
    );

    await tester.tap(find.byKey(const Key('profileButton')));
    await tester.pumpAndSettle();
    expect(find.textContaining('solo en este dispositivo'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('nicknameField')), 'Javi');
    await tester.tap(find.text('Guardar en este dispositivo'));
    await tester.pumpAndSettle();
    expect(preferences.nickname, 'Javi');

    await tester.tap(find.byKey(const Key('settingsButton')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('reduceMotionSwitch')));
    await tester.pump();
    expect(preferences.reduceMotion, isTrue);
    await tester.tap(find.text('Listo'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

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
        preferences: AppPreferencesController.memory(),
      ),
    );
    await tester.tap(find.byKey(const Key('radialMenuButton')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Preparar aviso'));
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
