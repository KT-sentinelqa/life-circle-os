import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_event_entity.freezed.dart';

enum SyncEventType {
  syncStarted,
  syncCompleted,
  syncFailed,
  jobEnqueued,
}

@freezed
class SyncEventEntity with _$SyncEventEntity {
  const factory SyncEventEntity({
    required SyncEventType type,
    required DateTime timestamp,
    String? message,
    String? jobId,
  }) = _SyncEventEntity;
}
