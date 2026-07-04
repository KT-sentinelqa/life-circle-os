import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_conflict_entity.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/services/conflict_resolution_service.dart';

class LwwConflictStrategy implements ConflictResolutionService {
  @override
  bool resolveConflict(SyncConflictEntity conflict) {
    return conflict.clientTimestamp.isAfter(conflict.serverTimestamp);
  }
}
