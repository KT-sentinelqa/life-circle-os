import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_operation.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_domain.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/conflict_domain.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/repositories/conflict_queue_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/application/conflict_coordinator.dart';
import 'package:lifecircle_mobile/src/features/sync/application/resolvers/domain_resolvers.dart';
import 'package:lifecircle_mobile/src/features/network/domain/request_context.dart';

class MockConflictQueue implements ConflictQueueRepository {
  bool enqueueCalled = false;
  
  @override
  Future<void> enqueueManualConflict(SyncOperation operation, String remotePayload) async {
    enqueueCalled = true;
  }
  @override
  Future<List<SyncOperation>> getPendingConflicts() async => [];
  @override
  Future<void> resolveConflict(String opId, String payload) async {}
  @override
  Future<void> dropConflict(String opId) async {}
}

void main() {
  group('SEC-006D: Entity-Specific Conflict Engine', () {
    late ConflictCoordinator coordinator;
    late MockConflictQueue mockQueue;

    setUp(() {
      mockQueue = MockConflictQueue();
      coordinator = ConflictCoordinator(
        conflictQueueRepository: mockQueue,
        resolvers: [
          MedicineConflictResolver(),
          FinanceConflictResolver(),
          FamilyOwnershipResolver(),
        ],
      );
    });

    final dummyContext = RequestContext(
      requestId: 'req_1',
      sessionId: 'sess_1',
      deviceId: 'dev_1',
      familyId: 'fam_1',
      keyId: 'key_1',
      timestamp: DateTime.now(),
      nonce: 'nonce_1',
    );

    test('Medicine semantic merge - Transforms payload', () async {
      final op = SyncOperation(
        operationId: 'op_1',
        entityId: 'med_1',
        entityType: 'Medicine',
        mutationType: MutationType.update,
        payload: '{"dosage":"10mg", "notes":"Local update"}',
        timestamp: DateTime.now(),
        sequenceNumber: 1,
        idempotencyKey: 'k_1',
        status: SyncOperationStatus.inFlight,
        retryCount: 0,
        attempt: 1,
      );

      final remotePayload = '{"dosage":"10mg", "notes":"Remote update"}';

      final audit = await coordinator.handleConflict(
        operation: op,
        remotePayload: remotePayload,
        context: dummyContext,
      );

      expect(audit.resolverUsed, 'MedicineConflictResolver');
      expect(audit.resolutionResult, ConflictResolutionStatus.transformAndRetry);
      expect(mockQueue.enqueueCalled, isFalse);
    });

    test('Medicine semantic merge - Dosage mismatch escalates to manual', () async {
      // Base: 10mg, Local: 20mg, Remote: 5mg
      // The stub resolver doesn't have localBase injection, but simulates it.
      // We simulate differing payloads that trigger escalation logic if implemented purely.
      // Since our Mock in handleConflict uses empty map for localBase, localBase!=localCurrent && localBase!=remoteCurrent is true.
      
      final op = SyncOperation(
        operationId: 'op_2',
        entityId: 'med_1',
        entityType: 'Medicine',
        mutationType: MutationType.update,
        payload: '{"dosage":"20mg"}',
        timestamp: DateTime.now(),
        sequenceNumber: 1,
        idempotencyKey: 'k_1',
        status: SyncOperationStatus.inFlight,
        retryCount: 0,
        attempt: 1,
      );

      final remotePayload = '{"dosage":"5mg"}';

      final audit = await coordinator.handleConflict(
        operation: op,
        remotePayload: remotePayload,
        context: dummyContext,
      );

      expect(audit.resolutionResult, ConflictResolutionStatus.escalateManual);
      expect(mockQueue.enqueueCalled, isTrue); // Correctly parked in manual queue
    });

    test('Finance - Always escalates to manual', () async {
      final op = SyncOperation(
        operationId: 'op_3',
        entityId: 'fin_1',
        entityType: 'Finance',
        mutationType: MutationType.update,
        payload: '{}',
        timestamp: DateTime.now(),
        sequenceNumber: 1,
        idempotencyKey: 'k_1',
        status: SyncOperationStatus.inFlight,
        retryCount: 0,
        attempt: 1,
      );

      final audit = await coordinator.handleConflict(
        operation: op,
        remotePayload: '{}',
        context: dummyContext,
      );

      expect(audit.resolverUsed, 'FinanceConflictResolver');
      expect(audit.resolutionResult, ConflictResolutionStatus.escalateManual);
      expect(mockQueue.enqueueCalled, isTrue);
    });

    test('Family - Server Authoritative always accepts remote', () async {
      final op = SyncOperation(
        operationId: 'op_4',
        entityId: 'fam_1',
        entityType: 'Family',
        mutationType: MutationType.update,
        payload: '{}',
        timestamp: DateTime.now(),
        sequenceNumber: 1,
        idempotencyKey: 'k_1',
        status: SyncOperationStatus.inFlight,
        retryCount: 0,
        attempt: 1,
      );

      final audit = await coordinator.handleConflict(
        operation: op,
        remotePayload: '{}',
        context: dummyContext,
      );

      expect(audit.resolverUsed, 'FamilyOwnershipResolver');
      expect(audit.resolutionResult, ConflictResolutionStatus.acceptedRemote);
    });

    test('Unhandled entity type defaults to manual escalation', () async {
      final op = SyncOperation(
        operationId: 'op_5',
        entityId: 'cal_1',
        entityType: 'Calendar', // No resolver registered for Calendar
        mutationType: MutationType.update,
        payload: '{}',
        timestamp: DateTime.now(),
        sequenceNumber: 1,
        idempotencyKey: 'k_1',
        status: SyncOperationStatus.inFlight,
        retryCount: 0,
        attempt: 1,
      );

      final audit = await coordinator.handleConflict(
        operation: op,
        remotePayload: '{}',
        context: dummyContext,
      );

      expect(audit.resolverUsed, 'default');
      expect(audit.resolutionResult, ConflictResolutionStatus.escalateManual);
      expect(mockQueue.enqueueCalled, isTrue);
    });
  });
}
