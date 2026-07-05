import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_metrics.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_status.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_log_entity.dart';

/// Pure calculator for adherence metrics over a collection of records.
class AdherenceCalculator {
  /// Creates an [AdherenceCalculator].
  const AdherenceCalculator();

  /// Calculates a daily [AdherenceRecord] from a list of [MedicineLogEntity]s.
  AdherenceRecord calculateDailyRecord({
    required String id,
    required String familyId,
    required String memberId,
    required DateTime dateUtc,
    required List<MedicineLogEntity> dailyLogs,
    String? medicineId,
  }) {
    var scheduled = 0;
    var taken = 0;
    var skipped = 0;
    var missed = 0;

    for (final log in dailyLogs) {
      scheduled++;
      switch (log.status) {
        case MedicineLogStatus.taken:
          taken++;
        case MedicineLogStatus.skipped:
          skipped++;
        case MedicineLogStatus.missed:
          missed++;
        case MedicineLogStatus.scheduled:
        case MedicineLogStatus.postponed:
        // Wait, if it's still scheduled but in the past, it might be missed.
        // For now we count it as scheduled but not taken/missed/skipped yet.
      }
    }

    final percentage = scheduled > 0 ? (taken / scheduled) : 0.0;
    AdherenceStatus status;

    if (scheduled == 0) {
      status = AdherenceStatus.unknown;
    } else if (percentage == 1.0) {
      status = AdherenceStatus.perfect;
    } else if (percentage >= 0.8) {
      status = AdherenceStatus.good;
    } else if (percentage >= 0.5) {
      status = AdherenceStatus.atRisk;
    } else {
      status = AdherenceStatus.critical;
    }

    return AdherenceRecord(
      id: id,
      familyId: familyId,
      memberId: memberId,
      medicineId: medicineId,
      dateUtc: dateUtc,
      dosesScheduled: scheduled,
      dosesTaken: taken,
      dosesSkipped: skipped,
      dosesMissed: missed,
      status: status,
    );
  }

  /// Calculates aggregated [AdherenceMetrics] from a list of daily
  /// [AdherenceRecord]s.
  AdherenceMetrics calculateMetrics(
    List<AdherenceRecord> records, {
    required int currentStreak,
  }) {
    var totalScheduled = 0;
    var totalTaken = 0;
    var totalMissed = 0;
    var totalSkipped = 0;

    for (final record in records) {
      totalScheduled += record.dosesScheduled;
      totalTaken += record.dosesTaken;
      totalMissed += record.dosesMissed;
      totalSkipped += record.dosesSkipped;
    }

    final percentage = totalScheduled > 0 ? (totalTaken / totalScheduled) : 0.0;

    return AdherenceMetrics(
      totalDosesScheduled: totalScheduled,
      totalDosesTaken: totalTaken,
      totalDosesMissed: totalMissed,
      totalDosesSkipped: totalSkipped,
      adherencePercentage: percentage,
      streak: currentStreak,
    );
  }
}
