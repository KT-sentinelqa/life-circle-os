import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_conflict_entity.dart';

abstract class ConflictResolutionService {
  /// Resolves a conflict based on the provided strategy.
  /// Returns `true` if the client write should proceed (overwrite server).
  /// Returns `false` if the server write should be kept (discard client).
  bool resolveConflict(SyncConflictEntity conflict);
}
