import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_invitation_entity.freezed.dart';
part 'family_invitation_entity.g.dart';

enum InvitationStatus { pending, accepted, rejected }

@freezed
class FamilyInvitationEntity with _$FamilyInvitationEntity {
  const factory FamilyInvitationEntity({
    required String id,
    required String familyId,
    required String email,
    @Default(InvitationStatus.pending) InvitationStatus status,
    required DateTime invitedAt,
  }) = _FamilyInvitationEntity;

  factory FamilyInvitationEntity.fromJson(Map<String, dynamic> json) => _$FamilyInvitationEntityFromJson(json);
}
