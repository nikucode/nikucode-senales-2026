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
const lilac = Color(0xFFEAE5F1);
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
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 760,
                    minHeight: (constraints.maxHeight - 32).clamp(0, 2000),
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _TopLine(viewModel: viewModel),
                        Expanded(
                          child: Center(child: _PausePanel(vm: viewModel)),
                        ),
                        if (viewModel.hasPendingReminder)
                          TextButton(
                            onPressed: viewModel.cancelReminder,
                            child: Text(
                              'Cancelar aviso · ${TimeOfDay.fromDateTime(viewModel.reminderAt!).format(context)}',
                            ),
                          ),
                        if (viewModel.message != null)
                          Semantics(
                            liveRegion: true,
                            child: Text(
                              viewModel.message!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: muted),
                            ),
                          ),
                      ],
                    ),
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

class _TopLine extends StatelessWidget {
  const _TopLine({required this.viewModel});
  final PauseViewModel viewModel;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Semantics(
        label: 'nikucode pausa',
        child: ExcludeSemantics(
          child: SizedBox(
            width: 52,
            height: 40,
            child: CustomPaint(painter: _PauseMark(viewModel.stage)),
          ),
        ),
      ),
      if (viewModel.stage != PauseStage.home)
        TextButton(
          onPressed: switch (viewModel.stage) {
            PauseStage.proposal => viewModel.dismissProposal,
            PauseStage.guide => viewModel.stopGuide,
            _ => viewModel.goHome,
          },
          child: Text(switch (viewModel.stage) {
            PauseStage.proposal => 'Ahora no',
            PauseStage.guide => 'Detener',
            _ => 'Inicio',
          }),
        )
      else
        const SizedBox(height: 48),
    ],
  );
}

class _PausePanel extends StatelessWidget {
  const _PausePanel({required this.vm});
  final PauseViewModel vm;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final compact = media.size.width < 600 || media.textScaler.scale(1) > 1.3;
    final children = switch (vm.stage) {
      PauseStage.home => <Widget>[
        const _Title('Una pausa, si te sirve'),
        const SizedBox(height: 28),
        FilledButton.icon(
          onPressed: vm.openProposal,
          icon: const Icon(Icons.arrow_forward_rounded),
          label: const Text('Ver una pausa'),
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: () => _showReminders(context, vm),
          icon: const Icon(Icons.notifications_none_rounded),
          label: const Text('Avisos, si los quieres'),
        ),
      ],
      PauseStage.proposal => <Widget>[
        _Title(vm.proposal.title),
        const SizedBox(height: 12),
        Text(vm.proposal.instruction, textAlign: TextAlign.center),
        const SizedBox(height: 28),
        FilledButton(onPressed: vm.startGuide, child: const Text('Empezar')),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: vm.changeProposal,
          icon: const Icon(Icons.shuffle_rounded),
          label: const Text('Otra idea'),
        ),
        TextButton(
          onPressed: () => _showReminders(context, vm),
          child: const Text('Más tarde'),
        ),
      ],
      PauseStage.guide => <Widget>[
        const _Title('A tu ritmo'),
        const SizedBox(height: 12),
        Text(vm.proposal.instruction, textAlign: TextAlign.center),
        const SizedBox(height: 28),
        FilledButton(
          onPressed: vm.finishGuide,
          child: const Text('Cerrar guía'),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: vm.stopGuide,
          child: const Text('Detener y volver'),
        ),
      ],
      PauseStage.finished || PauseStage.stopped => <Widget>[
        _Title(
          vm.stage == PauseStage.stopped ? 'Guía cerrada' : 'Espacio hecho',
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: vm.goHome,
          child: const Text('Volver a mi tarea'),
        ),
      ],
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedSwitcher(
          duration: media.disableAnimations
              ? Duration.zero
              : const Duration(milliseconds: 280),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: .96, end: 1).animate(animation),
              child: child,
            ),
          ),
          child: ExcludeSemantics(
            key: ValueKey(vm.stage),
            child: SizedBox(
              width: compact ? 200 : 280,
              height: compact ? 158 : 220,
              child: CustomPaint(painter: _PauseMark(vm.stage)),
            ),
          ),
        ),
        SizedBox(height: compact ? 14 : 24),
        ...children.map(
          (child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: child is Text || child is _Title
                ? SizedBox(width: double.infinity, child: child)
                : child,
          ),
        ),
      ],
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
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'serif',
        fontSize: 29,
        height: 1.18,
        fontWeight: FontWeight.w400,
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
  const _PauseMark(this.stage);
  final PauseStage stage;

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
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(sx * .20, sy * .28),
        width: sx * .13,
        height: sy * .12,
      ),
      Paint()..color = lilac,
    );

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
    final joinedPath = Path()
      ..moveTo(sx * .13, sy * .66)
      ..cubicTo(sx * .25, sy * .67, sx * .27, sy * .43, sx * .41, sy * .48)
      ..cubicTo(sx * .52, sy * .50, sx * .52, sy * .50, sx * .58, sy * .52)
      ..cubicTo(sx * .71, sy * .58, sx * .77, sy * .71, sx * .89, sy * .64);
    final route = switch (stage) {
      PauseStage.guide || PauseStage.finished => joinedPath,
      _ => null,
    };
    if (route != null) {
      canvas.drawPath(route, thread);
    } else {
      canvas
        ..drawPath(firstSegment, thread)
        ..drawPath(secondSegment, thread);
    }
    final marker = switch (stage) {
      PauseStage.guide => Offset(sx * .73, sy * .60),
      PauseStage.finished => Offset(sx * .89, sy * .64),
      _ => Offset(sx * .50, sy * .50),
    };
    canvas.drawCircle(
      marker,
      (size.shortestSide * .065).clamp(2.0, 6.0),
      Paint()..color = terracotta,
    );
  }

  @override
  bool shouldRepaint(covariant _PauseMark oldDelegate) =>
      stage != oldDelegate.stage;
}
