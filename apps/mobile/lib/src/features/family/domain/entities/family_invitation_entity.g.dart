// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_invitation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FamilyInvitationEntityImpl _$$FamilyInvitationEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$FamilyInvitationEntityImpl(
      id: json['id'] as String,
      familyId: json['familyId'] as String,
      email: json['email'] as String,
      status: $enumDecodeNullable(_$InvitationStatusEnumMap, json['status']) ??
          InvitationStatus.pending,
      invitedAt: DateTime.parse(json['invitedAt'] as String),
    );

Map<String, dynamic> _$$FamilyInvitationEntityImplToJson(
        _$FamilyInvitationEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'familyId': instance.familyId,
      'email': instance.email,
      'status': _$InvitationStatusEnumMap[instance.status]!,
      'invitedAt': instance.invitedAt.toIso8601String(),
    };

const _$InvitationStatusEnumMap = {
  InvitationStatus.pending: 'pending',
  InvitationStatus.accepted: 'accepted',
  InvitationStatus.rejected: 'rejected',
};
