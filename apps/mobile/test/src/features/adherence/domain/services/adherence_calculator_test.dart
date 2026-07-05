import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_status.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/services/adherence_calculator.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_log_entity.dart';

void main() {
  group('AdherenceCalculator', () {
    const calculator = AdherenceCalculator();

    test('calculateDailyRecord processes logs correctly', () {
      final logs = [
        MedicineLogEntity(
          id: 'l1',
          medicineId: 'm1',
          familyId: 'f1',
          memberId: 'u1',
          scheduledAtUtc: DateTime(2026, 7, 1, 8),
          status: MedicineLogStatus.taken,
          createdAtUtc: DateTime(2026, 7),
          updatedAtUtc: DateTime(2026, 7),
        ),
        MedicineLogEntity(
          id: 'l2',
          medicineId: 'm1',
          familyId: 'f1',
          memberId: 'u1',
          scheduledAtUtc: DateTime(2026, 7, 1, 20),
          status: MedicineLogStatus.missed,
          createdAtUtc: DateTime(2026, 7),
          updatedAtUtc: DateTime(2026, 7),
        ),
      ];

      final record = calculator.calculateDailyRecord(
        id: 'r1',
        familyId: 'f1',
        memberId: 'u1',
        dateUtc: DateTime.utc(2026, 7),
        dailyLogs: logs,
      );

      expect(record.dosesScheduled, 2);
      expect(record.dosesTaken, 1);
      expect(record.dosesMissed, 1);
      expect(record.percentage, 0.5);
      expect(record.status, AdherenceStatus.atRisk);
    });

    test('calculateMetrics aggregates records correctly', () {
      final records = [
        AdherenceRecord(
          id: 'r1',
          familyId: 'f1',
          memberId: 'u1',
          dateUtc: DateTime.utc(2026, 7),
          dosesScheduled: 2,
          dosesTaken: 2,
          status: AdherenceStatus.perfect,
        ),
        AdherenceRecord(
          id: 'r2',
          familyId: 'f1',
          memberId: 'u1',
          dateUtc: DateTime.utc(2026, 7, 2),
          dosesScheduled: 2,
          dosesTaken: 0,
          dosesSkipped: 1,
          dosesMissed: 1,
          status: AdherenceStatus.critical,
        ),
      ];

      final metrics = calculator.calculateMetrics(records, currentStreak: 5);

      expect(metrics.totalDosesScheduled, 4);
      expect(metrics.totalDosesTaken, 2);
      expect(metrics.totalDosesSkipped, 1);
      expect(metrics.totalDosesMissed, 1);
      expect(metrics.adherencePercentage, 0.5);
      expect(metrics.streak, 5);
    });
  });
}
