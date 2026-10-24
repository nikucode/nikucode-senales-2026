import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AppUsageEntry {
  const AppUsageEntry({
    required this.packageName,
    required this.label,
    required this.milliseconds,
    this.icon,
  });

  final String packageName;
  final String label;
  final int milliseconds;
  final Uint8List? icon;
}

class DailyAppUsage {
  const DailyAppUsage({required this.date, required this.apps});

  final DateTime date;
  final List<AppUsageEntry> apps;
  int get milliseconds => apps.fold(0, (sum, app) => sum + app.milliseconds);
}

class AppUsageGateway {
  const AppUsageGateway();

  static const _channel = MethodChannel('cl.nikucode/usage');

  bool get supported =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  Future<bool> hasAccess() async {
    if (!supported) return false;
    return await _channel.invokeMethod<bool>('hasAccess') ?? false;
  }

  Future<void> openAccessSettings() async {
    if (!supported) return;
    await _channel.invokeMethod<void>('openAccessSettings');
  }

  Future<List<DailyAppUsage>> loadWeek(DateTime monday) async {
    if (!supported) return const [];
    final start = DateTime(monday.year, monday.month, monday.day);
    final raw = await _channel.invokeMethod<List<dynamic>>(
      'loadWeek',
      start.millisecondsSinceEpoch,
    );
    if (raw == null) throw const FormatException('No usage data returned');
    return raw.map((item) {
      final day = Map<Object?, Object?>.from(item as Map);
      final date = DateTime.parse(day['date'] as String);
      final apps = (day['apps'] as List).map((value) {
        final entry = Map<Object?, Object?>.from(value as Map);
        return AppUsageEntry(
          packageName: entry['package'] as String,
          label: entry['label'] as String,
          milliseconds: entry['milliseconds'] as int,
          icon: entry['icon'] as Uint8List?,
        );
      }).toList();
      return DailyAppUsage(date: date, apps: apps);
    }).toList();
  }
}
