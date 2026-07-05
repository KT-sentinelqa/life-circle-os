// ignore_for_file: one_member_abstracts

import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_conflict_entity.dart';

/// Abstract contract for determining how to handle data conflicts.
///
/// Interface-driven design is required here by the architecture board
/// to support dependency injection of diverse resolution strategies
/// (e.g. LWW, Server-Authoritative, CRDTs) without breaking clients.
abstract class ConflictResolutionService {
  /// Resolves a conflict based on the provided strategy.
  /// Returns `true` if the client write should proceed (overwrite server).
  /// Returns `false` if the server write should be kept (discard client).
  bool resolveConflict(SyncConflictEntity conflict);
}
