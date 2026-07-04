import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_status_entity.dart';

part 'outbox_entry_entity.freezed.dart';
part 'outbox_entry_entity.g.dart';

@freezed
class OutboxEntryEntity with _$OutboxEntryEntity {
  const factory OutboxEntryEntity({
    required String id,
    required String aggregateId,
    required String aggregateType,
    required String operationType,
    required String payload,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int retryCount,
    DateTime? nextRetryAt,
    required String deviceId,
    required String operationId,
    required SyncStatusEntity status,
  }) = _OutboxEntryEntity;

  factory OutboxEntryEntity.fromJson(Map<String, dynamic> json) => _$OutboxEntryEntityFromJson(json);
}
