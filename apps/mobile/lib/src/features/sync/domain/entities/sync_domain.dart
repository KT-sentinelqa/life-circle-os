import 'package:flutter/foundation.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_operation.dart';

@immutable
class SyncBatch {
  const SyncBatch({
    required this.batchId,
    required this.operations,
  });

  final String batchId;
  final List<SyncOperation> operations;
}

@immutable
class SyncEnvelope {
  const SyncEnvelope({
    required this.envelopeId,
    required this.batchId,
    required this.deviceId,
    required this.familyId,
    required this.sessionId,
    required this.keyId,
    required this.trustEvidenceId,
    required this.sequenceNumber,
    required this.schemaVersion,
    required this.encryptedPayload,
    required this.signature,
  });

  final String envelopeId;
  final String batchId;
  final String deviceId;
  final String familyId;
  final String sessionId;
  final String keyId;
  final String trustEvidenceId;
  final int sequenceNumber;
  final String schemaVersion;
  final String encryptedPayload; // Base64 Ciphertext
  final String signature;        // Base64 Ed25519
}

enum SyncOperationResult {
  acknowledge,
  reject,
  conflict,
  duplicate,
  retry,
}

@immutable
class SyncBatchResponse {
  const SyncBatchResponse({
    required this.batchId,
    required this.results,
  });

  final String batchId;
  final Map<String, SyncOperationResult> results; // operationId -> result
}

@immutable
class SyncCheckpoint {
  const SyncCheckpoint({
    required this.localCheckpoint,
    required this.remoteCheckpoint,
    required this.lastSuccessfulSync,
    required this.lastAcknowledgedSequence,
  });

  final String localCheckpoint;
  final String remoteCheckpoint;
  final DateTime lastSuccessfulSync;
  final int lastAcknowledgedSequence;
}
