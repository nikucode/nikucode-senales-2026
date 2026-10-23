import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_preferences.dart';
import 'pause_view_model.dart';

const _aeroInk = Color(0xFF14333D);
const _aeroMuted = Color(0xFF46616A);
const _aeroBlue = Color(0xFF65CBE3);
const _aeroMint = Color(0xFF91DDC5);
const _aeroPink = Color(0xFFF1C9CF);
const _aeroGreen = Color(0xFF8DD36F);

class AeroPauseHome extends StatefulWidget {
  const AeroPauseHome({
    super.key,
    required this.viewModel,
    required this.preferences,
  });

  final PauseViewModel viewModel;
  final AppPreferencesController preferences;

  @override
  State<AeroPauseHome> createState() => _AeroPauseHomeState();
}

class _AeroPauseHomeState extends State<AeroPauseHome> {
  bool _menuOpen = false;

  bool get _reduceMotion =>
      MediaQuery.disableAnimationsOf(context) ||
      widget.preferences.reduceMotion;

  void _closeMenu() {
    if (_menuOpen) setState(() => _menuOpen = false);
  }

  void _openPause() {
    _closeMenu();
    widget.viewModel.openProposal();
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: widget.viewModel,
    builder: (context, _) => ListenableBuilder(
      listenable: widget.preferences,
      builder: (context, _) {
        final onHome = widget.viewModel.stage == PauseStage.home;
        if (!onHome && _menuOpen) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _closeMenu();
          });
        }
        return Scaffold(
          body: Stack(
            children: [
              const Positioned.fill(child: _AeroBackground()),
              SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      constraints.maxWidth < 600 ? 18 : 32,
                      12,
                      constraints.maxWidth < 600 ? 18 : 32,
                      onHome ? 112 : 28,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 720,
                          minHeight:
                              (constraints.maxHeight - (onHome ? 124 : 40))
                                  .clamp(0, 2000),
                        ),
                        child: Column(
                          children: [
                            _AeroTopBar(
                              viewModel: widget.viewModel,
                              preferences: widget.preferences,
                              onProfile: () =>
                                  _showProfile(context, widget.preferences),
                              onSettings: () =>
                                  _showSettings(context, widget.preferences),
                            ),
                            const SizedBox(height: 18),
                            AnimatedSwitcher(
                              duration: _reduceMotion
                                  ? Duration.zero
                                  : const Duration(milliseconds: 280),
                              switchInCurve: Curves.easeOutCubic,
                              switchOutCurve: Curves.easeInCubic,
                              transitionBuilder: (child, animation) =>
                                  FadeTransition(
                                    opacity: animation,
                                    child: ScaleTransition(
                                      scale: Tween<double>(
                                        begin: .97,
                                        end: 1,
                                      ).animate(animation),
                                      child: child,
                                    ),
                                  ),
                              child: KeyedSubtree(
                                key: ValueKey(widget.viewModel.stage),
                                child: _StagePanel(
                                  vm: widget.viewModel,
                                  highContrast: widget.preferences.highContrast,
                                  onPause: _openPause,
                                ),
                              ),
                            ),
                            if (widget.viewModel.hasPendingReminder) ...[
                              const SizedBox(height: 10),
                              TextButton(
                                onPressed: widget.viewModel.cancelReminder,
                                child: Text(
                                  'Cancelar aviso · ${TimeOfDay.fromDateTime(widget.viewModel.reminderAt!).format(context)}',
                                ),
                              ),
                            ],
                            if (widget.viewModel.message != null) ...[
                              const SizedBox(height: 8),
                              Semantics(
                                liveRegion: true,
                                child: Text(
                                  widget.viewModel.message!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: _aeroMuted),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (onHome && _menuOpen)
                Positioned.fill(
                  child: GestureDetector(
                    key: const Key('radialMenuBarrier'),
                    behavior: HitTestBehavior.opaque,
                    onTap: _closeMenu,
                    child: ColoredBox(color: const Color(0x26133C47)),
                  ),
                ),
              if (onHome)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 8,
                  child: Center(
                    child: _AeroRadialMenu(
                      open: _menuOpen,
                      reduceMotion: _reduceMotion,
                      highContrast: widget.preferences.highContrast,
                      onToggle: () => setState(() => _menuOpen = !_menuOpen),
                      onPause: _openPause,
                      onReminder: () {
                        _closeMenu();
                        _showReminders(context, widget.viewModel);
                      },
                      onDashboard: () {
                        _closeMenu();
                        _showDashboard(context, widget.viewModel);
                      },
                      onProfile: () {
                        _closeMenu();
                        _showProfile(context, widget.preferences);
                      },
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    ),
  );
}

class _AeroBackground extends StatelessWidget {
  const _AeroBackground();

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF9F8F3), Color(0xFFEAF9F7), Color(0xFFFFF3F2)],
        stops: [0, .55, 1],
      ),
    ),
    child: CustomPaint(painter: _AeroBackgroundPainter()),
  );
}

class _AeroBackgroundPainter extends CustomPainter {
  const _AeroBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final blue = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0x5C7BDCF0), Color(0x007BDCF0)])
              .createShader(
                Rect.fromCircle(
                  center: Offset(size.width * .12, size.height * .2),
                  radius: size.shortestSide * .55,
                ),
              );
    final pink = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0x4CF2C0C7), Color(0x00F2C0C7)])
              .createShader(
                Rect.fromCircle(
                  center: Offset(size.width * .94, size.height * .7),
                  radius: size.shortestSide * .48,
                ),
              );
    canvas
      ..drawCircle(
        Offset(size.width * .12, size.height * .2),
        size.shortestSide * .55,
        blue,
      )
      ..drawCircle(
        Offset(size.width * .94, size.height * .7),
        size.shortestSide * .48,
        pink,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AeroTopBar extends StatelessWidget {
  const _AeroTopBar({
    required this.viewModel,
    required this.preferences,
    required this.onProfile,
    required this.onSettings,
  });

  final PauseViewModel viewModel;
  final AppPreferencesController preferences;
  final VoidCallback onProfile;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    if (viewModel.stage != PauseStage.home) {
      return Row(
        children: [
          const Expanded(child: _BrandPill()),
          const SizedBox(width: 12),
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
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _TopOrbButton(
          key: const Key('profileButton'),
          tooltip: preferences.displayName,
          icon: _avatarIcons[preferences.avatarIndex],
          onPressed: onProfile,
        ),
        const Flexible(child: _BrandPill()),
        _TopOrbButton(
          key: const Key('settingsButton'),
          tooltip: 'Configuración y accesibilidad',
          icon: Icons.tune_rounded,
          onPressed: onSettings,
        ),
      ],
    );
  }
}

class _BrandPill extends StatelessWidget {
  const _BrandPill();

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'nikucode pausa',
    header: true,
    child: _GlassSurface(
      radius: 24,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: const Text(
        'nikucode · pausa',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: _aeroInk,
          fontWeight: FontWeight.w700,
          letterSpacing: .2,
        ),
      ),
    ),
  );
}

