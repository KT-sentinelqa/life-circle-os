import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_status.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_member_entity.dart';
import 'package:lifecircle_mobile/src/features/family/domain/services/family_intelligence_engine.dart';

void main() {
  group('FamilyIntelligenceEngine', () {
    late FamilyIntelligenceEngine engine;

    setUp(() {
      engine = const FamilyIntelligenceEngine();
    });

    test('calculates correct aggregate score and risk counts', () {
      final members = [
        const FamilyMemberEntity(
          id: '1',
          userId: 'owner',
          familyId: 'fam-1',
          role: MemberRole.owner,
        ),
        const FamilyMemberEntity(
          id: '2',
          userId: 'elder',
          familyId: 'fam-1',
          role: MemberRole.child,
        ),
      ];

      final records = [
        AdherenceRecord(
          id: 'rec1',
          familyId: 'fam-1',
          memberId: 'owner',
          dateUtc: DateTime.now(),
          dosesScheduled: 2,
          dosesTaken: 2,
          status: AdherenceStatus.perfect,
        ),
        AdherenceRecord(
          id: 'rec2',
          familyId: 'fam-1',
          memberId: 'elder',
          dateUtc: DateTime.now(),
          dosesScheduled: 8,
          dosesTaken: 4,
          dosesMissed: 4,
          status: AdherenceStatus.critical, // 50%
        ),
      ];

      final score = engine.calculateFamilyHealthScore(
        members: members,
        allFamilyRecords: records,
      );

      // Total scheduled: 10
      // Total taken: 6
      // Weighted Percentage: 60% (Option B logic!)
      expect(score.totalDosesScheduled, equals(10));
      expect(score.totalDosesTaken, equals(6));
      expect(score.adherencePercentage, equals(0.6));

      // Only the elder is at risk
      expect(score.membersAtRisk, equals(1));

      // Owner is counted as active caregiver
      expect(score.activeCaregiverCount, equals(1));
    });
  });
}
