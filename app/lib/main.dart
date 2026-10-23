import 'package:flutter/material.dart';

import 'pause_view_model.dart';
import 'reminder_channel_factory.dart';

void main() {
  runApp(PauseApp(viewModel: PauseViewModel(channel: createReminderChannel())));
}

const paper = Color(0xFFF8F5EF);
const ink = Color(0xFF26322B);
const moss = Color(0xFF315B4E);
const sage = Color(0xFFE3EBE0);
const clay = Color(0xFFF2E7DC);
const terracotta = Color(0xFF9E402B);
const muted = Color(0xFF5A625C);

class PauseApp extends StatefulWidget {
  const PauseApp({super.key, required this.viewModel});
  final PauseViewModel viewModel;
  @override
  State<PauseApp> createState() => _PauseAppState();
}

class _PauseAppState extends State<PauseApp> {
  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'nikucode · pausa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: moss, surface: paper),
        scaffoldBackgroundColor: paper,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, height: 1.5, color: ink),
          bodyMedium: TextStyle(fontSize: 16, height: 1.5, color: muted),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: moss,
            foregroundColor: Colors.white,
            minimumSize: const Size(48, 52),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: moss,
            minimumSize: const Size(48, 52),
            side: const BorderSide(color: moss),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(minimumSize: const Size(48, 48)),
        ),
      ),
      home: PauseHome(viewModel: widget.viewModel),
    );
  }
}

