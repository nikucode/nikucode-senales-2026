import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'app_preferences.dart';
import 'pause_view_model.dart';

const _sheetColor = Color(0xFF12323A);
const _sheetBorder = Color(0xFF49717A);
const _sheetText = Color(0xFFF3F8F5);
const _avatars = <IconData>[
  Icons.water_drop_outlined,
  Icons.waves_rounded,
  Icons.nightlight_outlined,
  Icons.spa_outlined,
];

Future<void> showMareaProfile(
  BuildContext context,
  AppPreferencesController preferences,
) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  sheetAnimationStyle:
      preferences.reduceMotion || MediaQuery.disableAnimationsOf(context)
      ? AnimationStyle.noAnimation
      : null,
  builder: (sheetContext) => ListenableBuilder(
    listenable: preferences,
    builder: (context, _) => _MareaSheet(
      highContrast: preferences.highContrast,
      textScale: preferences.textScale,
      child: _MareaProfileForm(preferences: preferences),
    ),
  ),
);

class _MareaProfileForm extends StatefulWidget {
  const _MareaProfileForm({required this.preferences});
  final AppPreferencesController preferences;

  @override
  State<_MareaProfileForm> createState() => _MareaProfileFormState();
}

class _MareaProfileFormState extends State<_MareaProfileForm> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.preferences.nickname,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SheetTitle('Mi espacio'),
        const Text(
          'Un apodo y un símbolo, si te sirven. Se guardan en este dispositivo.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 18),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          children: [
            for (var i = 0; i < _avatars.length; i++)
              Semantics(
                button: true,
                selected: widget.preferences.avatarIndex == i,
                label: 'Símbolo ${i + 1}',
                child: IconButton.filledTonal(
                  tooltip: 'Símbolo ${i + 1}',
                  onPressed: () => widget.preferences.setAvatarIndex(i),
                  icon: Icon(_avatars[i]),
                  style: IconButton.styleFrom(
                    minimumSize: const Size(52, 52),
                    foregroundColor: _sheetText,
                    backgroundColor: widget.preferences.avatarIndex == i
                        ? const Color(0xFF347D82)
                        : Colors.white.withValues(alpha: .08),
                    side: BorderSide(
                      color: widget.preferences.avatarIndex == i
                          ? const Color(0xFF9BF0DC)
                          : _sheetBorder,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _controller,
          maxLength: 30,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: 'Apodo opcional',
            border: OutlineInputBorder(),
          ),
          onSubmitted: widget.preferences.setNickname,
        ),
        FilledButton(
          onPressed: () async {
            await widget.preferences.setNickname(_controller.text);
            if (context.mounted) Navigator.pop(context);
          },
          child: const Text('Guardar en este dispositivo'),
        ),
        TextButton(
          onPressed: () async {
            await widget.preferences.clearProfile();
            if (!mounted) return;
            _controller.clear();
          },
          child: const Text('Borrar perfil local'),
        ),
      ],
    ),
  );
}

Future<void> showMareaSettings(
  BuildContext context,
  AppPreferencesController preferences,
) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  sheetAnimationStyle:
      preferences.reduceMotion || MediaQuery.disableAnimationsOf(context)
      ? AnimationStyle.noAnimation
      : null,
  builder: (sheetContext) => ListenableBuilder(
    listenable: preferences,
    builder: (context, _) => _MareaSheet(
      highContrast: preferences.highContrast,
      textScale: preferences.textScale,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SheetTitle('Ajustes de acceso'),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Mayor contraste'),
              subtitle: const Text(
                'Fondo más oscuro, texto claro y contornos reforzados.',
              ),
              value: preferences.highContrast,
              onChanged: preferences.setHighContrast,
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Reducir movimiento'),
              subtitle: const Text(
                'Detiene la flotación. Las nuevas ventanas se abren sin animación.',
              ),
              value: preferences.reduceMotion,
              onChanged: preferences.setReduceMotion,
            ),
            const SizedBox(height: 4),
            Text(
              'Tamaño de texto · ${(preferences.textScale * 100).round()}%',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Slider(
              min: 1,
              max: 1.6,
              divisions: 6,
              value: preferences.textScale,
              label: '${(preferences.textScale * 100).round()}%',
              onChanged: preferences.setTextScale,
            ),
            const Text(
              'Se combina con el tamaño de texto configurado en el sistema.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Listo'),
            ),
          ],
        ),
      ),
    ),
  ),
);

