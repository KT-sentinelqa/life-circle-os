// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_member_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FamilyMemberEntityImpl _$$FamilyMemberEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$FamilyMemberEntityImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      familyId: json['familyId'] as String,
      role: $enumDecodeNullable(_$MemberRoleEnumMap, json['role']) ??
          MemberRole.caregiver,
    );

Map<String, dynamic> _$$FamilyMemberEntityImplToJson(
        _$FamilyMemberEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'familyId': instance.familyId,
      'role': _$MemberRoleEnumMap[instance.role]!,
    };

const _$MemberRoleEnumMap = {
  MemberRole.owner: 'owner',
  MemberRole.caregiver: 'caregiver',
  MemberRole.parent: 'parent',
  MemberRole.child: 'child',
};