class PauseHome extends StatelessWidget {
  const PauseHome({super.key, required this.viewModel});
  final PauseViewModel viewModel;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: viewModel,
    builder: (context, _) => Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 900;
            final onHome = viewModel.stage == PauseStage.home;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: wide ? 48 : 24,
                vertical: 24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 20,
                        runSpacing: 12,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ExcludeSemantics(
                                child: SizedBox(
                                  width: 42,
                                  height: 42,
                                  child: CustomPaint(painter: _PauseMark()),
                                ),
                              ),
                              SizedBox(width: 12),
                              Flexible(
                                child: Text(
                                  onHome ? 'nikucode · pausa' : 'Pausa',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (viewModel.stage != PauseStage.home)
                            TextButton.icon(
                              onPressed: viewModel.stage == PauseStage.guide
                                  ? viewModel.stopGuide
                                  : viewModel.goHome,
                              icon: const Icon(Icons.arrow_back_rounded),
                              label: Text(
                                viewModel.stage == PauseStage.guide
                                    ? 'Detener y volver'
                                    : 'Inicio',
                              ),
                            )
                          else
                            const Text(
                              'A TU PROPIO RITMO',
                              style: TextStyle(
                                fontSize: 12,
                                letterSpacing: 1.2,
                                color: moss,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: wide ? 64 : 32),
                      if (wide && onHome)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _Introduction(wide: wide)),
                            const SizedBox(width: 56),
                            Expanded(child: _PausePanel(vm: viewModel)),
                          ],
                        )
                      else if (wide)
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 720),
                            child: _PausePanel(vm: viewModel),
                          ),
                        )
                      else if (onHome) ...[
                        _Introduction(wide: wide),
                        const SizedBox(height: 28),
                        _PausePanel(vm: viewModel),
                      ] else
                        _PausePanel(vm: viewModel),
                      if (viewModel.hasPendingReminder) ...[
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: sage,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 16,
                            children: [
                              Text(
                                'Aviso previsto para ${TimeOfDay.fromDateTime(viewModel.reminderAt!).format(context)} · en esta sesión',
                              ),
                              TextButton(
                                onPressed: viewModel.cancelReminder,
                                child: const Text('Cancelar aviso'),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (viewModel.message != null) ...[
                        const SizedBox(height: 16),
                        Semantics(
                          liveRegion: true,
                          child: Text(
                            viewModel.message!,
                            style: const TextStyle(color: moss),
                          ),
                        ),
                      ],
                      const SizedBox(height: 36),
                      const Divider(color: Color(0xFFD8DED7)),
                      const SizedBox(height: 12),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 20,
                        runSpacing: 8,
                        children: [
                          const Text(
                            'Puedes elegir, cambiar o dejarlo para después.',
                          ),
                          TextButton.icon(
                            onPressed: () => _showReminders(context, viewModel),
                            icon: const Icon(Icons.notifications_none_rounded),
                            label: const Text('Avisos de este dispositivo'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}

class _Introduction extends StatelessWidget {
  const _Introduction({required this.wide});
  final bool wide;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'UN ESPACIO EN TU JORNADA',
        style: TextStyle(
          color: terracotta,
          letterSpacing: 1.5,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 18),
      Semantics(
        header: true,
        child: Text(
          'Un momento\nfuera de la tarea.',
          style: TextStyle(
            fontSize: wide ? 52 : 35,
            height: 1.12,
            letterSpacing: -1.3,
            fontWeight: FontWeight.w500,
            color: ink,
          ),
        ),
      ),
      const SizedBox(height: 24),
      const Text(
        'Una invitación breve para salir un momento de la pantalla y moverte como te resulte adecuado.',
        style: TextStyle(fontSize: 18, height: 1.6),
      ),
      if (wide) ...[
        const SizedBox(height: 38),
        const SizedBox(
          width: 360,
          child: Text(
            'Cambia la propuesta, elige cuándo empezar o vuelve a tu tarea.',
            style: TextStyle(color: moss, fontSize: 16, height: 1.5),
          ),
        ),
      ],
    ],
  );
}

class _PausePanel extends StatelessWidget {
  const _PausePanel({required this.vm});
  final PauseViewModel vm;
  @override
  Widget build(BuildContext context) {
    final children = switch (vm.stage) {
      PauseStage.home => <Widget>[
        const _Title('Una pausa, a tu manera'),
        const SizedBox(height: 12),
        const Text(
          'Explora una propuesta o prepara una invitación para después.',
        ),
        const SizedBox(height: 28),
        FilledButton.icon(
          onPressed: vm.openProposal,
          icon: const Icon(Icons.arrow_forward_rounded),
          label: const Text('Ver una pausa'),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () => _showReminders(context, vm),
          child: const Text('Preparar un aviso'),
        ),
      ],
      PauseStage.proposal => <Widget>[
        Text(
          vm.proposal.contextLabel,
          style: const TextStyle(
            color: terracotta,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        _Title(vm.proposal.title),
        const SizedBox(height: 14),
        Text(vm.proposal.instruction),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: vm.startGuide,
          child: const Text('Empezar guía'),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: vm.changeProposal,
          child: const Text('Cambiar propuesta'),
        ),
        const SizedBox(height: 8),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => _showReminders(context, vm),
              child: const Text('Más tarde'),
            ),
            TextButton(
              onPressed: vm.dismissProposal,
              child: const Text('Ahora no'),
            ),
          ],
        ),
      ],
      PauseStage.guide => <Widget>[
        const _Title('Puedes dejar la pantalla'),
        const SizedBox(height: 14),
        Text(vm.proposal.instruction),
        const SizedBox(height: 12),
        const Text(
          'Vuelve cuando quieras cerrar la guía. No hay un tiempo que cumplir.',
        ),
        const SizedBox(height: 28),
        FilledButton(
          onPressed: vm.finishGuide,
          child: const Text('Terminar guía'),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: vm.stopGuide,
          child: const Text('Detener guía'),
        ),
      ],
      PauseStage.finished || PauseStage.stopped => <Widget>[
        _Title(
          vm.stage == PauseStage.stopped ? 'Guía detenida' : 'Guía terminada',
        ),
        const SizedBox(height: 14),
        const Text('Puedes volver a tu tarea o quedarte un momento más.'),
        const SizedBox(height: 28),
        FilledButton(
          onPressed: vm.goHome,
          child: const Text('Volver al inicio'),
        ),
      ],
    };
    return Container(
      padding: EdgeInsets.all(vm.stage == PauseStage.home ? 28 : 20),
      decoration: const BoxDecoration(
        color: Color(0xFFF0EEE7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(44),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(44),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExcludeSemantics(
            child: SizedBox(
              height: vm.stage == PauseStage.home ? 112 : 56,
              child: CustomPaint(painter: _PauseMark()),
            ),
          ),
          SizedBox(height: vm.stage == PauseStage.home ? 20 : 12),
          ...children,
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Semantics(
    header: true,
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 25,
        height: 1.25,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Future<void> _showReminders(
  BuildContext context,
  PauseViewModel vm,
) => showDialog<void>(
  context: context,
  builder: (dialogContext) => ListenableBuilder(
    listenable: vm,
    builder: (context, _) => AlertDialog(
      scrollable: true,
      title: const Text('Avisos de este dispositivo'),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(vm.channelScope),
            const SizedBox(height: 12),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Habilitar avisos en esta sesión'),
              value: vm.remindersEnabled,
              onChanged: vm.channelSupported ? vm.setRemindersEnabled : null,
            ),
            if (!vm.channelSupported)
              const Text(
                'El canal de avisos aún no está disponible aquí. Puedes abrir una pausa manualmente.',
              ),
            if (vm.remindersEnabled) ...[
              const SizedBox(height: 16),
              const Text('¿Cuándo quieres preparar la invitación?'),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final minutes in [5, 15, 30])
                    OutlinedButton(
                      onPressed: () async {
                        await vm.scheduleReminder(Duration(minutes: minutes));
                        if (vm.hasPendingReminder && dialogContext.mounted) {
                          Navigator.pop(dialogContext);
                        }
                      },
                      child: Text('$minutes min'),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () async {
                  await vm.scheduleReminder(const Duration(seconds: 10));
                  if (vm.hasPendingReminder && dialogContext.mounted) {
                    Navigator.pop(dialogContext);
                  }
                },
                icon: const Icon(Icons.science_outlined),
                label: const Text('Probar señal en 10 segundos'),
              ),
              const Text(
                'Es una prueba técnica, no una frecuencia recomendada.',
                style: TextStyle(fontSize: 14),
              ),
            ],
            if (vm.message != null) ...[
              const SizedBox(height: 12),
              Semantics(liveRegion: true, child: Text(vm.message!)),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Cerrar'),
        ),
      ],
    ),
  ),
);

class _PauseMark extends CustomPainter {
  const _PauseMark();
  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width;
    final sy = size.height;
    final field = Path()
      ..moveTo(sx * .07, sy * .69)
      ..cubicTo(sx * .02, sy * .31, sx * .19, sy * .08, sx * .39, sy * .18)
      ..cubicTo(sx * .55, sy * .25, sx * .56, sy * .44, sx * .72, sy * .35)
      ..cubicTo(sx * .91, sy * .24, sx * .99, sy * .52, sx * .91, sy * .77)
      ..cubicTo(sx * .81, sy * .98, sx * .57, sy * .90, sx * .39, sy * .84)
      ..cubicTo(sx * .22, sy * .79, sx * .12, sy * .94, sx * .07, sy * .69)
      ..close();
    canvas.drawPath(field, Paint()..color = sage);

    final warmPatch = Path()
      ..moveTo(sx * .63, sy * .12)
      ..cubicTo(sx * .76, sy * .02, sx * .93, sy * .13, sx * .94, sy * .31)
      ..cubicTo(sx * .91, sy * .45, sx * .79, sy * .49, sx * .69, sy * .41)
      ..cubicTo(sx * .59, sy * .33, sx * .56, sy * .19, sx * .63, sy * .12)
      ..close();
    canvas.drawPath(warmPatch, Paint()..color = clay);

    final thread = Paint()
      ..color = moss
      ..style = PaintingStyle.stroke
      ..strokeWidth = (size.shortestSide * .045).clamp(1.8, 4.0)
      ..strokeCap = StrokeCap.round;
    final firstSegment = Path()
      ..moveTo(sx * .13, sy * .66)
      ..cubicTo(sx * .25, sy * .67, sx * .27, sy * .43, sx * .41, sy * .48);
    final secondSegment = Path()
      ..moveTo(sx * .58, sy * .52)
      ..cubicTo(sx * .71, sy * .58, sx * .77, sy * .71, sx * .89, sy * .64);
    canvas
      ..drawPath(firstSegment, thread)
      ..drawPath(secondSegment, thread)
      ..drawCircle(
        Offset(sx * .50, sy * .50),
        (size.shortestSide * .065).clamp(2.0, 6.0),
        Paint()..color = terracotta,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
