import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_status.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/medicine_streak.dart';

/// Pure service responsible for computing and managing streaks.
class StreakEngine {
  /// Creates a [StreakEngine].
  const StreakEngine({required this.nowProvider});

  /// Injected provider for deterministic time calculations.
  final DateTime Function() nowProvider;

  /// Calculates the new streak based on an incoming daily record and
  /// the previous streak.
  MedicineStreak calculateNextStreak({
    required AdherenceRecord newRecord,
    required MedicineStreak? previousStreak,
  }) {
    // Default fallback if no previous streak exists
    var currentStreak = previousStreak?.currentStreak ?? 0;
    var longestStreak = previousStreak?.longestStreak ?? 0;
    var lastPerfectDate = previousStreak?.lastPerfectDateUtc;

    final id = previousStreak?.id ??
        '${newRecord.memberId}-${newRecord.medicineId ?? 'global'}-streak';

    if (newRecord.status == AdherenceStatus.perfect) {
      // If it's the exact same day, we don't double-count the streak
      if (lastPerfectDate == null ||
          !_isSameDay(lastPerfectDate, newRecord.dateUtc)) {
        currentStreak++;
        lastPerfectDate = newRecord.dateUtc;
      }
    } else if (newRecord.status != AdherenceStatus.unknown) {
      // A non-perfect day (e.g. good, atRisk, critical) breaks the streak
      currentStreak = 0;
    }

    if (currentStreak > longestStreak) {
      longestStreak = currentStreak;
    }

    return MedicineStreak(
      id: id,
      familyId: newRecord.familyId,
      memberId: newRecord.memberId,
      medicineId: newRecord.medicineId,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      lastPerfectDateUtc: lastPerfectDate,
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
