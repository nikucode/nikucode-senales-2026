import 'dart:async';

import 'package:flutter/foundation.dart';

import 'interaction_history.dart';
import 'lan_pause.dart';
import 'reminder_channel.dart';

enum PauseStage { home, proposal, guide, finished, stopped }

@immutable
class MovementProposal {
  const MovementProposal({
    required this.title,
    required this.instruction,
    required this.guideSteps,
    required this.contextLabel,
  });

  final String title;
  final String instruction;
  final List<String> guideSteps;
  final String contextLabel;
}

@immutable
class PauseActivity {
  const PauseActivity({
    required this.proposalsOpened,
    required this.guidesStarted,
    required this.guidesFinished,
    required this.guidesStopped,
    required this.proposalsDismissed,
    required this.postponements,
  });

  final int proposalsOpened;
  final int guidesStarted;
  final int guidesFinished;
  final int guidesStopped;
  final int proposalsDismissed;
  final int postponements;
}

/// State for the brief invitation flow; it never infers bodily movement.
class PauseViewModel extends ChangeNotifier {
  PauseViewModel({required this.channel, InteractionHistory? history, this.lan})
    : history = history ?? InteractionHistory.memory() {
    channel.onOpen = openFromReminder;
    channel.onValidatedOpen = openFromValidatedReminder;
    channel.onOpenError = _reportOpenError;
    lan?.addListener(_syncSharedFromLan);
    final pendingId = lan?.sharedReminderId;
    final pendingAt = lan?.sharedReminderAt;
    if (pendingId != null &&
        pendingAt != null &&
        pendingAt.isAfter(DateTime.now())) {
      _remindersEnabled = true;
      _invitationId = pendingId;
      _reminderAt = pendingAt;
      _timer = Timer(
        pendingAt.difference(DateTime.now()),
        () => _clearSharedPending(pendingId),
      );
    }
  }

  static const _proposals = [
    MovementProposal(
      title: 'Caminar un momento',
      instruction:
          'Si puedes caminar y te resulta adecuado ahora, deja la tarea y '
          'empieza a caminar a tu propio ritmo. Puedes apartar la mirada.',
      guideSteps: [
        'Si caminar te parece adecuado ahora, aparta un momento la atención de la tarea.',
        'Empieza a caminar a tu propio ritmo.',
        'Puedes dejar la pantalla y volver cuando quieras; detente o sal en cualquier momento.',
      ],
      contextLabel: 'Si tienes espacio y puedes caminar',
    ),
    MovementProposal(
      title: 'Tu movimiento habitual',
      instruction:
          'Elige un movimiento que ya conozcas y consideres adecuado ahora. '
          'Puedes apartar la mirada.',
      guideSteps: [
        'Si este momento te sirve, elige un movimiento que ya conozcas y consideres adecuado.',
        'Empieza a tu manera.',
        'Puedes dejar la pantalla y volver cuando quieras; detente o sal en cualquier momento.',
      ],
      contextLabel: 'Elegido por ti, según el momento',
    ),
  ];

  final ReminderChannel channel;
  final InteractionHistory history;
  final LanPause? lan;
  PauseStage _stage = PauseStage.home;
  int _proposalIndex = 0;
  int _guideStepIndex = 0;
  bool _remindersEnabled = false;
  DateTime? _reminderAt;
  String? _message;
  Timer? _timer;
  int _generation = 0;
  int? _invitationId;
  bool _initialInvitationAllowed = true;
  final Set<int> _consumedInitialInvitationIds = <int>{};
  int _permissionRevision = 0;
  int _proposalsOpened = 0;
  int _guidesStarted = 0;
  int _guidesFinished = 0;
  int _guidesStopped = 0;
  int _proposalsDismissed = 0;
  int _postponements = 0;
  bool _disposed = false;
  Future<void> _channelWork = Future<void>.value();
  Future<void> _lanWork = Future<void>.value();

  PauseStage get stage => _stage;
  int get proposalIndex => _proposalIndex;
  MovementProposal get proposal => _proposals[_proposalIndex];
  int get guideStepIndex => _guideStepIndex;
  int get guideStepCount => proposal.guideSteps.length;
  String get currentGuideStep => proposal.guideSteps[_guideStepIndex];
  bool get remindersEnabled => _remindersEnabled;
  DateTime? get reminderAt => _reminderAt;
  String? get message => _message;
  bool get hasPendingReminder => _timer != null;
  String get channelScope => sharedReminders
      ? 'Android y Omarchy recibirán la misma invitación. La conexión local '
            'debe seguir activa; el aviso puede retrasarse si un equipo se desconecta.'
      : receivesSharedReminders
      ? 'Este equipo recibe los avisos programados desde Android. Abre la app '
            'móvil para elegir o cancelar una señal.'
      : channel.scopeLabel;
  bool get channelSupported => channel.supported;
  bool get sharedReminders => lan?.canSchedule == true;
  bool get receivesSharedReminders =>
      lan?.paired == true && lan?.isPhone == false;

