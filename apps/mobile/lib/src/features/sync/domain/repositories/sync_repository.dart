import 'package:lifecircle_mobile/src/features/sync/domain/entities/outbox_entry_entity.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_status_entity.dart';

abstract class SyncRepository {
  Future<void> enqueue(OutboxEntryEntity entry);
  Future<List<OutboxEntryEntity>> getPendingEntries();
  Future<void> updateEntryStatus(
    String id, 
    SyncStatusEntity status, {
    int? retryCount, 
    DateTime? nextRetryAt,
  });
}
