import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_event_entity.freezed.dart';

/// Defines the category of a sync event.
enum SyncEventType {
  /// Indicates a sync session has started.
  syncStarted,

  /// Indicates a sync session has finished successfully.
  syncCompleted,

  /// Indicates a sync session encountered an error.
  syncFailed,

  /// Indicates a sync job has been queued for later.
  jobEnqueued,
}

/// Represents an auditing or lifecycle event in the sync engine.
@freezed
class SyncEventEntity with _$SyncEventEntity {
  /// Creates a new [SyncEventEntity].
  const factory SyncEventEntity({
    required SyncEventType type,
    required DateTime timestamp,
    String? message,
    String? jobId,
  }) = _SyncEventEntity;
}
