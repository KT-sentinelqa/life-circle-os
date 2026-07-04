import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_status_entity.dart';

part 'outbox_entry_entity.freezed.dart';
part 'outbox_entry_entity.g.dart';

/// Represents a pending or completed sync operation.
@freezed
class OutboxEntryEntity with _$OutboxEntryEntity {
  /// Creates a new [OutboxEntryEntity].
  const factory OutboxEntryEntity({
    required String id,
    required String aggregateId,
    required String aggregateType,
    required String operationType,
    required String payload,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int retryCount,
    required String deviceId,
    required String operationId,
    required SyncStatusEntity status,
    DateTime? nextRetryAt,
  }) = _OutboxEntryEntity;

  /// Restores an [OutboxEntryEntity] from a JSON map.
  factory OutboxEntryEntity.fromJson(Map<String, dynamic> json) =>
      _$OutboxEntryEntityFromJson(json);
}
