// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FamilyEntityImpl _$$FamilyEntityImplFromJson(Map<String, dynamic> json) =>
    _$FamilyEntityImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$FamilyEntityImplToJson(_$FamilyEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
    };
