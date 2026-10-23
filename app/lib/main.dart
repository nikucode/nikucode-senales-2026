import 'package:flutter/material.dart';

import 'pause_view_model.dart';
import 'reminder_channel_factory.dart';

void main() {
  runApp(PauseApp(viewModel: PauseViewModel(channel: createReminderChannel())));
}

const deepWater = Color(0xFF081B23);
const deepWaterLight = Color(0xFF12323A);
const glassEdge = Color(0xFF49717A);
const foam = Color(0xFFF3F8F5);
const mist = Color(0xFFC5D8D5);
const seaGlass = Color(0xFF9BF0DC);
const seaGlassInk = Color(0xFF10342F);
const softLilac = Color(0xFFD8D1F4);
const softCoral = Color(0xFFFFC7B2);

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
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seaGlass,
          brightness: Brightness.dark,
          surface: deepWaterLight,
          primary: seaGlass,
          onPrimary: seaGlassInk,
        ),
        scaffoldBackgroundColor: deepWater,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, height: 1.45, color: foam),
          bodyMedium: TextStyle(fontSize: 16, height: 1.45, color: mist),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: seaGlass,
            foregroundColor: seaGlassInk,
            minimumSize: const Size(56, 58),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            shape: const StadiumBorder(),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: foam,
            minimumSize: const Size(56, 54),
            side: const BorderSide(color: glassEdge),
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: mist,
            minimumSize: const Size(56, 48),
          ),
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          const ExcludeSemantics(
            child: CustomPaint(painter: _MareaAtmosphere()),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
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
                                  style: const TextStyle(color: mist),
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
        ],
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 36,
                height: 34,
                child: CustomPaint(painter: _PauseMark(viewModel.stage)),
              ),
              const SizedBox(width: 8),
              const Text(
                'nikucode',
                style: TextStyle(
                  color: foam,
                  fontSize: 14,
                  letterSpacing: .5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
        const _Eyebrow('UN INTERVALO EN TU JORNADA'),
        const SizedBox(height: 10),
        const _Title('Haz espacio para moverte'),
        const SizedBox(height: 25),
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
        const _Eyebrow('UNA POSIBILIDAD'),
        const SizedBox(height: 10),
        _Title(vm.proposal.title),
        const SizedBox(height: 9),
        Text(vm.proposal.instruction, textAlign: TextAlign.center),
        const SizedBox(height: 23),
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
        const _Eyebrow('SIN PRISA'),
        const SizedBox(height: 10),
        const _Title('A tu ritmo'),
        const SizedBox(height: 9),
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
          vm.stage == PauseStage.stopped ? 'Guía detenida' : 'Guía terminada',
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: vm.goHome,
          child: const Text('Volver a mi tarea'),
        ),
      ],
    };

    return AnimatedSwitcher(
      duration: media.disableAnimations
          ? Duration.zero
          : const Duration(milliseconds: 360),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: .975, end: 1).animate(animation),
          child: child,
        ),
      ),
      child: Column(
        key: ValueKey(vm.stage),
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ExcludeSemantics(
            child: SizedBox(
              width: compact ? 230 : 310,
              height: compact ? 190 : 250,
              child: CustomPaint(painter: _PauseMark(vm.stage)),
            ),
          ),
          SizedBox(height: compact ? 12 : 18),
          ...children.map(
            (child) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: child is Text || child is _Title || child is _Eyebrow
                  ? SizedBox(width: double.infinity, child: child)
                  : child,
            ),
          ),
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
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'serif',
        fontSize: 29,
        height: 1.18,
        fontWeight: FontWeight.w400,
        color: foam,
      ),
    ),
  );
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    textAlign: TextAlign.center,
    style: const TextStyle(
      color: seaGlass,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.5,
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

class _MareaAtmosphere extends CustomPainter {
  const _MareaAtmosphere();

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    canvas.drawRect(
      bounds,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [deepWaterLight, deepWater, Color(0xFF07171F)],
        ).createShader(bounds),
    );

    final upperGlow = Rect.fromCircle(
      center: Offset(size.width * .84, size.height * .16),
      radius: size.width * .48,
    );
    canvas.drawCircle(
      upperGlow.center,
      upperGlow.width / 2,
      Paint()
        ..shader = RadialGradient(
          colors: [seaGlass.withValues(alpha: .12), Colors.transparent],
        ).createShader(upperGlow),
    );

    final lowerGlow = Rect.fromCircle(
      center: Offset(size.width * .12, size.height * .82),
      radius: size.width * .40,
    );
    canvas.drawCircle(
      lowerGlow.center,
      lowerGlow.width / 2,
      Paint()
        ..shader = RadialGradient(
          colors: [softLilac.withValues(alpha: .09), Colors.transparent],
        ).createShader(lowerGlow),
    );

    final tide = Path()
      ..moveTo(0, size.height * .70)
      ..cubicTo(
        size.width * .29,
        size.height * .60,
        size.width * .58,
        size.height * .84,
        size.width,
        size.height * .68,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      tide,
      Paint()..color = const Color(0xFF4C9E9A).withValues(alpha: .035),
    );

    for (final point in [
      Offset(size.width * .13, size.height * .22),
      Offset(size.width * .88, size.height * .38),
      Offset(size.width * .77, size.height * .78),
    ]) {
      canvas.drawCircle(
        point,
        2.2,
        Paint()..color = foam.withValues(alpha: .20),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MareaAtmosphere oldDelegate) => false;
}

class _PauseMark extends CustomPainter {
  const _PauseMark(this.stage);
  final PauseStage stage;

  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width;
    final sy = size.height;
    final center = Offset(sx * .5, sy * .5);
    final scale = size.shortestSide;
    final drift = switch (stage) {
      PauseStage.home || PauseStage.proposal => 0.0,
      PauseStage.guide => .07,
      PauseStage.finished => .14,
      PauseStage.stopped => -.08,
    };

    final halo = Rect.fromCircle(center: center, radius: scale * .48);
    canvas.drawCircle(
      center,
      scale * .47,
      Paint()
        ..shader = RadialGradient(
          colors: [seaGlass.withValues(alpha: .20), Colors.transparent],
        ).createShader(halo),
    );

    final water = Path()
      ..moveTo(sx * .08, sy * (.53 + drift))
      ..cubicTo(sx * .02, sy * .26, sx * .23, sy * .08, sx * .43, sy * .19)
      ..cubicTo(sx * .58, sy * .27, sx * .64, sy * .40, sx * .81, sy * .34)
      ..cubicTo(sx * 1.01, sy * .29, sx * .99, sy * .62, sx * .84, sy * .77)
      ..cubicTo(sx * .68, sy * .94, sx * .45, sy * .88, sx * .30, sy * .83)
      ..cubicTo(
        sx * .15,
        sy * .77,
        sx * .10,
        sy * .69,
        sx * .08,
        sy * (.53 + drift),
      )
      ..close();

    canvas.drawPath(
      water,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFB9FFF0),
            Color(0xFF64D9CF),
            Color(0xFF4F9CB5),
            Color(0xFF9183C7),
          ],
          stops: [0, .34, .70, 1],
        ).createShader(Offset.zero & size)
        ..style = PaintingStyle.fill,
    );

    canvas.drawPath(
      water,
      Paint()
        ..color = foam.withValues(alpha: .62)
        ..style = PaintingStyle.stroke
        ..strokeWidth = (scale * .012).clamp(1.2, 3.2)
        ..strokeJoin = StrokeJoin.round,
    );

    final innerCurrent = Path()
      ..moveTo(sx * .18, sy * .62)
      ..cubicTo(sx * .30, sy * .47, sx * .42, sy * .75, sx * .57, sy * .55)
      ..cubicTo(sx * .67, sy * .42, sx * .73, sy * .49, sx * .82, sy * .43);
    canvas.drawPath(
      innerCurrent,
      Paint()
        ..color = const Color(0xFF174952).withValues(alpha: .78)
        ..style = PaintingStyle.stroke
        ..strokeWidth = (scale * .035).clamp(3.5, 9.0)
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawPath(
      innerCurrent,
      Paint()
        ..color = foam.withValues(alpha: .82)
        ..style = PaintingStyle.stroke
        ..strokeWidth = (scale * .008).clamp(.9, 2.2)
        ..strokeCap = StrokeCap.round,
    );

    final lensCenter = Offset(sx * .70, sy * .27);
    canvas.drawCircle(
      lensCenter,
      scale * .095,
      Paint()
        ..shader =
            RadialGradient(
              center: const Alignment(-.35, -.45),
              colors: [
                foam.withValues(alpha: .72),
                softLilac.withValues(alpha: .36),
                seaGlass.withValues(alpha: .06),
              ],
            ).createShader(
              Rect.fromCircle(center: lensCenter, radius: scale * .095),
            ),
    );
    canvas.drawCircle(
      lensCenter,
      scale * .095,
      Paint()
        ..color = foam.withValues(alpha: .68)
        ..style = PaintingStyle.stroke
        ..strokeWidth = (scale * .009).clamp(1, 2),
    );

    final reflection = Path()
      ..moveTo(sx * .19, sy * .38)
      ..cubicTo(sx * .27, sy * .20, sx * .39, sy * .20, sx * .47, sy * .25);
    canvas.drawPath(
      reflection,
      Paint()
        ..color = foam.withValues(alpha: .82)
        ..style = PaintingStyle.stroke
        ..strokeWidth = (scale * .014).clamp(1.4, 3.4)
        ..strokeCap = StrokeCap.round,
    );

    final dot = switch (stage) {
      PauseStage.home || PauseStage.proposal => Offset(sx * .49, sy * .50),
      PauseStage.guide => Offset(sx * .67, sy * .49),
      PauseStage.finished => Offset(sx * .82, sy * .44),
      PauseStage.stopped => Offset(sx * .35, sy * .64),
    };
    canvas.drawCircle(dot, scale * .027, Paint()..color = softCoral);
    canvas.drawCircle(
      dot,
      scale * .045,
      Paint()
        ..color = softCoral.withValues(alpha: .28)
        ..style = PaintingStyle.stroke
        ..strokeWidth = scale * .008,
    );
  }

  @override
  bool shouldRepaint(covariant _PauseMark oldDelegate) =>
      stage != oldDelegate.stage;
}
