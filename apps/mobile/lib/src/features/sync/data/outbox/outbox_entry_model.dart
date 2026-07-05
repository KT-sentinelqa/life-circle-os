import 'package:isar/isar.dart';

import 'package:lifecircle_mobile/src/core/utils/hash.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/outbox_entry_entity.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_status_entity.dart';

part 'outbox_entry_model.g.dart';

/// Isar database model representing an outbox entry.
@collection
class IsarOutboxEntry {
  /// Creates an empty [IsarOutboxEntry].
  IsarOutboxEntry();

  /// Creates an [IsarOutboxEntry] from a domain [OutboxEntryEntity].
  factory IsarOutboxEntry.fromDomain(OutboxEntryEntity entity) {
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

  /// The internal Isar identifier.
  Id get internalId => fastHash(id);

  /// Unique external identifier.
  late String id;

  /// Identifier of the affected aggregate.
  @Index()
  late String aggregateId;

  /// Type of the aggregate (e.g., Medicine).
  late String aggregateType;

  /// The operation performed (e.g., CREATE).
  late String operationType;

  /// The serialized payload of the operation.
  late String payload;

  /// UTC timestamp of creation.
  late DateTime createdAt;

  /// UTC timestamp of the last update.
  late DateTime updatedAt;

  /// Number of times sync has been retried.
  late int retryCount;

  /// UTC timestamp for the next allowed retry, if applicable.
  late DateTime? nextRetryAt;

  /// Identifier of the device that created the entry.
  late String deviceId;

  /// Unique identifier for the operation to ensure idempotency.
  late String operationId;

  /// The current sync status.
  @Enumerated(EnumType.name)
  late SyncStatusEntity status;

  /// Converts this Isar model into a domain [OutboxEntryEntity].
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
      deviceId: deviceId,
      operationId: operationId,
      status: status,
      nextRetryAt: nextRetryAt,
    );
  }
}
