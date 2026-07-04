import 'package:isar/isar.dart';
import 'package:lifecircle_mobile/src/core/utils/hash.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/outbox_entry_entity.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_status_entity.dart';

part 'outbox_entry_model.g.dart';

@collection
class IsarOutboxEntry {
  Id get internalId => fastHash(id);

  late String id;
  @Index()
  late String aggregateId;
  late String aggregateType;
  late String operationType;
  late String payload;
  late DateTime createdAt;
  late DateTime updatedAt;
  late int retryCount;
  late DateTime? nextRetryAt;
  late String deviceId;
  late String operationId;
  
  @Enumerated(EnumType.name)
  late SyncStatusEntity status;

  OutboxEntryEntity toDomain() {
    return OutboxEntryEntity(
      id: id,
      aggregateId: aggregateId,
      aggregateType: aggregateType,
      operationType: operationType,
      payload: payload,
      createdAt: createdAt,
      updatedAt: updatedAt,
      retryCount: retryCount,
      nextRetryAt: nextRetryAt,
      deviceId: deviceId,
      operationId: operationId,
      status: status,
    );
  }

  static IsarOutboxEntry fromDomain(OutboxEntryEntity entity) {
    return IsarOutboxEntry()
      ..id = entity.id
      ..aggregateId = entity.aggregateId
      ..aggregateType = entity.aggregateType
      ..operationType = entity.operationType
      ..payload = entity.payload
      ..createdAt = entity.createdAt
      ..updatedAt = entity.updatedAt
      ..retryCount = entity.retryCount
      ..nextRetryAt = entity.nextRetryAt
      ..deviceId = entity.deviceId
      ..operationId = entity.operationId
      ..status = entity.status;
  }
}
