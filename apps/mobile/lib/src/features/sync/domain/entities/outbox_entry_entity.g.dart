// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outbox_entry_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OutboxEntryEntityImpl _$$OutboxEntryEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$OutboxEntryEntityImpl(
      id: json['id'] as String,
      aggregateId: json['aggregateId'] as String,
      aggregateType: json['aggregateType'] as String,
      operationType: json['operationType'] as String,
      payload: json['payload'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      retryCount: (json['retryCount'] as num).toInt(),
      deviceId: json['deviceId'] as String,
      operationId: json['operationId'] as String,
      status: $enumDecode(_$SyncStatusEntityEnumMap, json['status']),
      nextRetryAt: json['nextRetryAt'] == null
          ? null
          : DateTime.parse(json['nextRetryAt'] as String),
    );

Map<String, dynamic> _$$OutboxEntryEntityImplToJson(
        _$OutboxEntryEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'aggregateId': instance.aggregateId,
      'aggregateType': instance.aggregateType,
      'operationType': instance.operationType,
      'payload': instance.payload,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'retryCount': instance.retryCount,
      'deviceId': instance.deviceId,
      'operationId': instance.operationId,
      'status': _$SyncStatusEntityEnumMap[instance.status]!,
      'nextRetryAt': instance.nextRetryAt?.toIso8601String(),
    };

const _$SyncStatusEntityEnumMap = {
  SyncStatusEntity.pending: 'pending',
  SyncStatusEntity.inProgress: 'inProgress',
  SyncStatusEntity.completed: 'completed',
  SyncStatusEntity.failed: 'failed',
  SyncStatusEntity.deadLetter: 'deadLetter',
};
