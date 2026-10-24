import 'dart:async';

import 'package:flutter/material.dart';

import 'lan_pause.dart';

Future<void> showLanPauseDialog(BuildContext context, LanPause lan) async {
  String? error;
  bool busy = false;
  StateSetter? dialogSetState;
  Future<void> update() async {
    if (busy) return;
    busy = true;
    try {
      await lan.scanDesktops();
    } catch (failure) {
      dialogSetState?.call(() => error = '$failure');
    } finally {
      busy = false;
    }
  }

  unawaited(update());
  final refresh = Timer.periodic(
    const Duration(seconds: 2),
    (_) => unawaited(update()),
  );
  try {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) {
          dialogSetState = setState;
          return ListenableBuilder(
            listenable: lan,
            builder: (context, _) {
              Future<bool> action(Future<void> Function() work) async {
                try {
                  await work();
                  if (dialogContext.mounted) setState(() => error = null);
                  return true;
                } catch (failure) {
                  if (dialogContext.mounted) setState(() => error = '$failure');
                  return false;
                }
              }

              final code = lan.verificationCode;
              final grouped = code
                  ?.replaceAllMapped(RegExp(r'.{4}'), (match) => '${match[0]} ')
                  .trim();
              return AlertDialog(
                scrollable: true,
                title: const Text('Pausas en Omarchy'),
                content: SizedBox(
                  width: 430,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(lan.status),
                      if (lan.pendingLabel != null) Text(lan.pendingLabel!),
                      if (lan.isPhone && lan.paired && !lan.serviceRunning)
                        FilledButton(
                          onPressed: () => action(lan.startService),
                          child: const Text('Reactivar conexión'),
                        ),
                      if (error != null)
                        Text(
                          error!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      if (!lan.paired &&
                          lan.isPhone &&
                          !lan.pairingPending) ...[
                        const SizedBox(height: 14),
                        const Text(
                          'Selecciona tu computador en la misma WiFi:',
                        ),
                        if (lan.desktops.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Buscando Omarchy… Abre el servicio de nikucode en Linux.',
                            ),
                          ),
                        for (final desktop in lan.desktops)
                          ListTile(
                            title: Text(desktop.name),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () =>
                                action(() => lan.requestPair(desktop.id)),
                          ),
                        TextButton(
                          onPressed: () => action(update),
                          child: const Text('Buscar de nuevo'),
                        ),
                      ],
                      if (!lan.paired && !lan.isPhone && !lan.pairingPending)
                        const Padding(
                          padding: EdgeInsets.only(top: 14),
                          child: Text(
                            'Abre nikucode en Android y elige este computador.',
                          ),
                        ),
                      if (!lan.paired && lan.pairingPending) ...[
                        const SizedBox(height: 16),
                        if (grouped == null)
                          const Text(
                            'Esperando conexión para mostrar la clave…',
                          )
                        else ...[
                          const Text(
                            'Compara los 16 caracteres en ambos equipos:',
                          ),
                          const SizedBox(height: 8),
                          SelectableText(
                            grouped,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Confirma solo si la clave coincide exactamente.',
                          ),
                          Wrap(
                            spacing: 8,
                            children: [
                              if (lan.confirming)
                                const Text('Esperando al otro dispositivo…')
                              else
                                FilledButton(
                                  onPressed: () => action(lan.confirmPair),
                                  child: const Text('Coincide, confirmar'),
                                ),
                              OutlinedButton(
                                onPressed: () => action(lan.rejectPair),
                                child: const Text('Rechazar'),
                              ),
                            ],
                          ),
                        ],
                      ],
                      if (lan.canSchedule) ...[
                        const SizedBox(height: 16),
                        const Text(
                          'Programa o cancela las señales desde «Avisos, si los quieres» '
                          'en la pantalla principal. La misma invitación aparecerá aquí '
                          'y en Android.',
                        ),
                      ],
                      if (lan.paired)
                        TextButton(
                          onPressed: () async {
                            final confirmed = await showDialog<bool>(
                              context: dialogContext,
                              builder: (context) => AlertDialog(
                                title: const Text('Desvincular dispositivos'),
                                content: const Text(
                                  'Se retirará el acceso en este dispositivo. '
                                  'Si el otro está desconectado, desvincúlalo allí también.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Volver'),
                                  ),
                                  FilledButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text('Desvincular'),
                                  ),
                                ],
                              ),
                            );
                            if (confirmed == true) await action(lan.unpair);
                          },
                          child: const Text('Desvincular'),
                        ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text('Cerrar'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  } finally {
    refresh.cancel();
    await lan.stopScan();
  }
}
