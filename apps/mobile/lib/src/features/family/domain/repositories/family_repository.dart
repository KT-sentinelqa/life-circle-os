import 'package:lifecircle_mobile/src/features/family/domain/entities/family_entity.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_member_entity.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_invitation_entity.dart';

/// Abstract contract for family data operations.
abstract class FamilyRepository {
  Future<FamilyEntity> createFamily(String name);
  Future<List<FamilyMemberEntity>> getMembers(String familyId);
  Future<FamilyInvitationEntity> inviteMember(String familyId, String email);
}
