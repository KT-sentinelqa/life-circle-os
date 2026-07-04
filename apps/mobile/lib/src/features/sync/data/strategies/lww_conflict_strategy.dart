import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_conflict_entity.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/services/conflict_resolution_service.dart';

/// Resolves conflicts using a Last-Write-Wins (LWW) strategy.
class LwwConflictStrategy implements ConflictResolutionService {
  /// Creates a new [LwwConflictStrategy].
  const LwwConflictStrategy();

  @override
  bool resolveConflict(SyncConflictEntity conflict) {
    return conflict.clientTimestamp.isAfter(conflict.serverTimestamp);
  }
}
