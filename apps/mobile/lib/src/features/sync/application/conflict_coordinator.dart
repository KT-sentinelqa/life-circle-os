import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_operation.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/conflict_domain.dart';
import 'package:lifecircle_mobile/src/features/network/domain/request_context.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/repositories/conflict_queue_repository.dart';

abstract class EntityConflictResolver {
  String get supportedEntityType;

  Future<ConflictResolutionResult> resolve({
    required Map<String, dynamic> localBase,
    required Map<String, dynamic> localCurrent,
    required Map<String, dynamic> remoteCurrent,
    required List<SyncOperation> pendingOperations,
    required RequestContext context,
  });
}

class ConflictCoordinator {
  ConflictCoordinator({
    required this.conflictQueueRepository,
    required List<EntityConflictResolver> resolvers,
  }) {
    for (final r in resolvers) {
      _resolvers[r.supportedEntityType] = r;
    }
  }

  final ConflictQueueRepository conflictQueueRepository;
  final Map<String, EntityConflictResolver> _resolvers = {};

  Future<ConflictAuditRecord> handleConflict({
    required SyncOperation operation,
    required String remotePayload,
    required RequestContext context,
  }) async {
    final resolver = _resolvers[operation.entityType];

    if (resolver == null) {
      // Unhandled domain defaults to Manual Escalation
      await conflictQueueRepository.enqueueManualConflict(operation, remotePayload);
      return _buildAudit(operation, 'default', ConflictResolutionStatus.escalateManual);
    }

    // Mocking local base logic. A real implementation would pull from the Repo.
    final localBase = <String, dynamic>{};
    final localCurrent = jsonDecode(operation.payload) as Map<String, dynamic>;
    final remoteCurrent = jsonDecode(remotePayload) as Map<String, dynamic>;

    final result = await resolver.resolve(
      localBase: localBase,
      localCurrent: localCurrent,
      remoteCurrent: remoteCurrent,
      pendingOperations: [operation],
      context: context,
    );

    if (result.status == ConflictResolutionStatus.escalateManual) {
      await conflictQueueRepository.enqueueManualConflict(operation, remotePayload);
    }

    return _buildAudit(operation, resolver.runtimeType.toString(), result.status);
  }

  ConflictAuditRecord _buildAudit(SyncOperation op, String resolver, ConflictResolutionStatus status) {
    return ConflictAuditRecord(
      conflictId: const Uuid().v4(),
      entityType: op.entityType,
      entityId: op.entityId,
      localVersion: 0, // Mocked
      remoteVersion: 1, // Mocked
      resolverUsed: resolver,
      resolutionResult: status,
      timestamp: DateTime.now().toUtc(),
      operator: 'automatic',
    );
  }
}
