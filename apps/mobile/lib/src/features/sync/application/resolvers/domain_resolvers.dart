import 'dart:convert';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_operation.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/conflict_domain.dart';
import 'package:lifecircle_mobile/src/features/network/domain/request_context.dart';
import 'package:lifecircle_mobile/src/features/sync/application/conflict_coordinator.dart';

class MedicineConflictResolver implements EntityConflictResolver {
  @override
  String get supportedEntityType => 'Medicine';

  @override
  Future<ConflictResolutionResult> resolve({
    required Map<String, dynamic> localBase,
    required Map<String, dynamic> localCurrent,
    required Map<String, dynamic> remoteCurrent,
    required List<SyncOperation> pendingOperations,
    required RequestContext context,
  }) async {
    // Semantic merge rules for Medicine
    // 1. If dosage changed locally AND remotely -> escalate
    if (localBase['dosage'] != localCurrent['dosage'] && localBase['dosage'] != remoteCurrent['dosage']) {
      return const ConflictResolutionResult(status: ConflictResolutionStatus.escalateManual);
    }

    // 2. If archived on server -> server wins
    if (remoteCurrent['isArchived'] == true) {
      return const ConflictResolutionResult(status: ConflictResolutionStatus.acceptedRemote);
    }

    // 3. Merge notes (append)
    final mergedNotes = '${remoteCurrent['notes'] ?? ''}\n--- Local Edit ---\n${localCurrent['notes'] ?? ''}';
    final mergedPayload = Map<String, dynamic>.from(remoteCurrent);
    mergedPayload['notes'] = mergedNotes;

    // 4. Transform and retry
    return ConflictResolutionResult(
      status: ConflictResolutionStatus.transformAndRetry,
      resolvedPayload: jsonEncode(mergedPayload),
    );
  }
}

class FinanceConflictResolver implements EntityConflictResolver {
  @override
  String get supportedEntityType => 'Finance';

  @override
  Future<ConflictResolutionResult> resolve({
    required Map<String, dynamic> localBase,
    required Map<String, dynamic> localCurrent,
    required Map<String, dynamic> remoteCurrent,
    required List<SyncOperation> pendingOperations,
    required RequestContext context,
  }) async {
    // Financial data never merges automatically.
    return const ConflictResolutionResult(status: ConflictResolutionStatus.escalateManual);
  }
}

class FamilyOwnershipResolver implements EntityConflictResolver {
  @override
  String get supportedEntityType => 'Family';

  @override
  Future<ConflictResolutionResult> resolve({
    required Map<String, dynamic> localBase,
    required Map<String, dynamic> localCurrent,
    required Map<String, dynamic> remoteCurrent,
    required List<SyncOperation> pendingOperations,
    required RequestContext context,
  }) async {
    // Family Ownership is purely Server Authoritative
    return const ConflictResolutionResult(status: ConflictResolutionStatus.acceptedRemote);
  }
}
