import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_operation.dart';

/// Segregates operations that require manual conflict resolution so they do not block the primary outbox.
abstract class ConflictQueueRepository {
  /// Moves an operation from the main Outbox into the Conflict Queue.
  Future<void> enqueueManualConflict(SyncOperation operation, String remotePayload);

  /// Retrieves conflicts pending UI resolution.
  Future<List<SyncOperation>> getPendingConflicts();

  /// Resolves the conflict, moving a newly transformed operation back into the primary Outbox.
  Future<void> resolveConflict(String operationId, String resolvedPayload);

  /// Dismisses the conflict, acknowledging the server state and dropping the local mutation.
  Future<void> dropConflict(String operationId);
}
