import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum InteractionKind {
  proposalOpened,
  guideStarted,
  guideFinished,
  guideStopped,
  postponed,
  dismissed,
}

/// Daily local counts. The date records when the interaction happened, not a
/// claim about movement or health.
class InteractionHistory extends ChangeNotifier {
  InteractionHistory._(this._storage, this._days, this._remoteIds, this._now);

  factory InteractionHistory.memory({DateTime Function()? now}) =>
      InteractionHistory._(
        null,
        <String, List<int>>{},
        <String>{},
        now ?? DateTime.now,
      );

  static const _key = 'panorama.interactions.v1';

  static Future<InteractionHistory> load({DateTime Function()? now}) async {
    final storage = SharedPreferencesAsync();
    final days = <String, List<int>>{};
    final remoteIds = <String>{};
    try {
      final raw = await storage.getString(_key);
      if (raw != null) {
        final decoded = jsonDecode(raw);
        if (decoded is Map<String, dynamic>) {
          final ids = decoded['__remoteIds'];
          if (ids is List) remoteIds.addAll(ids.whereType<String>());
          for (final entry in decoded.entries) {
            final values = entry.value;
            if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(entry.key) &&
                values is List &&
                values.length == InteractionKind.values.length &&
                values.every((value) => value is int && value >= 0)) {
              days[entry.key] = List<int>.from(values);
            }
          }
        }
      }
    } catch (_) {
      // A corrupt value cannot be interpreted as a real interaction.
    }
    return InteractionHistory._(storage, days, remoteIds, now ?? DateTime.now);
  }

  final SharedPreferencesAsync? _storage;
  final Map<String, List<int>> _days;
  final Set<String> _remoteIds;
  final DateTime Function() _now;
  Future<void> _writes = Future<void>.value();
  bool _saveFailed = false;

  bool get saveFailed => _saveFailed;

  static String dateKey(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';

  static DateTime weekStart(DateTime date) =>
      DateTime(date.year, date.month, date.day - date.weekday + 1);

  List<int> totalsForWeek(DateTime monday) {
    final totals = List<int>.filled(InteractionKind.values.length, 0);
    for (var day = 0; day < 7; day++) {
      final date = DateTime(monday.year, monday.month, monday.day + day);
      final counts = _days[dateKey(date)];
      if (counts == null) continue;
      for (var index = 0; index < totals.length; index++) {
        totals[index] += counts[index];
      }
    }
    return totals;
  }

  void record(InteractionKind kind) {
    final key = dateKey(_now());
    final counts = _days.putIfAbsent(
      key,
      () => List<int>.filled(InteractionKind.values.length, 0),
    );
    counts[kind.index]++;
    notifyListeners();
    unawaited(_persist());
  }

  Future<bool> recordRemote(
    String id,
    InteractionKind kind,
    DateTime occurredAt,
  ) async {
    if (id.isEmpty) return false;
    if (_remoteIds.contains(id)) {
      await _persist();
      return !_saveFailed;
    }
    _remoteIds.add(id);
    final key = dateKey(occurredAt.toLocal());
    final counts = _days.putIfAbsent(
      key,
      () => List<int>.filled(InteractionKind.values.length, 0),
    );
    counts[kind.index]++;
    notifyListeners();
    await _persist();
    return !_saveFailed;
  }

  Future<void> clear() async {
    _days.clear();
    notifyListeners();
    await _persist();
  }

  Future<void> flush() => _writes;

  Future<void> _persist() {
    if (_storage == null) return Future<void>.value();
    final snapshot = _days.map(
      (key, value) => MapEntry(key, List<int>.from(value)),
    );
    final ids = _remoteIds.toList();
    _writes = _writes.then((_) async {
      try {
        if (snapshot.isEmpty && ids.isEmpty) {
          await _storage.remove(_key);
        } else {
          await _storage.setString(
            _key,
            jsonEncode({...snapshot, '__remoteIds': ids}),
          );
        }
        _saveFailed = false;
      } catch (_) {
        _saveFailed = true;
      }
      notifyListeners();
    });
    return _writes;
  }
}
