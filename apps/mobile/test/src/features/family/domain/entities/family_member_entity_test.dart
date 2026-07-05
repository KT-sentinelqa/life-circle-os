import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_member_entity.dart';

void main() {
  group('FamilyMemberEntity and MemberRole', () {
    test('default role is caregiver', () {
      const member = FamilyMemberEntity(
        id: 'member-123',
        userId: 'user-123',
        familyId: 'family-123',
      );

      expect(member.role, equals(MemberRole.caregiver));
    });

    test('owner has all permissions', () {
      final permissions = MemberRole.owner.permissions;
      expect(permissions, contains(FamilyPermission.manageFamily));
      expect(permissions, contains(FamilyPermission.manageMedicines));
      expect(permissions, contains(FamilyPermission.viewAdherence));
      expect(permissions, contains(FamilyPermission.receiveAlerts));
    });

    test('caregiver has expected subset of permissions', () {
      final permissions = MemberRole.caregiver.permissions;
      expect(permissions, isNot(contains(FamilyPermission.manageFamily)));
      expect(permissions, contains(FamilyPermission.manageMedicines));
      expect(permissions, contains(FamilyPermission.receiveAlerts));
      expect(permissions, contains(FamilyPermission.viewAdherence));
    });

    test('child only has viewAdherence permission', () {
      final permissions = MemberRole.child.permissions;
      expect(permissions.length, equals(1));
      expect(permissions, contains(FamilyPermission.viewAdherence));
    });
  });
}