class _TopOrbButton extends StatelessWidget {
  const _TopOrbButton({
    super.key,
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: tooltip,
    child: Semantics(
      button: true,
      label: tooltip,
      child: InkResponse(
        onTap: onPressed,
        radius: 28,
        child: _GlossOrb(
          size: 50,
          color: _aeroMint,
          child: Icon(icon, color: _aeroInk, size: 25),
        ),
      ),
    ),
  );
}

class _StagePanel extends StatelessWidget {
  const _StagePanel({
    required this.vm,
    required this.highContrast,
    required this.onPause,
  });

  final PauseViewModel vm;
  final bool highContrast;
  final VoidCallback onPause;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 600;
    final content = switch (vm.stage) {
      PauseStage.home => <Widget>[
        _GlossOrb(
          size: compact ? 108 : 132,
          color: _aeroBlue,
          child: const Icon(Icons.spa_rounded, color: _aeroInk, size: 44),
        ),
        const SizedBox(height: 22),
        const _AeroTitle('Una pausa que cabe en tu día'),
        const SizedBox(height: 12),
        const Text(
          'A veces cuesta dejar lo que estás haciendo. Puedes probar algo pequeño, cambiarlo o dejarlo pasar.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 22),
        FilledButton.icon(
          onPressed: onPause,
          icon: const Icon(Icons.arrow_forward_rounded),
          label: const Text('Ver una pausa'),
        ),
        const SizedBox(height: 8),
        const Text(
          'También puedes abrir la esfera inferior para ver más opciones.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: _aeroMuted),
        ),
      ],
      PauseStage.proposal => <Widget>[
        _GlossOrb(
          size: compact ? 82 : 96,
          color: _aeroGreen,
          child: const Icon(
            Icons.directions_walk_rounded,
            color: _aeroInk,
            size: 38,
          ),
        ),
        const SizedBox(height: 18),
        _AeroTitle(vm.proposal.title),
        const SizedBox(height: 10),
        Text(vm.proposal.instruction, textAlign: TextAlign.center),
        const SizedBox(height: 22),
        FilledButton(
          onPressed: vm.startGuide,
          child: const Text('Empezar guía'),
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: vm.changeProposal,
          icon: const Icon(Icons.shuffle_rounded),
          label: const Text('Cambiar propuesta'),
        ),
        TextButton(
          onPressed: () => _showReminders(context, vm),
          child: const Text('Más tarde'),
        ),
      ],
      PauseStage.guide => <Widget>[
        _GlossOrb(
          size: compact ? 82 : 96,
          color: _aeroMint,
          child: const Icon(Icons.air_rounded, color: _aeroInk, size: 38),
        ),
        const SizedBox(height: 18),
        const _AeroTitle('A tu ritmo'),
        const SizedBox(height: 10),
        const Text(
          'Puedes dejar la pantalla. Vuelve cuando quieras cerrar la guía.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(vm.proposal.instruction, textAlign: TextAlign.center),
        const SizedBox(height: 22),
        FilledButton(
          onPressed: vm.finishGuide,
          child: const Text('Cerrar guía'),
        ),
        const SizedBox(height: 8),
        TextButton(onPressed: vm.stopGuide, child: const Text('Detener guía')),
      ],
      PauseStage.finished || PauseStage.stopped => <Widget>[
        _GlossOrb(
          size: compact ? 88 : 104,
          color: vm.stage == PauseStage.stopped ? _aeroPink : _aeroMint,
          child: Icon(
            vm.stage == PauseStage.stopped
                ? Icons.close_rounded
                : Icons.check_rounded,
            color: _aeroInk,
            size: 42,
          ),
        ),
        const SizedBox(height: 18),
        _AeroTitle(
          vm.stage == PauseStage.stopped ? 'Guía detenida' : 'Guía terminada',
        ),
        const SizedBox(height: 10),
        const Text(
          'La app registra el cierre de la guía, no movimiento corporal.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 22),
        FilledButton(
          onPressed: vm.goHome,
          child: const Text('Volver al inicio'),
        ),
      ],
    };

    return _GlassSurface(
      radius: 36,
      highContrast: highContrast,
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 22 : 48,
        vertical: compact ? 28 : 42,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: content),
    );
  }
}

class _AeroTitle extends StatelessWidget {
  const _AeroTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Semantics(
    header: true,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: _aeroInk,
        fontSize: MediaQuery.sizeOf(context).width < 600 ? 28 : 34,
        height: 1.15,
        fontWeight: FontWeight.w700,
        letterSpacing: -.5,
      ),
    ),
  );
}

