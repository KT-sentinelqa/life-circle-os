import 'dart:math';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_operation.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_domain.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/repositories/outbox_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/application/sync_envelope_builder.dart';
import 'package:lifecircle_mobile/src/features/network/domain/request_context.dart';
import 'package:lifecircle_mobile/src/features/device_trust/domain/trust_evidence.dart';

abstract class SyncApiClient {
  Future<SyncDecision> pushEnvelope(SyncEnvelope envelope);
}

class OutboxWorker {
  const OutboxWorker({
    required this.outboxRepository,
    required this.envelopeBuilder,
    required this.apiClient,
  });

  final OutboxRepository outboxRepository;
  final SyncEnvelopeBuilder envelopeBuilder;
  final SyncApiClient apiClient;

  static const int maxBatchSize = 100;
  static const Duration stuckTimeout = Duration(minutes: 5);

  /// Triggers a synchronization cycle for outbound data
  Future<void> runPushCycle({
    required RequestContext requestContext,
    required TrustEvidence trustEvidence,
  }) async {
    // 1. Recover any operations that crashed mid-flight previously
    await outboxRepository.recoverStuckOperations(stuckTimeout);

    // 2. Fetch Pending
    final operations = await outboxRepository.getPendingBatch(maxBatchSize);
    if (operations.isEmpty) return;

    // 3. Lock as In-Flight
    final opIds = operations.map((op) => op.operationId).toList();
    await outboxRepository.markInFlight(opIds);

    try {
      // 4. Build Cryptographic Envelope
      final maxSequence = operations.map((op) => op.sequenceNumber).reduce(max);
      final envelope = await envelopeBuilder.buildEnvelope(
        requestContext: requestContext,
        trustEvidence: trustEvidence,
        operations: operations,
        maxSequenceNumber: maxSequence,
      );

      // 5. Transmit
      final decision = await apiClient.pushEnvelope(envelope);

      // 6. Handle Server Response
      if (decision.result == SyncDecisionResult.acknowledge) {
        // Append-only archival
        await outboxRepository.acknowledge(opIds);
      } else if (decision.result == SyncDecisionResult.conflict) {
        // SEC-006D conflict engine logic would intercept here
        // For now, mark failed to defer
        for (var id in opIds) {
          await _scheduleRetry(id, 'Conflict Detected');
        }
      } else {
        for (var id in opIds) {
          await _scheduleRetry(id, 'Server Rejected');
        }
      }
    } catch (e) {
      // Network failures, crypto failures, etc.
      for (var id in opIds) {
        await _scheduleRetry(id, e.toString());
      }
    }
  }

  Future<void> _scheduleRetry(String operationId, String reason) async {
    // Exponential backoff logic would compute nextRetryAt based on current retryCount
    // Defaulting to 1 minute for stub
    final nextRetry = DateTime.now().toUtc().add(const Duration(minutes: 1));
    await outboxRepository.handleFailure(operationId, reason, nextRetry);
  }
}
