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
      invitedAt: DateTime.parse(json['invitedAt'] as String),
      status: $enumDecodeNullable(_$InvitationStatusEnumMap, json['status']) ??
          InvitationStatus.pending,
    );

Map<String, dynamic> _$$FamilyInvitationEntityImplToJson(
        _$FamilyInvitationEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'familyId': instance.familyId,
      'email': instance.email,
      'invitedAt': instance.invitedAt.toIso8601String(),
      'status': _$InvitationStatusEnumMap[instance.status]!,
    };

const _$InvitationStatusEnumMap = {
  InvitationStatus.pending: 'pending',
  InvitationStatus.accepted: 'accepted',
  InvitationStatus.rejected: 'rejected',
};
