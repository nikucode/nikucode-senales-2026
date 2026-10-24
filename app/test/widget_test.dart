import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nikucode_senales/app_preferences.dart';
import 'package:nikucode_senales/app_usage.dart';
import 'package:nikucode_senales/lan_pause.dart';
import 'package:nikucode_senales/main.dart';
import 'package:nikucode_senales/marea_tools.dart';
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

class _FakeUsage extends AppUsageGateway {
  DateTime? lastMonday;

  @override
  bool get supported => true;

  @override
  Future<bool> hasAccess() async => true;

  @override
  Future<List<DailyAppUsage>> loadWeek(DateTime monday) async {
    lastMonday = monday;
    return [
      for (var index = 0; index < 7; index++)
        DailyAppUsage(
          date: DateTime(monday.year, monday.month, monday.day + index),
          apps: index == 0
              ? const [
                  AppUsageEntry(
                    packageName: 'example.app',
                    label: 'App de prueba',
                    milliseconds: Duration.millisecondsPerHour,
                  ),
                ]
              : const [],
        ),
    ];
  }
}

Future<void> _mountApp(
  WidgetTester tester,
  PauseViewModel model, {
  AppPreferencesController? preferences,
  LanPause? lan,
}) async {
  final controller = preferences ?? AppPreferencesController.memory();
  await controller.setReduceMotion(true);
  await tester.pumpWidget(
    PauseApp(viewModel: model, preferences: controller, lan: lan),
  );
}

class _FakeDesktopLanPause extends LanPause {
  final recorded = <String>[];

  @override
  bool get available => true;
  @override
  bool get isPhone => false;
  @override
  bool get paired => true;
  @override
  bool get canSchedule => false;
  @override
  String get status => 'Conectado';
  @override
  String? get pendingLabel => null;
  @override
  Future<LanPairingInfo?> pairingInfo() async => null;
  @override
  Future<void> pair(String address, int port, String code, String pin) async {}
  @override
  Future<void> unpair() async {}
  @override
  Future<void> schedule(Duration delay) async {}
  @override
  Future<void> startNow() async {}
  @override
  Future<void> cancelPending() async {}
  @override
  Future<void> startService() async {}
  @override
  Future<void> recordSession(String id, String kind) async {
    recorded.add('$id:$kind');
  }
}

