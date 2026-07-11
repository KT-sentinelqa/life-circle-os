import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_operation.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_domain.dart';

abstract class OutboxRepository {
  /// Enqueues a new operation. Must be called atomically within a local DB transaction.
  Future<void> enqueue(SyncOperation operation);

  /// Fetches pending operations for synchronization, ordered by sequence number.
  Future<List<SyncOperation>> getPendingBatch(int limit);

  /// Marks specific operations as IN_FLIGHT to lock them from concurrent sync workers.
  Future<void> markInFlight(List<String> operationIds);

  /// Marks operations as ARCHIVED upon successful server acknowledgment.
  Future<void> acknowledge(List<String> operationIds);

  /// Increments retry counts and sets status to FAILED or PENDING depending on retry logic.
  Future<void> handleFailure(String operationId, String errorReason, DateTime nextRetryAt);
  
  /// Fetches the latest synchronization checkpoint.
  Future<SyncCheckpoint?> getCheckpoint();

  /// Updates the local checkpoint cursor after successful processing.
  Future<void> updateCheckpoint(SyncCheckpoint checkpoint);

  /// Recovers operations that have been IN_FLIGHT for too long (e.g. process crashed).
  Future<void> recoverStuckOperations(Duration timeout);
}
