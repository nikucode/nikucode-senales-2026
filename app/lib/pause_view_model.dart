import 'dart:async';

import 'package:flutter/foundation.dart';

import 'reminder_channel.dart';

enum PauseStage { home, proposal, guide, finished, stopped }

@immutable
class MovementProposal {
  const MovementProposal({
    required this.title,
    required this.instruction,
    required this.contextLabel,
  });

  final String title;
  final String instruction;
  final String contextLabel;
}

/// State for the brief invitation flow; it never infers bodily movement.
class PauseViewModel extends ChangeNotifier {
  PauseViewModel({required this.channel}) {
    channel.onOpen = openFromReminder;
  }

  static const _proposals = [
    MovementProposal(
      title: 'Caminar un momento',
      instruction:
          'Camina a tu ritmo, si te resulta adecuado. Puedes apartar la '
          'mirada de la pantalla.',
      contextLabel: 'Si tienes espacio y puedes caminar',
    ),
    MovementProposal(
      title: 'Tu movimiento habitual',
      instruction:
          'Haz un movimiento cómodo, en la posición que prefieras. Puedes '
          'apartar la mirada de la pantalla.',
      contextLabel: 'En la posición que prefieras',
    ),
  ];

  final ReminderChannel channel;
  PauseStage _stage = PauseStage.home;
  int _proposalIndex = 0;
  bool _remindersEnabled = false;
  DateTime? _reminderAt;
  String? _message;
  Timer? _timer;
  int _generation = 0;
  int? _invitationId;
  int _permissionRevision = 0;
  bool _disposed = false;
  Future<void> _channelWork = Future<void>.value();

  PauseStage get stage => _stage;
  MovementProposal get proposal => _proposals[_proposalIndex];
  bool get remindersEnabled => _remindersEnabled;
  DateTime? get reminderAt => _reminderAt;
  String? get message => _message;
  bool get hasPendingReminder => _timer != null;
  String get channelScope => channel.scopeLabel;
  bool get channelSupported => channel.supported;

  void openProposal() {
    if (_disposed || _stage == PauseStage.guide) return;
    _invalidateInvitation();
    _stage = PauseStage.proposal;
    _message = null;
    _notify();
  }

  void changeProposal() {
    if (_disposed || _stage != PauseStage.proposal) return;
    _proposalIndex = (_proposalIndex + 1) % _proposals.length;
    _notify();
  }

  void startGuide() {
    if (_disposed || _stage != PauseStage.proposal) return;
    _invalidateInvitation();
    _stage = PauseStage.guide;
    _message = null;
    _notify();
  }

  void finishGuide() {
    if (_disposed || _stage != PauseStage.guide) return;
    _stage = PauseStage.finished;
    _notify();
  }

  void stopGuide() {
    if (_disposed || _stage != PauseStage.guide) return;
    _stage = PauseStage.stopped;
    _notify();
  }

  void dismissProposal() {
    if (_disposed || _stage != PauseStage.proposal) return;
    _invalidateInvitation();
    _stage = PauseStage.home;
    _message = null;
    _notify();
  }

  void goHome() {
    if (_disposed) return;
    _stage = PauseStage.home;
    _message = null;
    _notify();
  }

  void openFromReminder(int id) {
    if (_disposed ||
        !_remindersEnabled ||
        id != _invitationId ||
        _stage == PauseStage.proposal ||
        _stage == PauseStage.guide) {
      return;
    }
    openProposal();
  }

  Future<void> setRemindersEnabled(bool enabled) async {
    if (_disposed) return;
    final revision = ++_permissionRevision;
    if (!enabled || !channel.supported) {
      _remindersEnabled = false;
      _invalidateInvitation();
      _message = enabled
          ? 'Este dispositivo no tiene un canal de avisos disponible.'
          : 'Avisos desactivados en esta sesión.';
      _notify();
      return;
    }

    bool granted;
    try {
      granted = await channel.requestPermission();
    } catch (_) {
      if (_disposed || revision != _permissionRevision) return;
      _remindersEnabled = false;
      _invalidateInvitation();
      _message = 'No se pudo comprobar el permiso. No se programará un aviso.';
      _notify();
      return;
    }
    if (_disposed || revision != _permissionRevision) return;
    _remindersEnabled = granted;
    if (!granted) _invalidateInvitation();
    _message = granted
        ? 'Avisos habilitados en esta sesión.'
        : 'Sin permiso para avisos. Puedes abrir una pausa cuando quieras.';
    _notify();
  }

  Future<void> scheduleReminder(Duration delay) async {
    if (_disposed) return;
    if (!_remindersEnabled || !channel.supported) {
      _message = 'No se programó un aviso: los avisos no están habilitados.';
      _notify();
      return;
    }
    if (_stage == PauseStage.guide || delay <= Duration.zero) {
      _message = _stage == PauseStage.guide
          ? 'Termina o detén la guía antes de preparar otro aviso.'
          : 'Elige un intervalo mayor que cero.';
      _notify();
      return;
    }

    _invalidateInvitation();
    final id = ++_generation;
    _invitationId = id;
    _reminderAt = DateTime.now().add(delay);
    _stage = PauseStage.home;
    _message = 'Aviso preparado mientras esta sesión siga abierta.';
    _timer = Timer(delay, () => unawaited(_deliver(id)));
    _notify();
  }

  Future<void> cancelReminder() async {
    if (_disposed) return;
    _invalidateInvitation();
    _message = 'Aviso cancelado en esta sesión.';
    _notify();
    await _channelWork;
  }

  Future<void> _deliver(int id) async {
    if (!_canDeliver(id)) return;
    _timer = null;
    _reminderAt = null;
    _notify();
    try {
      await _enqueue(() async {
        if (_canDeliver(id)) await channel.show(id);
      });
      if (_disposed || id != _invitationId) return;
      _message = 'Se solicitó mostrar la invitación en este dispositivo.';
      _notify();
    } catch (_) {
      if (_disposed || id != _invitationId) return;
      _invalidateInvitation();
      _message = 'No se pudo mostrar el aviso. Puedes abrir una pausa aquí.';
      _notify();
    }
  }

  bool _canDeliver(int id) =>
      !_disposed &&
      _remindersEnabled &&
      id == _invitationId &&
      _stage != PauseStage.proposal &&
      _stage != PauseStage.guide;

  void _invalidateInvitation() {
    _generation++;
    _invitationId = null;
    _timer?.cancel();
    _timer = null;
    _reminderAt = null;
    unawaited(
      _enqueue(channel.cancel).catchError((Object error) {
        if (_disposed) return;
        _message = 'No se pudo confirmar la retirada del aviso del sistema.';
        _notify();
      }),
    );
  }

  // Channel work is serialized: a cancellation cannot overtake an in-flight
  // show and leave a late notice behind. OS banners already shown may persist.
  Future<void> _enqueue(Future<void> Function() operation) {
    final work = _channelWork.then((_) => operation());
    _channelWork = work.catchError((Object _) {});
    return work;
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _permissionRevision++;
    channel.onOpen = null;
    _invalidateInvitation();
    unawaited(_channelWork.whenComplete(channel.dispose));
    super.dispose();
  }
}
