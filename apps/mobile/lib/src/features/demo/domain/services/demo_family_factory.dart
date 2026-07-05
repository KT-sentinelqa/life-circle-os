import 'package:lifecircle_mobile/src/features/demo/domain/entities/demo_scenario.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_entity.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_member_entity.dart';

/// Generates deterministic family structures for
/// onboarding flows, demos, and investor presentations.
class DemoFamilyFactory {
  /// Creates a [DemoFamilyFactory].
  const DemoFamilyFactory();

  /// Generates a family based on the given scenario.
  (FamilyEntity, List<FamilyMemberEntity>) generateFamily(
    DemoScenario scenario,
  ) {
    switch (scenario) {
      case DemoScenario.healthyFamily:
        return _generateHealthyFamily();
      case DemoScenario.careNeeded:
        return _generateCareNeededFamily();
      case DemoScenario.criticalSituation:
        return _generateCriticalFamily();
      case DemoScenario.livingAloneParent:
        return _generateLivingAloneFamily();
    }
  }

  (FamilyEntity, List<FamilyMemberEntity>) _generateHealthyFamily() {
    const familyId = 'demo-healthy';
    final family = FamilyEntity(
      id: familyId,
      name: 'The Healthy Family',
      createdAt: DateTime.utc(2026),
    );

    return (
      family,
      [
        const FamilyMemberEntity(
          id: 'member-owner',
          userId: 'user-owner',
          familyId: familyId,
          role: MemberRole.owner,
        ),
        const FamilyMemberEntity(
          id: 'member-father',
          userId: 'user-father',
          familyId: familyId,
          role: MemberRole.parent,
        ),
      ]
    );
  }

  (FamilyEntity, List<FamilyMemberEntity>) _generateCareNeededFamily() {
    const familyId = 'demo-care';
    final family = FamilyEntity(
      id: familyId,
      name: 'The Care Needed Family',
      createdAt: DateTime.utc(2026),
    );

    return (
      family,
      [
        const FamilyMemberEntity(
          id: 'member-owner',
          userId: 'user-owner',
          familyId: familyId,
          role: MemberRole.owner,
        ),
        const FamilyMemberEntity(
          id: 'member-grandma',
          userId: 'user-grandma',
          familyId: familyId,
          role: MemberRole.parent,
        ),
      ]
    );
  }

  (FamilyEntity, List<FamilyMemberEntity>) _generateCriticalFamily() {
    const familyId = 'demo-critical';
    final family = FamilyEntity(
      id: familyId,
      name: 'The Critical Family',
      createdAt: DateTime.utc(2026),
    );

    return (
      family,
      [
        const FamilyMemberEntity(
          id: 'member-owner',
          userId: 'user-owner',
          familyId: familyId,
          role: MemberRole.owner,
        ),
        const FamilyMemberEntity(
          id: 'member-grandma',
          userId: 'user-grandma',
          familyId: familyId,
          role: MemberRole.parent,
        ),
      ]
    );
  }

  (FamilyEntity, List<FamilyMemberEntity>) _generateLivingAloneFamily() {
    const familyId = 'demo-alone';
    final family = FamilyEntity(
      id: familyId,
      name: 'The Remote Care Family',
      createdAt: DateTime.utc(2026),
    );

    return (
      family,
      [
        const FamilyMemberEntity(
          id: 'member-owner',
          userId: 'user-owner',
          familyId: familyId,
        ),
        const FamilyMemberEntity(
          id: 'member-parent',
          userId: 'user-parent',
          familyId: familyId,
          role: MemberRole.parent,
        ),
      ]
    );
  }
}
