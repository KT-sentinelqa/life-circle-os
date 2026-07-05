import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_status.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/entities/demo_scenario.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_member_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';

/// Pure factory for generating deterministic adherence logs.
class DemoAdherenceFactory {
  /// Creates a [DemoAdherenceFactory].
  const DemoAdherenceFactory();

  /// Generates a historical set of daily [AdherenceRecord]s.
  List<AdherenceRecord> generateHistory({
    required List<FamilyMemberEntity> members,
    required List<MedicineEntity> medicines,
    required DateTime referenceTime,
    required DemoScenario scenario,
    int days = 90,
  }) {
    final records = <AdherenceRecord>[];

    final medsByMember = <String, List<MedicineEntity>>{};
    for (final med in medicines) {
      medsByMember.putIfAbsent(med.memberId, () => []).add(med);
    }

    for (var i = 0; i < days; i++) {
      final date = referenceTime.subtract(Duration(days: days - i - 1));
      final dateOnly = DateTime.utc(date.year, date.month, date.day);

      for (final member in members) {
        final memberMeds = medsByMember[member.userId] ?? [];
        if (memberMeds.isEmpty) continue;

        var targetAdherence = 0.9;
        switch (scenario) {
          case DemoScenario.healthyFamily:
            targetAdherence = 0.98; // 98%
          case DemoScenario.careNeeded:
            targetAdherence = 0.65; // ~65% yellow
          case DemoScenario.criticalSituation:
            targetAdherence = 0.40; // ~40% red
          case DemoScenario.livingAloneParent:
            targetAdherence = 0.55; // struggling alone
        }

        final dosesScheduled = memberMeds.length;
        var dosesTaken = 0;
        var dosesMissed = 0;

        for (var m = 0; m < memberMeds.length; m++) {
          final pseudoRand =
              ((i * 17 + m * 31 + member.userId.length * 13) % 100) / 100.0;

          if (pseudoRand <= targetAdherence) {
            dosesTaken++;
          } else {
            dosesMissed++;
          }
        }

        // Hardcoded critical escalation cluster for critical scenario
        if (scenario == DemoScenario.criticalSituation) {
          if (i > 80 && i <= 88) {
            // The last few days have 0 adherence
            dosesTaken = 0;
            dosesMissed = dosesScheduled;
          }
        }

        // Ensure healthy family is perfectly green on the last 5 days
        if (scenario == DemoScenario.healthyFamily) {
          if (i > 85) {
            dosesTaken = dosesScheduled;
            dosesMissed = 0;
          }
        }

        final percentage =
            dosesScheduled > 0 ? dosesTaken / dosesScheduled : 0.0;
        AdherenceStatus status;
        if (percentage == 1.0) {
          status = AdherenceStatus.perfect;
        } else if (percentage >= 0.8) {
          status = AdherenceStatus.good;
        } else if (percentage >= 0.5) {
          status = AdherenceStatus.atRisk;
        } else {
          status = AdherenceStatus.critical;
        }

        records.add(
          AdherenceRecord(
            id: 'demo-rec-${member.userId}-${dateOnly.toIso8601String()}',
            familyId: member.familyId,
            memberId: member.userId,
            dateUtc: dateOnly,
            dosesScheduled: dosesScheduled,
            dosesTaken: dosesTaken,
            dosesMissed: dosesMissed,
            status: status,
          ),
        );
      }
    }

    return records;
  }
}
