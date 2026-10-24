import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_usage.dart';
import 'app_preferences.dart';
import 'interaction_history.dart';
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
  AppPreferencesController preferences, {
  AppUsageGateway usage = const AppUsageGateway(),
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  sheetAnimationStyle:
      preferences.reduceMotion || MediaQuery.disableAnimationsOf(context)
      ? AnimationStyle.noAnimation
      : null,
  builder: (sheetContext) => _PanoramaSheet(
    viewModel: viewModel,
    preferences: preferences,
    usage: usage,
    onClose: () => Navigator.pop(sheetContext),
  ),
);

class _PanoramaSheet extends StatefulWidget {
  const _PanoramaSheet({
    required this.viewModel,
    required this.preferences,
    required this.usage,
    required this.onClose,
  });

  final PauseViewModel viewModel;
  final AppPreferencesController preferences;
  final AppUsageGateway usage;
  final VoidCallback onClose;

  @override
  State<_PanoramaSheet> createState() => _PanoramaSheetState();
}

class _PanoramaSheetState extends State<_PanoramaSheet>
    with WidgetsBindingObserver {
  static const _weekdays = [
    'lunes',
    'martes',
    'miércoles',
    'jueves',
    'viernes',
    'sábado',
    'domingo',
  ];
  static const _shortDays = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
  static const _metricLabels = [
    'Propuestas abiertas',
    'Guías iniciadas',
    'Guías terminadas',
    'Guías detenidas',
    'Pospuestas',
    'Cerradas por ahora',
  ];

  late DateTime _monday = InteractionHistory.weekStart(DateTime.now());
  late int _selectedDay = DateTime.now().weekday - 1;
  List<DailyAppUsage>? _days;
  bool _loading = false;
  bool _needsAccess = false;
  String? _error;
  int _revision = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refresh();
  }

  @override
  void dispose() {
    _revision++;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refresh();
  }

  Future<void> _refresh() async {
    if (!widget.usage.supported) return;
    final revision = ++_revision;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final access = await widget.usage.hasAccess();
      if (!mounted || revision != _revision) return;
      if (!access) {
        setState(() {
          _needsAccess = true;
          _days = null;
          _loading = false;
        });
        return;
      }
      final days = await widget.usage.loadWeek(_monday);
      if (!mounted || revision != _revision) return;
      setState(() {
        _needsAccess = false;
        _days = days;
        _loading = false;
      });
    } on PlatformException catch (error) {
      if (!mounted || revision != _revision) return;
      setState(() {
        _needsAccess = error.code == 'usage_access_denied';
        _error = _needsAccess
            ? null
            : 'No se pudieron consultar los datos de uso.';
        _days = null;
        _loading = false;
      });
    } catch (_) {
      if (!mounted || revision != _revision) return;
      setState(() {
        _error = 'No se pudieron consultar los datos de uso.';
        _days = null;
        _loading = false;
      });
    }
  }

  void _changeWeek(int offset) {
    setState(() {
      _monday = DateTime(_monday.year, _monday.month, _monday.day + 7 * offset);
      _selectedDay = offset < 0 ? 0 : DateTime.now().weekday - 1;
      _days = null;
    });
    _refresh();
  }

  Future<void> _clearHistory() async {
    final confirmed = await showDialog<bool>(
      context: context,
      animationStyle:
          widget.preferences.reduceMotion ||
              MediaQuery.disableAnimationsOf(context)
          ? AnimationStyle.noAnimation
          : null,
      builder: (context) => AlertDialog(
        title: const Text('Borrar historial de interacciones'),
        content: const Text(
          'Se borrarán los conteos guardados de nikucode en este dispositivo.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Borrar historial'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    await widget.viewModel.history.clear();
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: widget.preferences,
    builder: (context, _) => ListenableBuilder(
      listenable: widget.viewModel.history,
      builder: (context, _) {
        final totals = widget.viewModel.history.totalsForWeek(_monday);
        final maxValue = totals.fold<int>(1, math.max);
        final selectedDate = DateTime(
          _monday.year,
          _monday.month,
          _monday.day + _selectedDay,
        );
        final currentWeek = InteractionHistory.weekStart(DateTime.now());
        final canAdvance = _monday.isBefore(currentWeek);
        final selected = _days != null && _days!.length == 7
            ? _days![_selectedDay]
            : null;
        return _MareaSheet(
          highContrast: widget.preferences.highContrast,
          textScale: widget.preferences.textScale,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * .76,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _SheetTitle('Mi panorama'),
                  Row(
                    children: [
                      IconButton(
                        tooltip: 'Semana anterior',
                        onPressed: () => _changeWeek(-1),
                        icon: const Icon(Icons.chevron_left),
                      ),
                      Expanded(
                        child: Text(
                          '${_monday.day}/${_monday.month} – ${DateTime(_monday.year, _monday.month, _monday.day + 6).day}/${DateTime(_monday.year, _monday.month, _monday.day + 6).month}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Semana siguiente',
                        onPressed: canAdvance ? () => _changeWeek(1) : null,
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Tiempo de uso de apps',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  if (!widget.usage.supported)
                    const Text(
                      'Disponible en Android. Las interacciones de nikucode se muestran abajo.',
                      textAlign: TextAlign.center,
                    )
                  else if (_loading)
                    const Center(child: CircularProgressIndicator())
                  else if (_needsAccess) ...[
                    const Text(
                      'Si quieres ver el uso de tus apps, concede acceso a estadísticas de uso en los ajustes de Android. Los datos se consultan en este teléfono y no se guardan en nikucode.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    FilledButton(
                      onPressed: () async {
                        try {
                          await widget.usage.openAccessSettings();
                        } catch (_) {
                          if (mounted) {
                            setState(
                              () => _error = 'No se pudieron abrir los ajustes de Android.',
                            );
                          }
                        }
                      },
                      child: const Text('Activar acceso al uso'),
                    ),
                  ] else if (_error != null)
                    Text(_error!, textAlign: TextAlign.center)
                  else if (_days != null && _days!.length == 7) ...[
                    _weekChart(),
                    const SizedBox(height: 14),
                    Text(
                      '${_weekdays[_selectedDay]} ${selectedDate.day}/${selectedDate.month} · ${_duration(selected!.milliseconds)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (selectedDate.isAfter(DateTime.now()))
                      const Text(
                        'Este día aún no llega.',
                        textAlign: TextAlign.center,
                      )
                    else if (selected.apps.isEmpty)
                      Text(
                        selectedDate.year == DateTime.now().year &&
                                selectedDate.month == DateTime.now().month &&
                                selectedDate.day == DateTime.now().day
                            ? '0 min de uso registrados hoy.'
                            : 'No hay datos de uso registrados para este día.',
                        textAlign: TextAlign.center,
                      )
                    else
                      for (final app in selected.apps)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: app.icon != null && app.icon!.isNotEmpty
                              ? Image.memory(app.icon!, width: 38, height: 38)
                              : const Icon(Icons.apps_rounded),
                          title: Text(app.label),
                          subtitle: Text(_duration(app.milliseconds)),
                        ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tiempo en primer plano informado por Android; puede diferir de Bienestar digital.',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                  if (_error != null && _needsAccess)
                    Text(_error!, textAlign: TextAlign.center),
                  const Divider(height: 38),
                  const Text(
                    'Interacciones de la semana',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  if (totals.every((value) => value == 0))
                    const Text(
                      'Aún no hay interacciones registradas en esta semana.',
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 12),
                  Semantics(
                    container: true,
                    label:
                        'Conteos de interacciones de nikucode en esta semana.',
                    child: Column(
                      children: [
                        for (var index = 0; index < totals.length; index++)
                          _MetricBar(
                            label: _metricLabels[index],
                            value: totals[index],
                            maxValue: maxValue,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Estos conteos registran acciones en nikucode; no miden movimiento, sedentarismo, salud ni progreso.',
                    style: TextStyle(fontSize: 13),
                  ),
                  const Text(
                    'El historial de interacciones comienza con esta versión de la app.',
                    style: TextStyle(fontSize: 13),
                  ),
                  if (widget.viewModel.history.saveFailed)
                    const Text(
                      'No se pudo guardar el historial de interacciones en este dispositivo.',
                    ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: _clearHistory,
                    child: const Text('Borrar historial de interacciones'),
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: widget.onClose,
                    child: const Text('Cerrar panorama'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );

  Widget _weekChart() {
    final days = _days!;
    final maxDuration = days.fold<int>(
      1,
      (max, day) => math.max(max, day.milliseconds),
    );
    return SizedBox(
      height: 180,
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 27,
            child: IgnorePointer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var line = 0; line < 5; line++)
                    Divider(
                      height: 1,
                      color: _sheetText.withValues(alpha: .25),
                    ),
                ],
              ),
            ),
          ),
          Positioned.fill(child: _weekBars(days, maxDuration)),
        ],
      ),
    );
  }

  Widget _weekBars(List<DailyAppUsage> days, int maxDuration) => Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      for (var index = 0; index < 7; index++)
        Expanded(
          child: Semantics(
            button: true,
            selected: index == _selectedDay,
            label:
                '${_weekdays[index]}: ${_duration(days[index].milliseconds)}',
            child: InkWell(
              onTap: () => setState(() => _selectedDay = index),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Column(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FractionallySizedBox(
                          heightFactor: days[index].milliseconds == 0
                              ? 0
                              : math.max(
                                  .04,
                                  days[index].milliseconds / maxDuration,
                                ),
                          widthFactor: .8,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: index == _selectedDay
                                  ? const Color(0xFFD8C4FF)
                                  : const Color(0xFF9BF0DC),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(9),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(_shortDays[index]),
                  ],
                ),
              ),
            ),
          ),
        ),
    ],
  );

  String _duration(int milliseconds) {
    final minutes = (milliseconds / Duration.millisecondsPerMinute).round();
    if (minutes < 60) return '$minutes min';
    final hours = minutes ~/ 60;
    final rest = minutes % 60;
    return rest == 0 ? '$hours h' : '$hours h $rest min';
  }
}

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
