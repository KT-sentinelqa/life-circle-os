import 'package:isar/isar.dart';
import 'package:lifecircle_mobile/src/core/utils/hash.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_invitation_entity.dart';

part 'isar_invitation.g.dart';

@collection
class IsarInvitation {
  Id get internalId => fastHash(id);

  late String id;
  @Index()
  late String familyId;
  @Index()
  late String email;
  @Enumerated(EnumType.name)
  late InvitationStatus status;
  late DateTime invitedAt;

  FamilyInvitationEntity toDomain() {
    return FamilyInvitationEntity(
      id: id,
      familyId: familyId,
      email: email,
      status: status,
      invitedAt: invitedAt,
    );
  }

  static IsarInvitation fromDomain(FamilyInvitationEntity invitation) {
    return IsarInvitation()
      ..id = invitation.id
      ..familyId = invitation.familyId
      ..email = invitation.email
      ..status = invitation.status
      ..invitedAt = invitation.invitedAt;
  }
}
