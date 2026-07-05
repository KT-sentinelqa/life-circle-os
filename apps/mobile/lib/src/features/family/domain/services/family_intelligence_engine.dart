import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_status.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_health_score.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_member_entity.dart';

/// Engine responsible for calculating family-wide intelligence metrics.
class FamilyIntelligenceEngine {
  /// Creates a [FamilyIntelligenceEngine].
  const FamilyIntelligenceEngine();

  /// Calculates the [FamilyHealthScore] based on all family members
  /// and records.
  FamilyHealthScore calculateFamilyHealthScore({
    required List<FamilyMemberEntity> members,
    required List<AdherenceRecord> allFamilyRecords,
  }) {
    var totalScheduled = 0;
    var totalTaken = 0;
    var totalMissed = 0;
    var activeCaregiverCount = 0;

    final memberStatusMap = <String, AdherenceStatus>{};

    for (final member in members) {
      if (member.role == MemberRole.caregiver ||
          member.role == MemberRole.owner ||
          member.role == MemberRole.parent) {
        // Parents and owners generally also fulfill caregiver capacities
        activeCaregiverCount++;
      }
    }

    for (final record in allFamilyRecords) {
      totalScheduled += record.dosesScheduled;
      totalTaken += record.dosesTaken;
      totalMissed += record.dosesMissed;

      // If a member has a critical or atRisk day in this dataset,
      // they are flagged.
      if (record.status == AdherenceStatus.critical ||
          record.status == AdherenceStatus.atRisk) {
        memberStatusMap[record.memberId] = record.status;
      }
    }

    final percentage = totalScheduled > 0 ? (totalTaken / totalScheduled) : 0.0;

    return FamilyHealthScore(
      totalDosesScheduled: totalScheduled,
      totalDosesTaken: totalTaken,
      totalDosesMissed: totalMissed,
      adherencePercentage: percentage,
      activeCaregiverCount: activeCaregiverCount,
      membersAtRisk: memberStatusMap.length,
    );
  }
}
