import 'package:isar/isar.dart';

import 'package:lifecircle_mobile/src/core/utils/hash.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_invitation_entity.dart';

part 'isar_invitation.g.dart';

/// Isar collection representing a [FamilyInvitationEntity].
@collection
class IsarInvitation {
  /// Creates an [IsarInvitation].
  IsarInvitation();

  /// Creates an [IsarInvitation] from a [FamilyInvitationEntity].
  factory IsarInvitation.fromDomain(FamilyInvitationEntity invitation) {
    return IsarInvitation()
      ..id = invitation.id
      ..familyId = invitation.familyId
      ..email = invitation.email
      ..status = invitation.status
      ..invitedAt = invitation.invitedAt;
  }

  /// The internal Isar ID based on the UUID hash.
  Id get internalId => fastHash(id);

  /// The UUID of the invitation.
  late String id;

  /// The UUID of the family.
  @Index()
  late String familyId;

  /// The email address of the invited user.
  @Index()
  late String email;

  /// The status of the invitation.
  @Enumerated(EnumType.name)
  late InvitationStatus status;

  /// The time the invitation was sent.
  late DateTime invitedAt;

  /// Converts this Isar model to a [FamilyInvitationEntity].
  FamilyInvitationEntity toDomain() {
    return FamilyInvitationEntity(
      id: id,
      familyId: familyId,
      email: email,
      status: status,
      invitedAt: invitedAt,
    );
  }
}
