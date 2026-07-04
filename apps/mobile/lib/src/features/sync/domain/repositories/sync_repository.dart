import 'package:lifecircle_mobile/src/features/sync/domain/entities/outbox_entry_entity.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_status_entity.dart';

/// Abstract contract for interacting with the sync outbox.
abstract class SyncRepository {
  /// Enqueues a new outbox entry for background synchronization.
  Future<void> enqueue(OutboxEntryEntity entry);

  /// Retrieves all entries currently pending sync.
  Future<List<OutboxEntryEntity>> getPendingEntries();

  /// Updates the status and retry metadata for a specific entry.
  Future<void> updateEntryStatus(
    String id,
    SyncStatusEntity status, {
    int? retryCount,
    DateTime? nextRetryAt,
  });
}
