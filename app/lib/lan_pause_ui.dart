import 'package:flutter/material.dart';

import 'lan_pause.dart';

Future<void> showLanPauseDialog(BuildContext context, LanPause lan) async {
  final info = await lan.pairingInfo();
  if (!context.mounted) return;
  final address = TextEditingController();
  final port = TextEditingController();
  final code = TextEditingController();
  final pin = TextEditingController();
  String? error;
  await showDialog<void>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (context, setState) => ListenableBuilder(
        listenable: lan,
        builder: (context, _) => AlertDialog(
          scrollable: true,
          title: const Text('Pausas en Omarchy'),
          content: SizedBox(
            width: 430,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (info != null) ...[
                  const Text(
                    'En el computador, abre esta app y escribe estos datos para emparejar:',
                  ),
                  const SizedBox(height: 10),
                  SelectableText(
                    'IP: ${info.address}\nPuerto: ${info.port}\nCertificado: ${info.code}\nPIN temporal: ${info.pin}',
                  ),
                  const Text(
                    'Comprueba el certificado y escribe el PIN en el computador antes de dos minutos.',
                  ),
                ] else if (!lan.isPhone) ...[
                  const Text(
                    'Abre nikucode en Android, entra en Pausas en Omarchy y escribe los datos que muestra el móvil.',
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: address,
                    decoration: const InputDecoration(
                      labelText: 'IP del móvil',
                    ),
                  ),
                  TextField(
                    controller: port,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Puerto'),
                  ),
                  TextField(
                    controller: code,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      labelText: 'Certificado: 16 caracteres',
                    ),
                  ),
                  TextField(
                    controller: pin,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      labelText: 'PIN temporal: 16 caracteres',
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                Text(lan.status),
                if (lan.pendingLabel != null) Text(lan.pendingLabel!),
                if (error != null)
                  Text(
                    error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                if (lan.canSchedule) ...[
                  const SizedBox(height: 16),
                  const Text('Nueva pausa en Omarchy'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final minutes in [5, 15, 30])
                        OutlinedButton(
                          onPressed: () async {
                            await lan.schedule(Duration(minutes: minutes));
                            if (dialogContext.mounted) {
                              Navigator.pop(dialogContext);
                            }
                          },
                          child: Text('$minutes min'),
                        ),
                      OutlinedButton(
                        onPressed: () async {
                          await lan.startNow();
                          if (dialogContext.mounted) {
                            Navigator.pop(dialogContext);
                          }
                        },
                        child: const Text('Iniciar ahora'),
                      ),
                    ],
                  ),
                  if (lan.pendingLabel != null)
                    TextButton(
                      onPressed: () => lan.cancelPending(),
                      child: const Text('Retirar solicitudes pendientes'),
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
                            'Se retirará el acceso en este dispositivo. Si el otro está desconectado, desvincúlalo allí también para retirar sus pausas pendientes.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Volver'),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Desvincular'),
                            ),
                          ],
                        ),
                      );
                      if (confirmed != true) return;
                      try {
                        await lan.unpair();
                        if (dialogContext.mounted) setState(() => error = null);
                      } catch (failure) {
                        if (dialogContext.mounted) {
                          setState(() => error = '$failure');
                        }
                      }
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
            if (!lan.isPhone)
              FilledButton(
                onPressed: () async {
                  try {
                    await lan.pair(
                      address.text.trim(),
                      int.tryParse(port.text.trim()) ?? 0,
                      code.text,
                      pin.text,
                    );
                    if (dialogContext.mounted) setState(() => error = null);
                  } catch (failure) {
                    if (dialogContext.mounted) {
                      setState(() => error = '$failure');
                    }
                  }
                },
                child: const Text('Emparejar'),
              ),
          ],
        ),
      ),
    ),
  );
  address.dispose();
  port.dispose();
  code.dispose();
  pin.dispose();
}