class _AeroRadialMenu extends StatelessWidget {
  const _AeroRadialMenu({
    required this.open,
    required this.reduceMotion,
    required this.highContrast,
    required this.onToggle,
    required this.onPause,
    required this.onReminder,
    required this.onDashboard,
    required this.onProfile,
  });

  final bool open;
  final bool reduceMotion;
  final bool highContrast;
  final VoidCallback onToggle;
  final VoidCallback onPause;
  final VoidCallback onReminder;
  final VoidCallback onDashboard;
  final VoidCallback onProfile;

  static const _center = Offset(175, 226);
  static const _actions = <Offset>[
    Offset(40, 138),
    Offset(102, 54),
    Offset(198, 36),
    Offset(292, 104),
  ];

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(end: open ? 1 : 0),
    duration: reduceMotion ? Duration.zero : const Duration(milliseconds: 420),
    curve: Curves.easeInOutCubic,
    builder: (context, progress, _) {
      final separation = Curves.easeOutBack.transform(progress.clamp(0, 1));
      final specs = [
        _MenuActionSpec(
          'Mi espacio',
          Icons.person_outline_rounded,
          _aeroPink,
          onProfile,
        ),
        _MenuActionSpec(
          'Preparar aviso',
          Icons.notifications_none_rounded,
          _aeroBlue,
          onReminder,
        ),
        _MenuActionSpec('Pausa ahora', Icons.spa_rounded, _aeroGreen, onPause),
        _MenuActionSpec(
          'Mi panorama',
          Icons.insights_rounded,
          _aeroMint,
          onDashboard,
        ),
      ];
      return SizedBox(
        width: 350,
        height: 270,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _MetaballPainter(
                    progress: reduceMotion ? 1 : progress,
                    center: _center,
                    targets: _actions,
                    color: highContrast
                        ? const Color(0xFFBCEFF2)
                        : const Color(0x99E8FFFF),
                  ),
                ),
              ),
            ),
            for (var index = 0; index < specs.length; index++)
              _positionedAction(
                specs[index],
                _actions[index],
                separation,
                progress,
                index,
              ),
            Positioned(
              left: _center.dx - (72 - 20 * progress),
              top: _center.dy - 32,
              child: Semantics(
                button: true,
                label: open ? 'Cerrar menú de pausa' : 'Abrir menú de pausa',
                expanded: open,
                child: InkWell(
                  key: const Key('radialMenuButton'),
                  onTap: onToggle,
                  borderRadius: BorderRadius.circular(34),
                  child: _GlossCapsule(
                    width: 144 - 40 * progress,
                    color: _aeroBlue,
                    child: progress > .55
                        ? const Icon(Icons.close_rounded, color: _aeroInk)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (MediaQuery.textScalerOf(context).scale(1) <=
                                  1.3) ...[
                                const Icon(
                                  Icons.bubble_chart_rounded,
                                  color: _aeroInk,
                                ),
                                const SizedBox(width: 8),
                              ],
                              const Flexible(
                                child: Text(
                                  'Pausa',
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    color: _aeroInk,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  Widget _positionedAction(
    _MenuActionSpec spec,
    Offset target,
    double separation,
    double progress,
    int index,
  ) {
    final point = Offset.lerp(_center, target, separation)!;
    return Positioned(
      left: point.dx - 45,
      top: point.dy - 36,
      child: IgnorePointer(
        ignoring: !open,
        child: ExcludeSemantics(
          excluding: !open,
          child: Opacity(
            opacity: progress.clamp(0, 1),
            child: Transform.scale(
              scale: .65 + .35 * progress.clamp(0, 1),
              child: Semantics(
                button: true,
                label: spec.label,
                child: InkWell(
                  key: Key('radialAction$index'),
                  onTap: spec.onTap,
                  borderRadius: BorderRadius.circular(36),
                  child: SizedBox(
                    width: 90,
                    child: Column(
                      children: [
                        _GlossOrb(
                          size: 62,
                          color: spec.color,
                          child: Icon(spec.icon, color: _aeroInk, size: 28),
                        ),
                        const SizedBox(height: 4),
                        _GlassSurface(
                          radius: 13,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          child: Text(
                            spec.label,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                              color: _aeroInk,
                              fontSize: 11,
                              height: 1.05,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuActionSpec {
  const _MenuActionSpec(this.label, this.icon, this.color, this.onTap);
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
}

class _MetaballPainter extends CustomPainter {
  const _MetaballPainter({
    required this.progress,
    required this.center,
    required this.targets,
    required this.color,
  });

  final double progress;
  final Offset center;
  final List<Offset> targets;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0 || progress >= .88) return;
    final travel = Curves.easeOutCubic.transform(progress.clamp(0, 1));
    final fade = progress < .55 ? progress / .55 : (1 - progress) / .45;
    final paint = Paint()
      ..color = color.withValues(alpha: (.58 * fade.clamp(0, 1)))
      ..strokeWidth = 34 * (1 - .35 * progress)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    for (final target in targets) {
      canvas.drawLine(center, Offset.lerp(center, target, travel)!, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _MetaballPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}

class _GlassSurface extends StatelessWidget {
  const _GlassSurface({
    required this.child,
    this.padding = EdgeInsets.zero,
    this.radius = 28,
    this.highContrast = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final bool highContrast;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: highContrast ? .94 : .68),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: highContrast
                ? const Color(0xFF3D7180)
                : Colors.white.withValues(alpha: .86),
            width: highContrast ? 1.8 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4A7B82).withValues(alpha: .15),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: .75),
              blurRadius: 8,
              offset: const Offset(-2, -3),
            ),
          ],
        ),
        child: child,
      ),
    ),
  );
}

class _GlossOrb extends StatelessWidget {
  const _GlossOrb({
    required this.size,
    required this.color,
    required this.child,
  });

  final double size;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        center: const Alignment(-.35, -.45),
        radius: 1.15,
        colors: [Colors.white.withValues(alpha: .92), color, color.darken(.16)],
        stops: const [0, .48, 1],
      ),
      border: Border.all(
        color: Colors.white.withValues(alpha: .92),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: .38),
          blurRadius: 20,
          offset: const Offset(0, 9),
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: .82),
          blurRadius: 5,
          offset: const Offset(-2, -3),
        ),
      ],
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          top: size * .13,
          left: size * .22,
          right: size * .22,
          child: IgnorePointer(
            child: Container(
              height: size * .16,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .55),
                borderRadius: BorderRadius.circular(size),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _GlossCapsule extends StatelessWidget {
  const _GlossCapsule({
    required this.width,
    required this.color,
    required this.child,
  });

  final double width;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: 64,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(34),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white.withValues(alpha: .94), color, color.darken(.12)],
        stops: const [0, .55, 1],
      ),
      border: Border.all(
        color: Colors.white.withValues(alpha: .94),
        width: 1.6,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: .42),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          top: 8,
          left: 22,
          right: 22,
          child: Container(
            height: 9,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .55),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    ),
  );
}

extension on Color {
  Color darken(double amount) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness((hsl.lightness - amount).clamp(0, 1)).toColor();
  }
}

const _avatarIcons = [
  Icons.water_drop_outlined,
  Icons.eco_outlined,
  Icons.wb_sunny_outlined,
  Icons.bubble_chart_outlined,
];

Future<void> _showProfile(
  BuildContext context,
  AppPreferencesController preferences,
) async {
  final controller = TextEditingController(text: preferences.nickname);
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => Padding(
      padding: EdgeInsets.only(
        left: 14,
        right: 14,
        bottom: MediaQuery.viewInsetsOf(sheetContext).bottom + 14,
      ),
      child: SafeArea(
        top: false,
        child: _GlassSurface(
          radius: 34,
          highContrast: preferences.highContrast,
          padding: const EdgeInsets.all(24),
          child: ListenableBuilder(
            listenable: preferences,
            builder: (context, _) => SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _AeroTitle('Mi espacio'),
                  const SizedBox(height: 8),
                  const Text(
                    'Tu perfil es opcional y se guarda solo en este dispositivo.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      for (var index = 0; index < _avatarIcons.length; index++)
                        Semantics(
                          button: true,
                          selected: preferences.avatarIndex == index,
                          label: 'Avatar ${index + 1}',
                          child: InkResponse(
                            onTap: () => preferences.setAvatarIndex(index),
                            radius: 32,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: preferences.avatarIndex == index
                                      ? const Color(0xFF07546D)
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: _GlossOrb(
                                  size: 54,
                                  color: index.isEven ? _aeroMint : _aeroPink,
                                  child: Icon(
                                    _avatarIcons[index],
                                    color: _aeroInk,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    key: const Key('nicknameField'),
                    controller: controller,
                    maxLength: 30,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: '¿Cómo quieres que te llamemos?',
                      hintText: 'Apodo opcional',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: preferences.setNickname,
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: () async {
                      await preferences.setNickname(controller.text);
                      if (sheetContext.mounted) Navigator.pop(sheetContext);
                    },
                    child: const Text('Guardar en este dispositivo'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await preferences.clearProfile();
                      controller.clear();
                    },
                    child: const Text('Borrar perfil local'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
  controller.dispose();
}

Future<void> _showSettings(
  BuildContext context,
  AppPreferencesController preferences,
) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (sheetContext) => Padding(
    padding: const EdgeInsets.all(14),
    child: SafeArea(
      top: false,
      child: _GlassSurface(
        radius: 34,
        highContrast: preferences.highContrast,
        padding: const EdgeInsets.all(22),
        child: ListenableBuilder(
          listenable: preferences,
          builder: (context, _) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _AeroTitle('Accesibilidad y apariencia'),
                const SizedBox(height: 12),
                SwitchListTile(
                  key: const Key('highContrastSwitch'),
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Mayor contraste'),
                  subtitle: const Text(
                    'Refuerza bordes y opacidad de las superficies.',
                  ),
                  value: preferences.highContrast,
                  onChanged: preferences.setHighContrast,
                ),
                SwitchListTile(
                  key: const Key('reduceMotionSwitch'),
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Reducir movimiento'),
                  subtitle: const Text(
                    'Las opciones aparecen sin la división orgánica.',
                  ),
                  value: preferences.reduceMotion,
                  onChanged: preferences.setReduceMotion,
                ),
                const SizedBox(height: 8),
                const Text(
                  'El tamaño del texto sigue la configuración del sistema. Los colores nunca son la única señal de estado.',
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => Navigator.pop(sheetContext),
                  child: const Text('Listo'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  ),
);

Future<void> _showDashboard(
  BuildContext context,
  PauseViewModel vm,
) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (sheetContext) {
    final activity = vm.activity;
    return Padding(
      padding: const EdgeInsets.all(14),
      child: SafeArea(
        top: false,
        child: _GlassSurface(
          radius: 34,
          padding: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _AeroTitle('Mi panorama'),
                const SizedBox(height: 8),
                const Text(
                  'Interacciones de esta sesión',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                Column(
                  children:
                      [
                            _MetricChip(
                              'Propuestas abiertas',
                              activity.proposalsOpened,
                            ),
                            _MetricChip(
                              'Guías iniciadas',
                              activity.guidesStarted,
                            ),
                            _MetricChip(
                              'Guías terminadas',
                              activity.guidesFinished,
                            ),
                            _MetricChip(
                              'Guías detenidas',
                              activity.guidesStopped,
                            ),
                            _MetricChip('Más tarde', activity.postponements),
                            _MetricChip(
                              'Ahora no',
                              activity.proposalsDismissed,
                            ),
                          ]
                          .map(
                            (metric) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: metric,
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 18),
                _GlassSurface(
                  radius: 24,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.phone_android_rounded, color: _aeroInk),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Tiempo en pantalla y apps usadas',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'No conectado en esta demo. Android requerirá un permiso especial y procesamiento local explícito.',
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => showDialog<void>(
                          context: sheetContext,
                          builder: (context) => AlertDialog(
                            title: const Text('Acceso opcional'),
                            content: const Text(
                              'El tiempo de una app en primer plano no demuestra que la persona esté sentada o mirando la pantalla. Esta función se probará por separado y nunca será obligatoria.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Entendido'),
                              ),
                            ],
                          ),
                        ),
                        child: const Text('¿Por qué necesita permiso?'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Estos datos describen acciones dentro de nikucode. No comprueban movimiento, sedentarismo ni efectos sobre dolor.',
                  style: TextStyle(fontSize: 14, color: _aeroMuted),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => Navigator.pop(sheetContext),
                  child: const Text('Cerrar panorama'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  },
);

class _MetricChip extends StatelessWidget {
  const _MetricChip(this.label, this.value);
  final String label;
  final int value;

  @override
  Widget build(BuildContext context) => _GlassSurface(
    radius: 20,
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    child: Row(
      children: [
        Text(
          '$value',
          style: const TextStyle(
            color: _aeroInk,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(label)),
      ],
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
                'El canal aún no está disponible aquí. Puedes abrir una pausa manualmente.',
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
              const SizedBox(height: 12),
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