void main() {
  testWidgets('Mi panorama selecciona día y cambia de semana', (tester) async {
    final model = PauseViewModel(channel: UnavailableReminderChannel());
    final preferences = AppPreferencesController.memory();
    final usage = _FakeUsage();
    await _mountApp(tester, model, preferences: preferences);
    final context = tester.element(find.text('Ver una pausa'));
    showMareaPanorama(context, model, preferences, usage: usage);
    await tester.pumpAndSettle();

    expect(find.text('Tiempo de uso de apps'), findsOneWidget);
    await tester.tap(find.text('L').last);
    await tester.pumpAndSettle();
    expect(find.text('App de prueba'), findsOneWidget);
    expect(find.text('1 h'), findsWidgets);

    final currentMonday = usage.lastMonday;
    await tester.tap(find.byTooltip('Semana anterior'));
    await tester.pumpAndSettle();
    expect(usage.lastMonday!.isBefore(currentMonday!), isTrue);
    expect(find.text('Interacciones de la semana'), findsOneWidget);
  });

  testWidgets('access preferences reach dialogs and update open sheets', (
    tester,
  ) async {
    final preferences = AppPreferencesController.memory();
    await preferences.setTextScale(1.6);
    await preferences.setHighContrast(true);
    final model = PauseViewModel(channel: _FakeChannel());
    await _mountApp(tester, model, preferences: preferences);

    await tester.ensureVisible(find.text('Avisos, si los quieres'));
    await tester.tap(find.text('Avisos, si los quieres'));
    await tester.pumpAndSettle();
    final dialog = tester.element(find.text('Avisos de este dispositivo'));
    expect(MediaQuery.textScalerOf(dialog).scale(10), 16);
    expect(MediaQuery.disableAnimationsOf(dialog), isTrue);
    expect(Theme.of(dialog).scaffoldBackgroundColor, Colors.black);
    expect(ModalRoute.of(dialog)!.transitionDuration, Duration.zero);
    await tester.tap(find.text('Cerrar'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Mi panorama'));
    await tester.tap(find.text('Mi panorama'));
    await tester.pumpAndSettle();
    var sheet = tester.element(find.text('Interacciones de la semana'));
    expect(MediaQuery.textScalerOf(sheet).scale(10), 16);
    expect(ModalRoute.of(sheet)!.transitionDuration, Duration.zero);
    await preferences.setTextScale(1.2);
    await preferences.setHighContrast(false);
    await tester.pumpAndSettle();
    sheet = tester.element(find.text('Interacciones de la semana'));
    expect(MediaQuery.textScalerOf(sheet).scale(10), 12);
    expect(Theme.of(sheet).scaffoldBackgroundColor, deepWater);
    expect(tester.takeException(), isNull);
  });

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
      expect(find.text('¿Es un buen momento para una pausa?'), findsOneWidget);
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

      await tester.tap(find.text('Empezar ahora'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Si este momento te sirve'), findsOneWidget);
      expect(find.text('Paso 1 de 3'), findsOneWidget);
      expect(find.text('Empieza a tu manera.'), findsNothing);
      expect(find.textContaining('dejar la pantalla'), findsNothing);
      await tester.ensureVisible(find.text('Siguiente'));
      await tester.tap(find.text('Siguiente'));
      await tester.pumpAndSettle();
      expect(find.text('Paso 2 de 3'), findsOneWidget);
      expect(find.text('Empieza a tu manera.'), findsOneWidget);
      expect(find.textContaining('Si este momento te sirve'), findsNothing);
      await tester.tap(find.text('Anterior'));
      await tester.pumpAndSettle();
      expect(find.text('Paso 1 de 3'), findsOneWidget);
      expect(find.text('Empieza a tu manera.'), findsNothing);
      expect(find.textContaining('duración'), findsNothing);
      expect(find.textContaining('repeticiones'), findsNothing);
      expect(find.textContaining('temporizador'), findsNothing);
      await tester.ensureVisible(find.text('Detener guía'));
      await tester.tap(find.text('Detener guía'));
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
      expect(
        find.text(
          'Está bien. Puedes volver a tu tarea. '
          'No tienes que explicar por qué.',
        ),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Omarchy pause invitation shares the explicit, easy-exit flow', (
    tester,
  ) async {
    final lan = _FakeDesktopLanPause();
    final model = PauseViewModel(
      channel: UnavailableReminderChannel(),
      lan: lan,
    );
    await _mountApp(tester, model, lan: lan);
    lan.onStartPause!('synthetic-session');
    await tester.pumpAndSettle();

    expect(find.text('¿Es un buen momento para una pausa?'), findsOneWidget);
    expect(find.text('Empezar ahora'), findsOneWidget);
    expect(find.text('Ahora no'), findsOneWidget);
    await tester.tap(find.text('Ahora no'));
    await tester.pumpAndSettle();

    expect(find.text('Guía terminada'), findsNothing);
    expect(find.text('Guía detenida'), findsNothing);
    expect(
      find.textContaining('No tienes que explicar por qué.'),
      findsOneWidget,
    );
    await tester.pump();
    expect(lan.recorded, contains('synthetic-session:dismissed'));
    expect(model.activity.guidesStarted, 0);
    lan.onStartPause!('synthetic-guide');
    await tester.pumpAndSettle();
    expect(find.byType(ChoiceChip), findsNothing);
    expect(find.textContaining('Duración de la guía'), findsNothing);
    await tester.ensureVisible(find.text('Empezar ahora'));
    await tester.tap(find.text('Empezar ahora'));
    await tester.pumpAndSettle();
    expect(find.text('Paso 1 de 3'), findsOneWidget);
    expect(find.text('03:00'), findsNothing);
    expect(find.text('Empieza a caminar a tu propio ritmo.'), findsNothing);
    await tester.ensureVisible(find.text('Detener guía'));
    await tester.tap(find.text('Detener guía'));
    await tester.pumpAndSettle();
    expect(find.text('Guía detenida'), findsOneWidget);
    expect(lan.recorded, contains('synthetic-guide:guideStopped'));
    expect(tester.takeException(), isNull);
  });

  testWidgets('guía gradual conserva controles con texto al 200%', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final preferences = AppPreferencesController.memory();
    await preferences.setTextScale(2);
    final model = PauseViewModel(channel: UnavailableReminderChannel());
    await _mountApp(tester, model, preferences: preferences);
    model.openProposal();
    model.startGuide();
    await tester.pumpAndSettle();
    expect(find.text('Paso 1 de 3'), findsOneWidget);
    await tester.ensureVisible(find.text('Siguiente'));
    await tester.tap(find.text('Siguiente'));
    await tester.pumpAndSettle();
    expect(find.text('Paso 2 de 3'), findsOneWidget);
    expect(find.textContaining('aparta un momento la atención'), findsNothing);
    await tester.ensureVisible(find.text('Anterior'));
    await tester.tap(find.text('Anterior'));
    await tester.pumpAndSettle();
    expect(find.text('Paso 1 de 3'), findsOneWidget);
    await tester.ensureVisible(find.text('Detener guía'));
    await tester.tap(find.text('Detener guía'));
    await tester.pumpAndSettle();
    expect(find.text('Guía detenida'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('bienvenida usa, actualiza y borra el apodo local', (
    tester,
  ) async {
    final preferences = AppPreferencesController.memory();
    final model = PauseViewModel(channel: UnavailableReminderChannel());
    await _mountApp(tester, model, preferences: preferences);
    expect(find.text('Haz espacio para moverte'), findsOneWidget);
    expect(find.textContaining('Hola,'), findsNothing);

    await tester.ensureVisible(find.text('Mi espacio'));
    await tester.tap(find.text('Mi espacio'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '  Alex  ');
    await tester.ensureVisible(find.text('Guardar en este dispositivo'));
    await tester.tap(find.text('Guardar en este dispositivo'));
    await tester.pumpAndSettle();
    expect(
      tester.takeException(),
      isNull,
      reason: 'guardar un apodo no debe lanzar una excepción',
    );
    expect(find.text('Hola, Alex'), findsOneWidget);

    await tester.ensureVisible(find.text('Mi espacio'));
    await tester.tap(find.text('Mi espacio'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Borrar perfil local'));
    await tester.tap(find.text('Borrar perfil local'));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(
      tester.takeException(),
      isNull,
      reason: 'borrar y cerrar el perfil no debe lanzar una excepción',
    );
    expect(find.text('Haz espacio para moverte'), findsOneWidget);
    expect(find.textContaining('Hola,'), findsNothing);

    await tester.ensureVisible(find.text('Mi espacio'));
    await tester.tap(find.text('Mi espacio'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '   ');
    await tester.ensureVisible(find.text('Guardar en este dispositivo'));
    await tester.tap(find.text('Guardar en este dispositivo'));
    await tester.pumpAndSettle();
    expect(
      tester.takeException(),
      isNull,
      reason: 'guardar un apodo vacío no debe lanzar una excepción',
    );
    expect(find.text('Haz espacio para moverte'), findsOneWidget);
    expect(find.textContaining('Hola,'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Mi panorama muestra conteos accesibles de la semana', (
    tester,
  ) async {
    final model = PauseViewModel(channel: UnavailableReminderChannel());
    model.openProposal();
    model.dismissProposal();
    model.openProposal();
    model.startGuide();
    model.finishGuide();
    model.goHome();
    await _mountApp(tester, model);
    final semantics = tester.ensureSemantics();
    try {
      await tester.ensureVisible(find.text('Mi panorama'));
      await tester.tap(find.text('Mi panorama'));
      await tester.pumpAndSettle();
      expect(find.text('Propuestas abiertas'), findsOneWidget);
      expect(find.text('Guías iniciadas'), findsOneWidget);
      expect(find.text('Guías terminadas'), findsOneWidget);
      expect(find.bySemanticsLabel('Propuestas abiertas: 2'), findsOneWidget);
      expect(find.bySemanticsLabel('Guías iniciadas: 1'), findsOneWidget);
      expect(find.bySemanticsLabel('Guías terminadas: 1'), findsOneWidget);
      expect(find.bySemanticsLabel('Guías detenidas: 0'), findsOneWidget);
      expect(find.bySemanticsLabel('Pospuestas: 0'), findsOneWidget);
      expect(find.bySemanticsLabel('Cerradas por ahora: 1'), findsOneWidget);
      expect(
        find.textContaining(
          'No mide movimiento, sedentarismo, salud ni progreso.',
        ),
        findsOneWidget,
      );
      expect(find.text('Borrar historial de interacciones'), findsOneWidget);
      await tester.ensureVisible(find.text('Cerrar panorama'));
      await tester.tap(find.text('Cerrar panorama'));
      await tester.pumpAndSettle();

      final resetModel = PauseViewModel(channel: UnavailableReminderChannel());
      await _mountApp(tester, resetModel);
      await tester.ensureVisible(find.text('Mi panorama'));
      await tester.tap(find.text('Mi panorama'));
      await tester.pumpAndSettle();
      expect(
        find.text('Aún no hay interacciones registradas en esta semana.'),
        findsOneWidget,
      );
      expect(find.bySemanticsLabel('Propuestas abiertas: 0'), findsOneWidget);
      expect(tester.takeException(), isNull);
    } finally {
      semantics.dispose();
    }
  });

  testWidgets('guía de caminar mantiene la indicación condicional', (
    tester,
  ) async {
    final model = PauseViewModel(channel: UnavailableReminderChannel());
    await _mountApp(tester, model);
    model.openProposal();
    await tester.pumpAndSettle();
    model.startGuide();
    await tester.pumpAndSettle();
    expect(
      find.textContaining('aparta un momento la atención de la tarea'),
      findsOneWidget,
    );
    expect(find.text('Paso 1 de 3'), findsOneWidget);
    expect(find.text('Empieza a caminar a tu propio ritmo.'), findsNothing);
    expect(find.textContaining('Puedes dejar la pantalla'), findsNothing);
    await tester.pump(const Duration(seconds: 30));
    expect(find.text('Paso 1 de 3'), findsOneWidget);
    await tester.ensureVisible(find.text('Siguiente'));
    await tester.tap(find.text('Siguiente'));
    await tester.pump();
    expect(find.textContaining('aparta un momento la atención'), findsNothing);
    expect(find.text('Paso 2 de 3'), findsOneWidget);
    expect(find.text('Empieza a caminar a tu propio ritmo.'), findsOneWidget);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Siguiente'));
    await tester.pumpAndSettle();
    expect(find.text('Paso 3 de 3'), findsOneWidget);
    expect(find.text('Empieza a caminar a tu propio ritmo.'), findsNothing);
    expect(find.textContaining('Puedes dejar la pantalla'), findsOneWidget);
    expect(find.textContaining('duración'), findsNothing);
    expect(find.textContaining('repeticiones'), findsNothing);
    expect(find.textContaining('temporizador'), findsNothing);
    expect(find.text('Cerrar guía'), findsOneWidget);
    expect(find.text('Detener guía'), findsOneWidget);
    await tester.ensureVisible(find.text('Cerrar guía'));
    await tester.tap(find.text('Cerrar guía'));
    await tester.pumpAndSettle();
    expect(find.text('Guía terminada'), findsOneWidget);
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
    expect(tester.widget<Switch>(find.byType(Switch)).onChanged, isNull);
    await tester.tap(find.text('Cerrar'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
