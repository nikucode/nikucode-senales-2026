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
) async {
  final controller = TextEditingController(text: preferences.nickname);
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => _MareaSheet(
      child: ListenableBuilder(
        listenable: preferences,
        builder: (context, _) => SingleChildScrollView(
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
                      selected: preferences.avatarIndex == i,
                      label: 'Símbolo ${i + 1}',
                      child: IconButton.filledTonal(
                        tooltip: 'Símbolo ${i + 1}',
                        onPressed: () => preferences.setAvatarIndex(i),
                        icon: Icon(_avatars[i]),
                        style: IconButton.styleFrom(
                          minimumSize: const Size(52, 52),
                          foregroundColor: _sheetText,
                          backgroundColor: preferences.avatarIndex == i
                              ? const Color(0xFF347D82)
                              : Colors.white.withValues(alpha: .08),
                          side: BorderSide(
                            color: preferences.avatarIndex == i
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
                controller: controller,
                maxLength: 30,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Apodo opcional',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: preferences.setNickname,
              ),
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
  );
  controller.dispose();
}

Future<void> showMareaSettings(
  BuildContext context,
  AppPreferencesController preferences,
) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (sheetContext) => _MareaSheet(
    child: ListenableBuilder(
      listenable: preferences,
      builder: (context, _) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SheetTitle('Ajustes de acceso'),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Mayor contraste'),
              subtitle: const Text(
                'Refuerza bordes y contraste de superficies.',
              ),
              value: preferences.highContrast,
              onChanged: preferences.setHighContrast,
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Reducir movimiento'),
              subtitle: const Text(
                'Detiene el movimiento decorativo continuo.',
              ),
              value: preferences.reduceMotion,
              onChanged: preferences.setReduceMotion,
            ),
            const SizedBox(height: 8),
            const Text(
              'El tamaño del texto sigue el sistema. Las acciones conservan etiquetas y no dependen solo del color.',
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => Navigator.pop(sheetContext),
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
) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (sheetContext) => _MareaSheet(
    child: ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final activity = viewModel.activity;
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _SheetTitle('Mi panorama'),
              const Text(
                'Interacciones de esta sesión',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 14),
              _Metric('Propuestas abiertas', activity.proposalsOpened),
              _Metric('Guías iniciadas', activity.guidesStarted),
              _Metric('Guías terminadas', activity.guidesFinished),
              _Metric('Guías detenidas', activity.guidesStopped),
              _Metric('Pospuestas', activity.postponements),
              _Metric('Cerradas por ahora', activity.proposalsDismissed),
              const SizedBox(height: 12),
              const Text(
                'Estos datos describen acciones dentro de la app. No comprueban movimiento, sedentarismo ni efectos sobre dolor.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 14),
              FilledButton(
                onPressed: () => Navigator.pop(sheetContext),
                child: const Text('Cerrar panorama'),
              ),
            ],
          ),
        );
      },
    ),
  ),
);

class _MareaSheet extends StatelessWidget {
  const _MareaSheet({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
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
          color: _sheetColor.withValues(alpha: .97),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: _sheetBorder, width: 1.4),
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
  );
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

class _Metric extends StatelessWidget {
  const _Metric(this.label, this.value);
  final String label;
  final int value;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 7),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: .06),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: _sheetBorder.withValues(alpha: .8)),
    ),
    child: Row(
      children: [
        Text(
          '$value',
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(label)),
      ],
    ),
  );
}
