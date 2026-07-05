import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_member_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/visibility_policy.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/services/medicine_access_service.dart';

void main() {
  group('MedicineAccessService', () {
    late MedicineAccessService service;
    late FamilyMemberEntity owner;
    late FamilyMemberEntity caregiver;
    late FamilyMemberEntity child;
    late FamilyMemberEntity outsider;

    setUp(() {
      service = MedicineAccessService();

      owner = const FamilyMemberEntity(
        id: '1',
        userId: 'owner-id',
        familyId: 'family-123',
        role: MemberRole.owner,
      );

      caregiver = const FamilyMemberEntity(
        id: '2',
        userId: 'caregiver-id',
        familyId: 'family-123',
      );

      child = const FamilyMemberEntity(
        id: '3',
        userId: 'child-id',
        familyId: 'family-123',
        role: MemberRole.child,
      );

      outsider = const FamilyMemberEntity(
        id: '4',
        userId: 'outsider-id',
        familyId: 'other-family',
        role: MemberRole.owner,
      );
    });

    MedicineEntity createMedicine({
      required String memberId,
      required VisibilityPolicy visibilityPolicy,
      List<String> caregiverIds = const [],
    }) {
      return MedicineEntity(
        id: 'med-1',
        familyId: 'family-123',
        memberId: memberId,
        name: 'Test Med',
        dosage: '10mg',
        form: 'Pill',
        instructions: 'Take daily',
        createdAtUtc: DateTime.now(),
        updatedAtUtc: DateTime.now(),
        ownerUserId: owner.userId,
        visibilityPolicy: visibilityPolicy,
        caregiverIds: caregiverIds,
      );
    }

    test('Outsiders cannot view or edit medicines', () {
      final med = createMedicine(
        memberId: child.userId,
        visibilityPolicy: VisibilityPolicy.family,
      );

      expect(service.canViewMedicine(outsider, med), isFalse);
      expect(service.canEditMedicine(outsider, med), isFalse);
    });

    test('Owner can always view and edit medicines', () {
      final privateMed = createMedicine(
        memberId: child.userId,
        visibilityPolicy: VisibilityPolicy.private,
      );

      expect(service.canViewMedicine(owner, privateMed), isTrue);
      expect(service.canEditMedicine(owner, privateMed), isTrue);
    });

    test('Assigned member can always view private medicines', () {
      final privateMed = createMedicine(
        memberId: child.userId,
        visibilityPolicy: VisibilityPolicy.private,
      );

      expect(service.canViewMedicine(child, privateMed), isTrue);
    });

    test('Caregiver can view if assigned in caregivers policy', () {
      final caregiverMed = createMedicine(
        memberId: child.userId,
        visibilityPolicy: VisibilityPolicy.caregivers,
        caregiverIds: [caregiver.userId],
      );

      expect(service.canViewMedicine(caregiver, caregiverMed), isTrue);

      final otherMed = createMedicine(
        memberId: child.userId,
        visibilityPolicy: VisibilityPolicy.caregivers,
        caregiverIds: [],
      );
      expect(service.canViewMedicine(caregiver, otherMed), isFalse);
    });

    test(
        'Family members with viewAdherence can '
        'view family visibility medicines', () {
      final familyMed = createMedicine(
        memberId: child.userId,
        visibilityPolicy: VisibilityPolicy.family,
      );

      // Both caregiver and child have viewAdherence
      expect(service.canViewMedicine(caregiver, familyMed), isTrue);
      expect(service.canViewMedicine(child, familyMed), isTrue);
    });

    test('Caregiver can edit medicines if not private to someone else', () {
      final familyMed = createMedicine(
        memberId: child.userId,
        visibilityPolicy: VisibilityPolicy.family,
      );

      expect(service.canEditMedicine(caregiver, familyMed), isTrue);
    });

    test('Child cannot edit medicines even if family visibility', () {
      final familyMed = createMedicine(
        memberId: owner.userId,
        visibilityPolicy: VisibilityPolicy.family,
      );

      expect(service.canEditMedicine(child, familyMed), isFalse);
    });
  });
}
