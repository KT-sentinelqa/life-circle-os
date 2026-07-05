import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_log_entity.dart';

/// Analyzes missed doses to detect patterns.
class MissedDoseAnalyzer {
  /// Creates a [MissedDoseAnalyzer].
  const MissedDoseAnalyzer();

  /// Identifies the most common hour a dose is missed.
  int? getMostFrequentlyMissedHour(List<MedicineLogEntity> logs) {
    final missedLogs = logs.where((l) => l.status == MedicineLogStatus.missed);
    if (missedLogs.isEmpty) return null;

    final hourCounts = <int, int>{};
    for (final log in missedLogs) {
      final hour = log.scheduledAtUtc.hour;
      hourCounts[hour] = (hourCounts[hour] ?? 0) + 1;
    }

    int? maxHour;
    var maxCount = 0;
    for (final entry in hourCounts.entries) {
      if (entry.value > maxCount) {
        maxCount = entry.value;
        maxHour = entry.key;
      }
    }
    return maxHour;
  }
}