  void _syncSharedFromLan() {
    if (_disposed || !sharedReminders) return;
    final pendingId = lan?.sharedReminderId;
    final pendingAt = lan?.sharedReminderAt;
    if (pendingId == null ||
        pendingAt == null ||
        pendingId == _invitationId ||
        !pendingAt.isAfter(DateTime.now())) {
      return;
    }
    _timer?.cancel();
    _invitationId = pendingId;
    _reminderAt = pendingAt;
    _remindersEnabled = true;
    _timer = Timer(
      pendingAt.difference(DateTime.now()),
      () => _clearSharedPending(pendingId),
    );
    _message = 'La señal se pospuso en Omarchy y se actualizó en Android.';
    _notify();
  }

  void _clearSharedPending(int id) {
    if (id != _invitationId || _disposed) return;
    _timer = null;
    _reminderAt = null;
    _notify();
  }

  PauseActivity get activity => PauseActivity(
    proposalsOpened: _proposalsOpened,
    guidesStarted: _guidesStarted,
    guidesFinished: _guidesFinished,
    guidesStopped: _guidesStopped,
    proposalsDismissed: _proposalsDismissed,
    postponements: _postponements,
  );

  void openProposal() {
    if (_disposed || _stage == PauseStage.guide) return;
    _invalidateInvitation();
    _proposalsOpened++;
    history.record(InteractionKind.proposalOpened);
    _stage = PauseStage.proposal;
    _message = null;
    _notify();
  }

  void changeProposal() {
    if (_disposed || _stage != PauseStage.proposal) return;
    _proposalIndex = (_proposalIndex + 1) % _proposals.length;
    _guideStepIndex = 0;
    _notify();
  }

  void startGuide() {
    if (_disposed || _stage != PauseStage.proposal) return;
    _invalidateInvitation();
    _guideStepIndex = 0;
    _guidesStarted++;
    history.record(InteractionKind.guideStarted);
    _stage = PauseStage.guide;
    _message = null;
    _notify();
  }

  void nextGuideStep() {
    if (_disposed ||
        _stage != PauseStage.guide ||
        _guideStepIndex >= guideStepCount - 1) {
      return;
    }
    _guideStepIndex++;
    _notify();
  }

  void previousGuideStep() {
    if (_disposed || _stage != PauseStage.guide || _guideStepIndex == 0) return;
    _guideStepIndex--;
    _notify();
  }

  void finishGuide() {
    if (_disposed || _stage != PauseStage.guide) return;
    _guidesFinished++;
    history.record(InteractionKind.guideFinished);
    _stage = PauseStage.finished;
    _notify();
  }

  void stopGuide() {
    if (_disposed || _stage != PauseStage.guide) return;
    _guidesStopped++;
    history.record(InteractionKind.guideStopped);
    _stage = PauseStage.stopped;
    _notify();
  }

