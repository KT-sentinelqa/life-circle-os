import 'package:lifecircle_mobile/src/sdk/v1/models/dto/family_dto.dart';
import 'package:lifecircle_mobile/src/sdk/v1/errors/lifecircle_exception.dart';

abstract class FamilySDK {
  /// Creates a new family cluster.
  Future<FamilyDTO> createFamily(String name);

  /// Invites a member to the family.
  Future<void> inviteMember(String familyId, String email);

  /// Removes a member from the family.
  Future<void> removeMember(String familyId, String memberId);

  /// Fetches the current state of the Family as an immutable DTO.
  Future<FamilyDTO> getFamily(String familyId);
}
