import 'dart:math';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_operation.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_domain.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_telemetry.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/repositories/outbox_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/application/sync_envelope_builder.dart';
import 'package:lifecircle_mobile/src/features/network/domain/request_context.dart';
import 'package:lifecircle_mobile/src/features/device_trust/domain/trust_evidence.dart';
import 'package:lifecircle_mobile/src/features/session/application/session_validator.dart';
import 'package:lifecircle_mobile/src/features/session/domain/entities/session_binding.dart';

abstract class SyncApiClient {
  Future<SyncBatchResponse> pushEnvelope(SyncEnvelope envelope);
}

class SyncCoordinator {
  const SyncCoordinator({
    required this.outboxRepository,
    required this.envelopeBuilder,
    required this.apiClient,
    required this.sessionValidator,
  });

  final OutboxRepository outboxRepository;
  final SyncEnvelopeBuilder envelopeBuilder;
  final SyncApiClient apiClient;
  final SessionValidator sessionValidator;

  static const int maxBatchSize = 100;
  static const Duration stuckTimeout = Duration(minutes: 5);
  static const int maxRetries = 5;

  /// Triggers a synchronization cycle.
  Future<void> runCycle({
    required RequestContext requestContext,
    required TrustEvidence trustEvidence,
    required SessionBinding binding,
  }) async {
    final startTime = DateTime.now();
    int transportFails = 0;
    int sessionFails = 0;
    int trustFails = 0;
    int sigFails = 0;

    // 1. Session Validation
    final isValid = await sessionValidator.validateBinding(
      binding: binding,
      sessionId: requestContext.sessionId,
      deviceId: requestContext.deviceId,
    );
    if (!isValid) {
      sessionFails++;
      _emitTelemetry(requestContext.requestId, 0, 0, startTime, 0, 0, 0, sigFails, sessionFails, trustFails, transportFails);
      return; // Suspend processing
    }

    // 2. Recover Stuck Operations
    await outboxRepository.recoverStuckOperations(stuckTimeout);

    // 3. Fetch Pending
    final operations = await outboxRepository.getPendingBatch(maxBatchSize);
    if (operations.isEmpty) return;

    final opIds = operations.map((op) => op.operationId).toList();
    await outboxRepository.markInFlight(opIds);

    int conflictCount = 0;
    int dupCount = 0;
    int retryCount = 0;

    try {
      // 4. Build Envelope
      final maxSequence = operations.map((op) => op.sequenceNumber).reduce(max);
      final envelope = await envelopeBuilder.buildEnvelope(
        requestContext: requestContext,
        trustEvidence: trustEvidence,
        operations: operations,
        maxSequenceNumber: maxSequence,
      );

      // 5. Transmit
      final response = await apiClient.pushEnvelope(envelope);

      // 6. Process Partial Successes
      for (final op in operations) {
        final result = response.results[op.operationId];
        if (result == null) {
          // Unhandled by server, assumed retry
          retryCount++;
          await _handleRetry(op, 'Unhandled by server');
          continue;
        }

        switch (result) {
          case SyncOperationResult.acknowledge:
          case SyncOperationResult.duplicate: // Treated as successful consumption
            if (result == SyncOperationResult.duplicate) dupCount++;
            await outboxRepository.acknowledge([op.operationId]);
            break;
          case SyncOperationResult.conflict:
            conflictCount++;
            // Delegate to conflict engine later. For now, mark failed.
            await _handleRetry(op, 'Conflict');
            break;
          case SyncOperationResult.retry:
            retryCount++;
            await _handleRetry(op, 'Server requested retry');
            break;
          case SyncOperationResult.reject:
            // Terminal failure, move to dead-letter
            await _moveToDeadLetter(op.operationId);
            break;
        }
      }
    } catch (e) {
      transportFails++;
      for (var op in operations) {
        await _handleRetry(op, e.toString());
      }
    } finally {
      // 7. Emit Telemetry
      _emitTelemetry(requestContext.requestId, 0 /* queue depth mocked */, operations.length, startTime, retryCount, conflictCount, dupCount, sigFails, sessionFails, trustFails, transportFails);
    }
  }

  Future<void> _handleRetry(SyncOperation op, String reason) async {
    final nextAttempt = op.attempt + 1;
    if (nextAttempt >= maxRetries) {
      await _moveToDeadLetter(op.operationId);
    } else {
      final backoffMinutes = pow(2, nextAttempt).toInt();
      final nextRetryAt = DateTime.now().toUtc().add(Duration(minutes: backoffMinutes));
      await outboxRepository.handleFailure(op.operationId, reason, nextRetryAt);
    }
  }

  Future<void> _moveToDeadLetter(String operationId) async {
    // In real implementation, this updates DB status to SyncOperationStatus.deadLetter
    await outboxRepository.handleFailure(operationId, 'DeadLetter Threshold Reached', DateTime.now().toUtc().add(const Duration(days: 9999)));
  }

  void _emitTelemetry(String batchId, int queueDepth, int batchSize, DateTime startTime, int retries, int conflicts, int duplicates, int sigFails, int sessFails, int trustFails, int transFails) {
    final latency = DateTime.now().difference(startTime).inMilliseconds;
    final event = SyncTelemetryEvent(
      batchId: batchId,
      queueDepth: queueDepth,
      batchSize: batchSize,
      syncLatencyMs: latency,
      retryCount: retries,
      conflictCount: conflicts,
      duplicateCount: duplicates,
      signatureFailures: sigFails,
      sessionFailures: sessFails,
      trustFailures: trustFails,
      transportFailures: transFails,
      timestamp: DateTime.now().toUtc(),
    );
    print('SyncTelemetry emitted for batch $batchId');
  }
}
