import 'package:lifecircle_mobile/src/features/family/domain/entities/family_entity.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_invitation_entity.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_member_entity.dart';

/// Abstract contract for family data operations.
abstract interface class FamilyRepository {
  /// Creates a new family.
  Future<FamilyEntity> createFamily(String name);
  
  /// Retrieves members of a family.
  Future<List<FamilyMemberEntity>> getMembers(String familyId);
  
  /// Invites a member to a family.
  Future<FamilyInvitationEntity> inviteMember(String familyId, String email);
}