Future<void> showMareaPanorama(
  BuildContext context,
  PauseViewModel viewModel,
  AppPreferencesController preferences,
) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  sheetAnimationStyle:
      preferences.reduceMotion || MediaQuery.disableAnimationsOf(context)
      ? AnimationStyle.noAnimation
      : null,
  builder: (sheetContext) => ListenableBuilder(
    listenable: preferences,
    builder: (context, _) => ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final activity = viewModel.activity;
        final values = <({String label, int value})>[
          (label: 'Propuestas abiertas', value: activity.proposalsOpened),
          (label: 'Guías iniciadas', value: activity.guidesStarted),
          (label: 'Guías terminadas', value: activity.guidesFinished),
          (label: 'Guías detenidas', value: activity.guidesStopped),
          (label: 'Pospuestas', value: activity.postponements),
          (label: 'Cerradas por ahora', value: activity.proposalsDismissed),
        ];
        final maxValue = values.fold<int>(
          1,
          (current, metric) => math.max(current, metric.value).toInt(),
        );
        final hasInteractions = values.any((metric) => metric.value > 0);
        return _MareaSheet(
          highContrast: preferences.highContrast,
          textScale: preferences.textScale,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _SheetTitle('Mi panorama'),
                const Text(
                  'Interacciones de esta sesión',
                  textAlign: TextAlign.center,
                ),
                if (!hasInteractions) ...[
                  const SizedBox(height: 10),
                  const Text(
                    'Aún no hay interacciones registradas en esta sesión.',
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 14),
                Semantics(
                  container: true,
                  label: 'Gráfico de barras. Cada categoría incluye su conteo.',
                  child: Column(
                    children: [
                      for (final metric in values)
                        _MetricBar(
                          label: metric.label,
                          value: metric.value,
                          maxValue: maxValue,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Solo resume interacciones de esta sesión. No mide movimiento, sedentarismo, salud ni progreso.',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 6),
                const Text(
                  'No guarda historial por hora o día. Mostrarlo requeriría decidir el periodo, el almacenamiento y la privacidad.',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 14),
                FilledButton(
                  onPressed: () => Navigator.pop(sheetContext),
                  child: const Text('Cerrar panorama'),
                ),
              ],
            ),
          ),
        );
      },
    ),
  ),
);

class _MareaSheet extends StatelessWidget {
  const _MareaSheet({
    required this.child,
    this.highContrast = false,
    this.textScale = 1,
  });
  final Widget child;
  final bool highContrast;
  final double textScale;

  @override
  Widget build(BuildContext context) {
    final scale = math.max(
      MediaQuery.textScalerOf(context).scale(1),
      textScale,
    );
    final media = MediaQuery.of(context)
        .copyWith(textScaler: TextScaler.linear(scale.toDouble()));
    return MediaQuery(
      data: media,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          14,
          12,
          14,
          MediaQuery.viewInsetsOf(context).bottom + 14,
        ),
        child: SafeArea(
          top: false,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 620),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: (highContrast ? Colors.black : _sheetColor).withValues(
                alpha: .98,
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: highContrast ? _sheetText : _sheetBorder,
                width: highContrast ? 2.2 : 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .28),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: DefaultTextStyle(
              style: const TextStyle(color: _sheetText, height: 1.4),
              child: IconTheme(
                data: const IconThemeData(color: _sheetText),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SheetTitle extends StatelessWidget {
  const _SheetTitle(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color(0xFF9BF0DC),
        fontFamily: 'serif',
        fontSize: 26,
      ),
    ),
  );
}

class _MetricBar extends StatelessWidget {
  const _MetricBar({
    required this.label,
    required this.value,
    required this.maxValue,
  });

  final String label;
  final int value;
  final int maxValue;

  @override
  Widget build(BuildContext context) => Semantics(
    container: true,
    label: '$label: $value',
    child: ExcludeSemantics(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: Text(label)),
                Text(
                  '$value',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 12,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ColoredBox(color: Colors.white.withValues(alpha: .10)),
                    FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: value / maxValue,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF7BE2DC),
                              Color(0xFFC4A7F4),
                              Color(0xFFFFA9C5),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
