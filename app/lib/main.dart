import 'package:flutter/material.dart';

import 'pause_view_model.dart';
import 'reminder_channel_factory.dart';

void main() {
  runApp(PauseApp(viewModel: PauseViewModel(channel: createReminderChannel())));
}

const paper = Color(0xFFFAF8F5);
const ink = Color(0xFF202124);
const violet = Color(0xFF62567A);
const lavender = Color(0xFFEAE2F4);

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
        colorScheme: ColorScheme.fromSeed(seedColor: violet, surface: paper),
        scaffoldBackgroundColor: paper,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, height: 1.5, color: ink),
          bodyMedium: TextStyle(fontSize: 16, height: 1.5, color: ink),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: violet,
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
            foregroundColor: violet,
            minimumSize: const Size(48, 52),
            side: const BorderSide(color: violet),
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
                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ExcludeSemantics(
                                child: CircleAvatar(
                                  radius: 19,
                                  backgroundColor: lavender,
                                  child: Icon(
                                    Icons.spa_outlined,
                                    color: violet,
                                    size: 23,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Flexible(
                                child: Text(
                                  'nikucode · pausa',
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
                              'SIN METAS NI RACHAS',
                              style: TextStyle(
                                fontSize: 12,
                                letterSpacing: 1.4,
                                color: violet,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: wide ? 64 : 32),
                      if (wide)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _Introduction(wide: wide)),
                            const SizedBox(width: 56),
                            Expanded(child: _FlowCard(vm: viewModel)),
                          ],
                        )
                      else ...[
                        _Introduction(wide: wide),
                        const SizedBox(height: 28),
                        _FlowCard(vm: viewModel),
                      ],
                      if (viewModel.hasPendingReminder) ...[
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: lavender,
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
                            style: const TextStyle(color: violet),
                          ),
                        ),
                      ],
                      const SizedBox(height: 36),
                      const Divider(color: Color(0xFFD8D1DD)),
                      const SizedBox(height: 12),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 20,
                        runSpacing: 8,
                        children: [
                          const Text('Una propuesta. Tú eliges el momento.'),
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
        'PAUSAS A TU RITMO',
        style: TextStyle(color: violet, letterSpacing: 2, fontSize: 12),
      ),
      const SizedBox(height: 16),
      Semantics(
        header: true,
        child: Text(
          'Hay espacio\npara una pausa.',
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
        'Una propuesta breve para salir de la tarea y moverte como te resulte adecuado.',
        style: TextStyle(fontSize: 18, height: 1.6),
      ),
      if (wide) ...[
        const SizedBox(height: 40),
        for (final text in [
          'Puedes cambiar de propuesta',
          'El momento lo decides tú',
          'Termina cuando quieras',
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                const Icon(Icons.check_rounded, color: violet, size: 20),
                const SizedBox(width: 12),
                Expanded(child: Text(text)),
              ],
            ),
          ),
      ],
    ],
  );
}

class _FlowCard extends StatelessWidget {
  const _FlowCard({required this.vm});
  final PauseViewModel vm;
  @override
  Widget build(BuildContext context) {
    final children = switch (vm.stage) {
      PauseStage.home => <Widget>[
        const _Title('Una pausa que cabe en tu momento'),
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
        Text(vm.proposal.contextLabel, style: const TextStyle(color: violet)),
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
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE2DCE8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ExcludeSemantics(
            child: SizedBox(
              height: 94,
              child: CustomPaint(painter: _PauseMark()),
            ),
          ),
          const SizedBox(height: 24),
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
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center.translate(-28, 0), 42, Paint()..color = lavender);
    canvas.drawCircle(
      center.translate(30, -4),
      34,
      Paint()..color = const Color(0xFFE0EEE5),
    );
    final paint = Paint()
      ..color = violet
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(center.dx - 46, center.dy + 18)
      ..cubicTo(
        center.dx - 20,
        center.dy + 18,
        center.dx - 18,
        center.dy - 20,
        center.dx + 3,
        center.dy - 20,
      )
      ..cubicTo(
        center.dx + 20,
        center.dy - 20,
        center.dx + 20,
        center.dy + 14,
        center.dx + 44,
        center.dy + 14,
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
