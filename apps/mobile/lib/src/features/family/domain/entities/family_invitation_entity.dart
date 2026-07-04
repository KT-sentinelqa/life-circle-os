import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_invitation_entity.freezed.dart';
part 'family_invitation_entity.g.dart';

/// Represents the status of a family invitation.
enum InvitationStatus { 
  /// Invitation is pending.
  pending, 
  
  /// Invitation is accepted.
  accepted, 
  
  /// Invitation is rejected.
  rejected,
}

/// Represents an invitation to join a family.
@freezed
class FamilyInvitationEntity with _$FamilyInvitationEntity {
  /// Creates a [FamilyInvitationEntity].
  const factory FamilyInvitationEntity({
    /// Unique identifier for the invitation.
    required String id,
    
    /// The family ID the user is invited to.
    required String familyId,
    
    /// The email address of the invited user.
    required String email,
    
    /// The time the invitation was sent.
    required DateTime invitedAt,
    
    /// The status of the invitation.
    @Default(InvitationStatus.pending) InvitationStatus status,
  }) = _FamilyInvitationEntity;

  /// Creates a [FamilyInvitationEntity] from a JSON object.
  factory FamilyInvitationEntity.fromJson(Map<String, dynamic> json) => 
      _$FamilyInvitationEntityFromJson(json);
}
