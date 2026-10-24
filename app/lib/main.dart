import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';

import 'app_preferences.dart';
import 'interaction_history.dart';
import 'lan_pause.dart';
import 'lan_pause_factory.dart';
import 'lan_pause_ui.dart';
import 'marea_tools.dart';
import 'pause_view_model.dart';
import 'reminder_channel_factory.dart';

Future<void> main(List<String> arguments) async {
  WidgetsFlutterBinding.ensureInitialized();
  final reminderChannel = createReminderChannel();
  final preferences = await AppPreferencesController.load();
  final history = await InteractionHistory.load();
  final lan = await createLanPause(history);
  final viewModel = PauseViewModel(channel: reminderChannel, history: history);
  runApp(PauseApp(viewModel: viewModel, preferences: preferences, lan: lan));
  if (arguments.contains('--daemon')) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => unawaited(lan.startService()),
    );
  }
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

IconData _avatarFor(int index) => switch (index.clamp(0, 3)) {
  0 => Icons.water_drop_outlined,
  1 => Icons.waves_rounded,
  2 => Icons.nightlight_outlined,
  _ => Icons.spa_outlined,
};

class PauseApp extends StatefulWidget {
  const PauseApp({
    super.key,
    required this.viewModel,
    this.preferences,
    this.lan,
  });
  final PauseViewModel viewModel;
  final AppPreferencesController? preferences;
  final LanPause? lan;
  @override
  State<PauseApp> createState() => _PauseAppState();
}

class _PauseAppState extends State<PauseApp> {
  late final AppPreferencesController _preferences =
      widget.preferences ?? AppPreferencesController.memory();
  late final LanPause _lan = widget.lan ?? NoLanPause();
  String? _desktopSessionId;
  PauseStage _lastStage = PauseStage.home;
  Timer? _guideTimer;
  int _guideMinutes = 3;
  int _remainingSeconds = 180;

  @override
  void initState() {
    super.initState();
    _lastStage = widget.viewModel.stage;
    widget.viewModel.addListener(_onViewModelChanged);
    _lan.onStartPause = (id) {
      if (!mounted) return;
      _desktopSessionId = id;
      _guideTimer?.cancel();
      setState(() => _remainingSeconds = _guideMinutes * 60);
      widget.viewModel.openProposal();
    };
  }

  void _onViewModelChanged() {
    final stage = widget.viewModel.stage;
    if (stage == _lastStage) return;
    _lastStage = stage;
    final id = _desktopSessionId;
    if (id == null) return;
    if (stage == PauseStage.guide) {
      unawaited(_lan.recordSession(id, 'guideStarted'));
      setState(() => _remainingSeconds = _guideMinutes * 60);
      _guideTimer?.cancel();
      _guideTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted || _remainingSeconds <= 0) return;
        setState(() => _remainingSeconds--);
      });
    } else if (stage == PauseStage.finished ||
        stage == PauseStage.stopped ||
        stage == PauseStage.home) {
      _guideTimer?.cancel();
      if (stage == PauseStage.finished || stage == PauseStage.stopped) {
        unawaited(
          _lan.recordSession(
            id,
            stage == PauseStage.finished ? 'guideFinished' : 'guideStopped',
          ),
        );
      } else {
        unawaited(_lan.recordSession(id, 'dismissed'));
      }
      _desktopSessionId = null;
    }
  }

  @override
  void dispose() {
    _guideTimer?.cancel();
    widget.viewModel.removeListener(_onViewModelChanged);
    _lan.onStartPause = null;
    _lan.dispose();
    widget.viewModel.dispose();
    _preferences.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: Listenable.merge([_preferences, _lan]),
    builder: (context, _) => MaterialApp(
      title: 'nikucode · pausa',
      debugShowCheckedModeBanner: false,
      theme: _mareaTheme(highContrast: _preferences.highContrast),
      themeAnimationDuration: _preferences.reduceMotion
          ? Duration.zero
          : kThemeAnimationDuration,
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            disableAnimations:
                media.disableAnimations || _preferences.reduceMotion,
            textScaler: TextScaler.linear(
              math
                  .max(media.textScaler.scale(1), _preferences.textScale)
                  .toDouble(),
            ),
          ),
          child: child!,
        );
      },
      home: PauseHome(
        viewModel: widget.viewModel,
        preferences: _preferences,
        lan: _lan,
        desktopSession: _desktopSessionId != null,
        guideMinutes: _guideMinutes,
        remainingSeconds: _remainingSeconds,
        onGuideMinutesChanged: (value) => setState(() {
          _guideMinutes = value;
          _remainingSeconds = value * 60;
        }),
      ),
    ),
  );
}