  void dismissProposal() {
    if (_disposed || _stage != PauseStage.proposal) return;
    _invalidateInvitation();
    _proposalsDismissed++;
    history.record(InteractionKind.dismissed);
    _stage = PauseStage.home;
    _message =
        'Está bien. Puedes volver a tu tarea. '
        'No tienes que explicar por qué.';
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

  /// Accepts Android intents only after the native transport has validated
  /// and consumed the invitation ID. Startup does not enable future reminders.
  void openFromValidatedReminder(int id) {
    if (id <= 0 || _disposed) return;
    if (_remindersEnabled && id == _invitationId) {
      openFromReminder(id);
      return;
    }
    if (!_initialInvitationAllowed || !_consumedInitialInvitationIds.add(id)) {
      return;
    }
    if (_stage == PauseStage.proposal || _stage == PauseStage.guide) return;

    _invalidateInvitation();
    _proposalsOpened++;
    history.record(InteractionKind.proposalOpened);
    _stage = PauseStage.proposal;
    _message = null;
    _notify();
  }

  void _reportOpenError() {
    if (_disposed) return;
    _message = 'No se pudo comprobar la invitación. Puedes abrir una pausa manualmente.';
    _notify();
  }

  Future<void> setRemindersEnabled(bool enabled) async {
    if (_disposed) return;
    final revision = ++_permissionRevision;
    if (!enabled || !channel.supported) {
      final cancelShared = hasPendingReminder && sharedReminders;
      _remindersEnabled = false;
      _invalidateInvitation();
      _message = enabled
          ? 'Este dispositivo no tiene un canal de avisos disponible.'
          : 'Avisos desactivados en esta sesión.';
      if (cancelShared) {
        try {
          await _enqueueLan(lan!.cancelPending);
        } catch (_) {
          _message = 'No se pudo retirar la señal de Omarchy.';
        }
      }
      _notify();
      return;
    }

    bool granted;
    try {
      granted = await channel.requestPermission();
    } catch (_) {
      if (_disposed || revision != _permissionRevision) return;
      final cancelShared = hasPendingReminder && sharedReminders;
      _remindersEnabled = false;
      _invalidateInvitation();
      _message = 'No se pudo comprobar el permiso. No se programará un aviso.';
      if (cancelShared) {
        try {
          await _enqueueLan(lan!.cancelPending);
        } catch (_) {
          _message = 'No se pudo retirar la señal de Omarchy.';
        }
      }
      _notify();
      return;
    }
    if (_disposed || revision != _permissionRevision) return;
    _remindersEnabled = granted;
    if (!granted) {
      final cancelShared = hasPendingReminder && sharedReminders;
      _invalidateInvitation();
      if (cancelShared) {
        try {
          await _enqueueLan(lan!.cancelPending);
        } catch (_) {
          _message = 'No se pudo retirar la señal de Omarchy.';
          _notify();
          return;
        }
      }
    }
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

    final postponingProposal = _stage == PauseStage.proposal;
    final cancellation = _invalidateInvitation();
    final revision = _generation;
    final cancelled = await cancellation;
    if (_disposed || revision != _generation) return;
    if (!cancelled) {
      _message =
          'No se preparó otro aviso: no se pudo confirmar la retirada del anterior. '
          'Puedes abrir una pausa manualmente.';
      _notify();
      return;
    }
    final shared = sharedReminders;
    if (shared) {
      try {
        await _enqueueLan(lan!.cancelPending);
      } catch (_) {
        _message = 'No se pudo retirar la programación anterior de Omarchy.';
        _notify();
        return;
      }
      if (_disposed || revision != _generation) return;
    }
    final now = DateTime.now().microsecondsSinceEpoch;
    final id = now > _generation ? now : _generation + 1;
    _generation = id;
    _invitationId = id;
    final dueAt = DateTime.now().add(delay);
    _reminderAt = dueAt;
    if (shared) {
      try {
        await _enqueueLan(() => lan!.scheduleSharedReminder(dueAt, id));
      } catch (_) {
        _invitationId = null;
        _reminderAt = null;
        _message =
            'No se pudo programar la señal compartida. Inténtalo de nuevo.';
        _notify();
        return;
      }
      if (_disposed || id != _generation) return;
      _message = 'Se programó la misma señal para Android y Omarchy.';
    } else {
      _message =
          'Temporizador local preparado. La app debe seguir abierta; todavía '
          'no se ha solicitado mostrar el aviso.';
    }
    _stage = PauseStage.home;
    if (postponingProposal) {
      _postponements++;
      history.record(InteractionKind.postponed);
    }
    final remaining = dueAt.difference(DateTime.now());
    _timer = Timer(remaining.isNegative ? Duration.zero : remaining, () {
      if (shared) {
        _clearSharedPending(id);
      } else {
        unawaited(_deliver(id));
      }
    });
    _notify();
  }

  Future<void> cancelReminder() async {
    if (_disposed) return;
    final cancelShared = hasPendingReminder && sharedReminders;
    final cancellation = _invalidateInvitation();
    final revision = _generation;
    _message = 'Se está solicitando retirar el aviso del sistema.';
    _notify();
    final cancelled = await cancellation;
    if (_disposed || revision != _generation) return;
    if (cancelShared) {
      try {
        await _enqueueLan(lan!.cancelPending);
      } catch (_) {
        _message = 'Se retiró el aviso de Android, pero Omarchy no confirmó la cancelación.';
        _notify();
        return;
      }
    }
    if (!cancelled) {
      _message = cancelShared
          ? 'La señal compartida se retiró, pero Android no confirmó el cierre del aviso.'
          : 'No se pudo confirmar la retirada del aviso del sistema.';
      _notify();
      return;
    }
    _message = 'Temporizador cancelado y retirada solicitada al sistema.';
    _notify();
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

  Future<bool> _invalidateInvitation() {
    final revision = ++_generation;
    _initialInvitationAllowed = false;
    _invitationId = null;
    _timer?.cancel();
    _timer = null;
    _reminderAt = null;
    return _enqueue(channel.cancel).then(
      (_) => true,
      onError: (Object error) {
        if (!_disposed && revision == _generation) {
          _message = 'No se pudo confirmar la retirada del aviso del sistema.';
          _notify();
        }
        return false;
      },
    );
  }

  // Channel work is serialized: a cancellation cannot overtake an in-flight
  // show and leave a late notice behind. OS banners already shown may persist.
  Future<void> _enqueue(Future<void> Function() operation) {
    final work = _channelWork.then((_) => operation());
    _channelWork = work.catchError((Object _) {});
    return work;
  }

  Future<void> _enqueueLan(Future<void> Function() operation) {
    final work = _lanWork.then((_) => operation());
    _lanWork = work.catchError((Object _) {});
    return work;
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    lan?.removeListener(_syncSharedFromLan);
    _permissionRevision++;
    channel.onOpen = null;
    channel.onValidatedOpen = null;
    channel.onOpenError = null;
    if (sharedReminders) {
      _timer?.cancel();
      _timer = null;
      _invitationId = null;
    } else {
      _invalidateInvitation();
    }
    unawaited(_channelWork.whenComplete(channel.dispose));
    super.dispose();
  }
}
