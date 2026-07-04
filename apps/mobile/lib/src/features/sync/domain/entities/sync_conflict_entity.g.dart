// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_conflict_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SyncConflictEntityImpl _$$SyncConflictEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$SyncConflictEntityImpl(
      serverTimestamp: DateTime.parse(json['serverTimestamp'] as String),
      clientTimestamp: DateTime.parse(json['clientTimestamp'] as String),
      deviceId: json['deviceId'] as String,
      operationId: json['operationId'] as String,
      version: (json['version'] as num).toInt(),
    );

Map<String, dynamic> _$$SyncConflictEntityImplToJson(
        _$SyncConflictEntityImpl instance) =>
    <String, dynamic>{
      'serverTimestamp': instance.serverTimestamp.toIso8601String(),
      'clientTimestamp': instance.clientTimestamp.toIso8601String(),
      'deviceId': instance.deviceId,
      'operationId': instance.operationId,
      'version': instance.version,
    };