ThemeData _mareaTheme({required bool highContrast}) => ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: seaGlass,
    brightness: Brightness.dark,
    surface: deepWaterLight,
    primary: seaGlass,
    onPrimary: seaGlassInk,
    contrastLevel: highContrast ? 1 : 0,
  ),
  scaffoldBackgroundColor: highContrast ? Colors.black : deepWater,
  textTheme: TextTheme(
    bodyLarge: const TextStyle(fontSize: 18, height: 1.45, color: foam),
    bodyMedium: TextStyle(
      fontSize: 16,
      height: 1.45,
      color: highContrast ? foam : mist,
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: const Color(0xB8B9F4EA),
      foregroundColor: seaGlassInk,
      minimumSize: const Size(56, 58),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
      shape: const StadiumBorder(),
      side: BorderSide(
        color: foam.withValues(alpha: highContrast ? 1 : .88),
        width: highContrast ? 2 : 1.2,
      ),
      elevation: 5,
      shadowColor: seaGlass.withValues(alpha: .28),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: foam,
      minimumSize: const Size(56, 54),
      backgroundColor: foam.withValues(alpha: highContrast ? .12 : .055),
      side: BorderSide(
        color: foam.withValues(alpha: highContrast ? .8 : .44),
        width: highContrast ? 1.8 : 1,
      ),
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: highContrast ? foam : mist,
      minimumSize: const Size(56, 48),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      backgroundColor: foam.withValues(alpha: highContrast ? .12 : .055),
      side: BorderSide(
        color: foam.withValues(alpha: highContrast ? .72 : .22),
        width: highContrast ? 1.8 : 1,
      ),
      shape: const StadiumBorder(),
    ),
  ),
);

class PauseHome extends StatelessWidget {
  const PauseHome({
    super.key,
    required this.viewModel,
    required this.preferences,
    this.lan,
    this.desktopSession = false,
    this.guideMinutes = 3,
    this.remainingSeconds = 180,
    this.onGuideMinutesChanged,
  });
  final PauseViewModel viewModel;
  final AppPreferencesController preferences;
  final LanPause? lan;
  final bool desktopSession;
  final int guideMinutes;
  final int remainingSeconds;
  final ValueChanged<int>? onGuideMinutesChanged;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: preferences,
    builder: (context, _) => ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          disableAnimations:
              MediaQuery.disableAnimationsOf(context) ||
              preferences.reduceMotion,
          textScaler: TextScaler.linear(
            math
                .max(
                  MediaQuery.textScalerOf(context).scale(1),
                  preferences.textScale,
                )
                .toDouble(),
          ),
        ),
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              ExcludeSemantics(
                child: CustomPaint(
                  painter: _MareaAtmosphere(
                    highContrast: preferences.highContrast,
                  ),
                ),
              ),
              SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          _TopLine(
                            viewModel: viewModel,
                            preferences: preferences,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: (constraints.maxHeight - 76).clamp(
                                    0,
                                    2000,
                                  ),
                                ),
                                child: Center(
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxWidth: 760,
                                    ),
                                    child: _PausePanel(
                                      vm: viewModel,
                                      preferences: preferences,
                                      lan: lan,
                                      desktopSession: desktopSession,
                                      guideMinutes: guideMinutes,
                                      remainingSeconds: remainingSeconds,
                                      onGuideMinutesChanged:
                                          onGuideMinutesChanged,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _TopLine extends StatelessWidget {
  const _TopLine({required this.viewModel, required this.preferences});
  final PauseViewModel viewModel;
  final AppPreferencesController preferences;

  @override
  Widget build(BuildContext context) {
    final brand = Semantics(
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
    );
    final actions = viewModel.stage != PauseStage.home
        ? TextButton(
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
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: preferences.displayName,
                onPressed: () => showMareaProfile(context, preferences),
                icon: Icon(_avatarFor(preferences.avatarIndex)),
              ),
              IconButton(
                tooltip: 'Ajustes de acceso',
                onPressed: () => showMareaSettings(context, preferences),
                icon: const Icon(Icons.tune_rounded),
              ),
            ],
          );

    return LayoutBuilder(
      builder: (context, constraints) {
        final largeText = MediaQuery.textScalerOf(context).scale(1) > 1.3;
        if (largeText || constraints.maxWidth < 300) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(alignment: AlignmentDirectional.centerStart, child: brand),
              Align(alignment: AlignmentDirectional.centerEnd, child: actions),
            ],
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [brand, actions],
        );
      },
    );
  }
}

