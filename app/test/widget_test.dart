import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nikucode_senales/app_preferences.dart';
import 'package:nikucode_senales/main.dart';
import 'package:nikucode_senales/pause_view_model.dart';
import 'package:nikucode_senales/reminder_channel.dart';
import 'package:nikucode_senales/reminder_channel_stub.dart';

class _FakeChannel extends ReminderChannel {
  _FakeChannel({this.permission = true});

  final bool permission;
  void Function(int)? callback;

  @override
  bool get supported => true;
  @override
  String get scopeLabel => 'Canal de prueba';
  @override
  set onOpen(void Function(int)? value) => callback = value;
  @override
  Future<bool> requestPermission() async => permission;
  @override
  Future<void> show(int invitationId) async {}
  @override
  Future<void> cancel() async {}
  @override
  void dispose() => callback = null;
}

Future<void> _mountApp(WidgetTester tester, PauseViewModel model) async {
  final preferences = AppPreferencesController.memory();
  await preferences.setReduceMotion(true);
  await tester.pumpWidget(PauseApp(viewModel: model, preferences: preferences));
}

void main() {
  for (final width in [390.0, 1200.0]) {
    testWidgets('recorrido de pausa y salida en ancho $width', (tester) async {
      tester.view.physicalSize = Size(width, 1100);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final model = PauseViewModel(channel: UnavailableReminderChannel());
      await _mountApp(tester, model);

      await tester.tap(find.text('Ver una pausa'));
      await tester.pumpAndSettle();
      expect(find.text('Caminar un momento'), findsOneWidget);
      expect(find.textContaining('Si puedes caminar'), findsOneWidget);

      await tester.ensureVisible(find.text('Cambiar propuesta'));
      await tester.tap(find.text('Cambiar propuesta'));
      await tester.pumpAndSettle();
      expect(find.text('Tu movimiento habitual'), findsOneWidget);
      expect(
        find.textContaining('Elige un movimiento que ya conozcas'),
        findsOneWidget,
      );

      await tester.tap(find.text('Empezar'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Si este momento te sirve'), findsOneWidget);
      expect(find.textContaining('dejar la pantalla'), findsOneWidget);
      await tester.ensureVisible(find.text('Detener y volver'));
      await tester.tap(find.text('Detener y volver'));
      await tester.pumpAndSettle();
      expect(find.text('Guía detenida'), findsOneWidget);
      expect(find.text('Volver a mi tarea'), findsOneWidget);
      await tester.tap(find.text('Volver a mi tarea'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Ver una pausa'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Ahora no'));
      await tester.tap(find.text('Ahora no'));
      await tester.pumpAndSettle();
      expect(model.stage, PauseStage.home);
      expect(find.text('Ver una pausa'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('guía de caminar mantiene la indicación condicional', (
    tester,
  ) async {
    final model = PauseViewModel(channel: UnavailableReminderChannel());
    await _mountApp(tester, model);
    model.openProposal();
    await tester.pumpAndSettle();
    model.startGuide();
    await tester.pumpAndSettle();
    expect(find.textContaining('Si sigue siendo adecuado'), findsOneWidget);
    expect(find.text('Cerrar guía'), findsOneWidget);
    expect(find.text('Detener y volver'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Configurar aviso solo abre ajustes, no programa', (
    tester,
  ) async {
    final model = PauseViewModel(channel: _FakeChannel());
    await _mountApp(tester, model);
    model.openProposal();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Configurar aviso'));
    await tester.tap(find.text('Configurar aviso'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(model.stage, PauseStage.proposal);
    expect(model.hasPendingReminder, isFalse);
    expect(model.reminderAt, isNull);
    await tester.tap(find.text('Cerrar'));
    await tester.pumpAndSettle();
    expect(model.stage, PauseStage.proposal);
    expect(model.hasPendingReminder, isFalse);
  });

  testWidgets('permiso denegado no confirma ni programa; pausa manual sigue', (
    tester,
  ) async {
    final model = PauseViewModel(channel: _FakeChannel(permission: false));
    await _mountApp(tester, model);
    await tester.tap(find.text('Avisos, si los quieres'));
    await tester.pumpAndSettle();
    final toggle = tester.widget<Switch>(find.byType(Switch));
    toggle.onChanged!(true);
    await tester.pumpAndSettle();

    expect(model.remindersEnabled, isFalse);
    expect(model.hasPendingReminder, isFalse);
    expect(find.textContaining('Sin permiso'), findsAtLeastNWidgets(1));
    await tester.tap(find.text('Cerrar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ver una pausa'));
    await tester.pumpAndSettle();
    expect(model.stage, PauseStage.proposal);
    expect(find.text('Caminar un momento'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('canal ausente deja disponible el recorrido manual', (
    tester,
  ) async {
    await _mountApp(
      tester,
      PauseViewModel(channel: UnavailableReminderChannel()),
    );
    await tester.tap(find.text('Avisos, si los quieres'));
    await tester.pumpAndSettle();
    expect(tester.widget<Switch>(find.byType(Switch)).onChanged, isNull);
    expect(find.textContaining('no está disponible'), findsOneWidget);
    await tester.tap(find.text('Cerrar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ver una pausa'));
    await tester.pumpAndSettle();
    expect(find.text('Caminar un momento'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('texto ampliado al 200% conserva salida y configuración', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await _mountApp(
      tester,
      PauseViewModel(channel: UnavailableReminderChannel()),
    );
    await tester.ensureVisible(find.text('Avisos, si los quieres'));
    await tester.tap(find.text('Avisos, si los quieres'));
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
