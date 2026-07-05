import 'package:lifecircle_mobile/src/features/demo/domain/entities/demo_scenario.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_entity.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_member_entity.dart';

/// Generates deterministic family structures for
/// onboarding flows, demos, and investor presentations.
class DemoFamilyFactory {
  /// Creates a [DemoFamilyFactory].
  const DemoFamilyFactory();

  /// Generates a standard Indian family based on the scenario.
  (FamilyEntity, List<FamilyMemberEntity>) generateFamily(
    DemoScenario scenario,
  ) {
    switch (scenario) {
      case DemoScenario.standardIndianFamily:
        return _generateStandardIndianFamily();
      case DemoScenario.elderCareFamily:
      case DemoScenario.chronicCareFamily:
      case DemoScenario.singleParentFamily:
      case DemoScenario.jointFamily:
        return _generateStandardIndianFamily();
    }
  }

  (FamilyEntity, List<FamilyMemberEntity>) _generateStandardIndianFamily() {
    const familyId = 'demo-family-123';
    const familyName = 'The Tiwari Family';

    final family = FamilyEntity(
      id: familyId,
      name: familyName,
      createdAt: DateTime.utc(2026),
    );

    // 1. Owner (Krishna) - 100% adherence
    const owner = FamilyMemberEntity(
      id: 'member-owner-1',
      userId: 'user-krishna-1',
      familyId: familyId,
      role: MemberRole.owner,
    );

    // 2. Father (Shailesh) - 94% adherence
    const father = FamilyMemberEntity(
      id: 'member-father-1',
      userId: 'user-shailesh-1',
      familyId: familyId,
      role: MemberRole.parent,
    );

    // 3. Mother (Sunita) - 82% adherence
    const mother = FamilyMemberEntity(
      id: 'member-mother-1',
      userId: 'user-sunita-1',
      familyId: familyId,
      role: MemberRole.parent,
    );

    // 4. Grandmother - 61% adherence (Critical)
    const grandmother = FamilyMemberEntity(
      id: 'member-grandma-1',
      userId: 'user-grandma-1',
      familyId: familyId,
      role: MemberRole.parent,
    );

    // 5. Caregiver (Nurse/Sibling) - Manages grandmother
    const caregiver = FamilyMemberEntity(
      id: 'member-caregiver-1',
      userId: 'user-caregiver-1',
      familyId: familyId,
    );

    return (family, [owner, father, mother, grandmother, caregiver]);
  }
}