class _PausePanel extends StatelessWidget {
  const _PausePanel({
    required this.vm,
    required this.preferences,
    this.lan,
    required this.desktopSession,
    required this.guideMinutes,
    required this.remainingSeconds,
    this.onGuideMinutesChanged,
  });
  final PauseViewModel vm;
  final AppPreferencesController preferences;
  final LanPause? lan;
  final bool desktopSession;
  final int guideMinutes;
  final int remainingSeconds;
  final ValueChanged<int>? onGuideMinutesChanged;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final compact = media.size.width < 600 || media.textScaler.scale(1) > 1.3;
    final largeText = media.textScaler.scale(1) > 1.3;
    final nickname = preferences.nickname.trim();
    final children = switch (vm.stage) {
      PauseStage.home => <Widget>[
        const _Eyebrow('UN INTERVALO EN TU JORNADA'),
        const SizedBox(height: 10),
        _Title(
          nickname.isEmpty ? 'Haz espacio para moverte' : 'Hola, $nickname',
        ),
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
        if (lan?.available == true) ...[
          const SizedBox(height: 6),
          OutlinedButton.icon(
            onPressed: () => showLanPauseDialog(context, lan!),
            icon: const Icon(Icons.devices_rounded),
            label: const Text('Pausas en Omarchy'),
          ),
          Text(
            lan!.status,
            textAlign: TextAlign.center,
            style: const TextStyle(color: mist, fontSize: 13),
          ),
          if (lan?.pendingLabel != null)
            Text(lan!.pendingLabel!, textAlign: TextAlign.center),
        ],
        const SizedBox(height: 6),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 4,
          children: [
            TextButton.icon(
              onPressed: () => showMareaPanorama(context, vm, preferences),
              icon: const Icon(Icons.waterfall_chart_rounded),
              label: const Text('Mi panorama'),
            ),
            TextButton.icon(
              onPressed: () => showMareaProfile(context, preferences),
              icon: const Icon(Icons.person_outline_rounded),
              label: const Text('Mi espacio'),
            ),
          ],
        ),
      ],
      PauseStage.proposal => <Widget>[
        const _Eyebrow('UNA POSIBILIDAD'),
        const SizedBox(height: 10),
        _Title(vm.proposal.title),
        const SizedBox(height: 9),
        Text(vm.proposal.instruction, textAlign: TextAlign.center),
        if (desktopSession) ...[
          const SizedBox(height: 12),
          Text('Duración de la guía: $guideMinutes min'),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            children: [
              for (final minutes in [1, 3, 5])
                ChoiceChip(
                  label: Text('$minutes min'),
                  selected: guideMinutes == minutes,
                  onSelected: (_) => onGuideMinutesChanged?.call(minutes),
                ),
            ],
          ),
        ],
        const SizedBox(height: 23),
        FilledButton(onPressed: vm.startGuide, child: const Text('Empezar')),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: vm.changeProposal,
          icon: const Icon(Icons.shuffle_rounded),
          label: const Text('Cambiar propuesta'),
        ),
        TextButton(
          onPressed: () => _showReminders(context, vm),
          child: const Text('Configurar aviso'),
        ),
      ],
      PauseStage.guide => <Widget>[
        const _Eyebrow('SIN PRISA'),
        const SizedBox(height: 10),
        const _Title('A tu ritmo'),
        if (desktopSession) ...[
          const SizedBox(height: 8),
          Semantics(
            liveRegion: remainingSeconds == 0,
            label: remainingSeconds == 0
                ? 'Tiempo terminado. Puedes finalizar cuando quieras.'
                : 'Tiempo restante: ${remainingSeconds ~/ 60} minutos y ${remainingSeconds % 60} segundos',
            child: Text(
              '${(remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(remainingSeconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 42, color: seaGlass),
            ),
          ),
        ],
        const SizedBox(height: 14),
        for (var i = 0; i < vm.proposal.guideSteps.length; i++)
          _GuideStep(number: i + 1, text: vm.proposal.guideSteps[i]),
        const SizedBox(height: 18),
        FilledButton(
          onPressed: vm.finishGuide,
          child: Text(desktopSession ? 'Finalizar' : 'Cerrar guía'),
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
              width: largeText
                  ? 160
                  : compact
                  ? 230
                  : 310,
              height: largeText
                  ? 124
                  : compact
                  ? 190
                  : 250,
              child: _MareaOrb(
                stage: vm.stage,
                proposalIndex: vm.proposalIndex,
              ),
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

class _GuideStep extends StatelessWidget {
  const _GuideStep({required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) => Semantics(
    container: true,
    label: 'Paso $number. $text',
    child: ExcludeSemantics(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: seaGlass.withValues(alpha: .8)),
                color: seaGlass.withValues(alpha: .12),
              ),
              child: Text(
                '$number',
                style: const TextStyle(
                  color: foam,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> _showReminders(
  BuildContext context,
  PauseViewModel vm,
) => showDialog<void>(
  context: context,
  animationStyle: MediaQuery.disableAnimationsOf(context)
      ? AnimationStyle.noAnimation
      : null,
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
            MergeSemantics(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Habilitar avisos en esta sesión'),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Switch(
                      value: vm.remindersEnabled,
                      onChanged: vm.channelSupported
                          ? vm.setRemindersEnabled
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            if (!vm.channelSupported)
              const Text(
                'El canal de avisos aún no está disponible aquí. Puedes abrir una pausa manualmente.',
              ),
            if (vm.remindersEnabled) ...[
              const SizedBox(height: 16),
              const Text('Elige un intervalo para la invitación'),
              const SizedBox(height: 12),
              const Text(
                'El intervalo es una elección tuya, no una recomendación sanitaria.',
              ),
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
  const _MareaAtmosphere({required this.highContrast});
  final bool highContrast;

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    canvas.drawRect(
      bounds,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            highContrast ? Colors.black : deepWaterLight,
            Colors.black,
            highContrast ? Colors.black : Color(0xFF07171F),
          ],
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
          colors: [
            seaGlass.withValues(alpha: highContrast ? 0 : .12),
            Colors.transparent,
          ],
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
          colors: [
            softLilac.withValues(alpha: highContrast ? 0 : .09),
            Colors.transparent,
          ],
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
      Paint()
        ..color = const Color(0xFF4C9E9A)
            .withValues(alpha: highContrast ? 0 : .035),
    );

    for (final point in [
      Offset(size.width * .13, size.height * .22),
      Offset(size.width * .88, size.height * .38),
      Offset(size.width * .77, size.height * .78),
    ]) {
      canvas.drawCircle(
        point,
        2.2,
        Paint()..color = foam.withValues(alpha: highContrast ? .42 : .20),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MareaAtmosphere oldDelegate) =>
      oldDelegate.highContrast != highContrast;
}

class _MareaOrb extends StatefulWidget {
  const _MareaOrb({required this.stage, required this.proposalIndex});
  final PauseStage stage;
  final int proposalIndex;

  @override
  State<_MareaOrb> createState() => _MareaOrbState();
}

class _MareaOrbState extends State<_MareaOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _float;
  bool? _reduceMotion;

  @override
  void initState() {
    super.initState();
    _float = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5200),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduce = MediaQuery.disableAnimationsOf(context);
    if (_reduceMotion == reduce) return;
    _reduceMotion = reduce;
    if (reduce) {
      _float
        ..stop()
        ..value = 0;
    } else {
      _float.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _float.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _float,
    builder: (context, _) {
      final phase = _float.value * math.pi;
      final travel = _reduceMotion == true ? 0.0 : math.sin(phase) * 6;
      final rotation = _reduceMotion == true ? 0.0 : math.sin(phase * 2) * .012;
      final stageScale = switch (widget.stage) {
        PauseStage.guide => 1.035,
        PauseStage.finished => .96,
        PauseStage.stopped => .98,
        _ => 1.0,
      };

      return Transform.translate(
        offset: Offset(0, travel),
        child: Transform.rotate(
          angle: rotation,
          child: AnimatedScale(
            scale: stageScale,
            duration: MediaQuery.disableAnimationsOf(context)
                ? Duration.zero
                : const Duration(milliseconds: 520),
            curve: Curves.easeInOutCubic,
            child: widget.stage == PauseStage.home
                ? Image.asset(
                    'assets/marea_orb.webp',
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  )
                : _MareaGlassScene(
                    stage: widget.stage,
                    proposalIndex: widget.proposalIndex,
                  ),
          ),
        ),
      );
    },
  );
}

class _GlassSprite {
  const _GlassSprite(
    this.asset,
    this.left,
    this.top,
    this.width,
    this.height,
    this.angle,
  );
  final String asset;
  final double left;
  final double top;
  final double width;
  final double height;
  final double angle;
}

class _MareaGlassScene extends StatelessWidget {
  const _MareaGlassScene({required this.stage, required this.proposalIndex});
  final PauseStage stage;
  final int proposalIndex;

  static const _pink = 'assets/glass_cells/proposal.webp';
  static const _blue = 'assets/glass_cells/guide.webp';
  static const _mint = 'assets/glass_cells/finish.webp';
  static const _violet = 'assets/glass_cells/stopped.webp';

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final sprites = switch (stage) {
        PauseStage.proposal when proposalIndex.isEven => <_GlassSprite>[
          const _GlassSprite(_pink, .18, .06, .58, .91, -.035),
          const _GlassSprite(_blue, .60, .00, .28, .43, .08),
          const _GlassSprite(_mint, .02, .57, .25, .38, -.10),
        ],
        PauseStage.proposal => <_GlassSprite>[
          const _GlassSprite(_blue, .20, .04, .58, .91, .035),
          const _GlassSprite(_violet, .02, .05, .26, .40, -.10),
          const _GlassSprite(_mint, .66, .52, .27, .40, .08),
        ],
        PauseStage.guide => <_GlassSprite>[
          const _GlassSprite(_blue, .20, .04, .60, .92, 0),
          const _GlassSprite(_pink, .00, .47, .28, .46, -.10),
          const _GlassSprite(_mint, .68, .04, .26, .40, .08),
        ],
        PauseStage.finished => <_GlassSprite>[
          const _GlassSprite(_mint, .20, .04, .60, .92, -.025),
          const _GlassSprite(_blue, .00, .05, .28, .42, -.08),
          const _GlassSprite(_pink, .66, .48, .28, .46, .10),
        ],
        PauseStage.stopped => <_GlassSprite>[
          const _GlassSprite(_violet, .18, .05, .62, .92, .02),
          const _GlassSprite(_blue, .64, .02, .25, .39, .08),
        ],
        PauseStage.home => const <_GlassSprite>[],
      };

      return Stack(
        clipBehavior: Clip.none,
        children: [
          for (final sprite in sprites)
            Positioned(
              left: constraints.maxWidth * sprite.left,
              top: constraints.maxHeight * sprite.top,
              width: constraints.maxWidth * sprite.width,
              height: constraints.maxHeight * sprite.height,
              child: Transform.rotate(
                angle: sprite.angle,
                child: Image.asset(
                  sprite.asset,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
        ],
      );
    },
  );
}

class _PauseMark extends CustomPainter {
  const _PauseMark(this.stage);
  final PauseStage stage;

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    final path = Path()
      ..moveTo(size.width * .08, size.height * .54)
      ..cubicTo(
        size.width * .06,
        size.height * .28,
        size.width * .32,
        size.height * .08,
        size.width * .54,
        size.height * .21,
      )
      ..cubicTo(
        size.width * .73,
        size.height * .33,
        size.width * .97,
        size.height * .30,
        size.width * .92,
        size.height * .60,
      )
      ..cubicTo(
        size.width * .89,
        size.height * .88,
        size.width * .63,
        size.height * .92,
        size.width * .40,
        size.height * .82,
      )
      ..cubicTo(
        size.width * .22,
        size.height * .75,
        size.width * .07,
        size.height * .82,
        size.width * .08,
        size.height * .54,
      )
      ..close();
    canvas.drawPath(
      path,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFB9FFF0), Color(0xFF4F9CB5), Color(0xFF9183C7)],
        ).createShader(bounds),
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = foam.withValues(alpha: .8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
    final point = switch (stage) {
      PauseStage.home || PauseStage.proposal => .50,
      PauseStage.guide => .66,
      PauseStage.finished => .82,
      PauseStage.stopped => .32,
    };
    canvas.drawCircle(
      Offset(size.width * point, size.height * .52),
      2.3,
      Paint()..color = softCoral,
    );
  }

  @override
  bool shouldRepaint(covariant _PauseMark oldDelegate) =>
      stage != oldDelegate.stage;
}
