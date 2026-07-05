import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_status.dart';
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
        if (member.userId.contains('grandma')) {
          targetAdherence = 0.45;
        } else if (member.userId.contains('sunita')) {
          targetAdherence = 0.82;
        } else if (member.userId.contains('shailesh')) {
          targetAdherence = 0.94;
        } else if (member.userId.contains('krishna')) {
          targetAdherence = 1.0;
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

        // Hardcoded critical escalation cluster for the grandma profile
        if (member.userId.contains('grandma')) {
          if (i > 70 && i < 75) {
            dosesTaken = 0;
            dosesMissed = dosesScheduled;
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
