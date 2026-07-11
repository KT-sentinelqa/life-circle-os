import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_domain.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_operation.dart';
import 'package:lifecircle_mobile/src/features/crypto/application/encryption_service.dart';
import 'package:lifecircle_mobile/src/features/network/application/signing_service.dart';
import 'package:lifecircle_mobile/src/features/network/domain/request_context.dart';
import 'package:lifecircle_mobile/src/features/device_trust/domain/trust_evidence.dart';

class SyncEnvelopeBuilder {
  const SyncEnvelopeBuilder({
    required this.encryptionService,
    required this.signingService,
  });

  final EncryptionService encryptionService;
  final SigningService signingService;

  /// Bundles operations into a single encrypted and signed envelope
  Future<SyncEnvelope> buildEnvelope({
    required RequestContext requestContext,
    required TrustEvidence trustEvidence,
    required List<SyncOperation> operations,
    required int maxSequenceNumber,
  }) async {
    final batchId = const Uuid().v4();
    final envelopeId = const Uuid().v4();

    // 1. Serialize the batch payload
    final batchPayload = operations.map((op) => {
      'operationId': op.operationId,
      'entityId': op.entityId,
      'entityType': op.entityType,
      'mutationType': op.mutationType.name,
      'payload': op.payload,
      'timestamp': op.timestamp.toIso8601String(),
      'sequenceNumber': op.sequenceNumber,
    }).toList();
    
    final jsonString = jsonEncode(batchPayload);

    // 2. Encrypt the payload (SEC-004)
    final encryptedResult = await encryptionService.encrypt(
      payload: utf8.encode(jsonString),
      metadata: EncryptionMetadata(
        schemaVersion: '1.0',
        recordType: 'SyncBatch',
        deviceId: requestContext.deviceId,
        familyId: requestContext.familyId,
        userId: requestContext.sessionId, // Bind to session
      ),
    );
    final base64Ciphertext = base64Encode(encryptedResult.ciphertext);

    // 3. Sign the canonical request (SEC-004D equivalent)
    final signature = await signingService.signCanonicalRequest(
      method: 'POST',
      uri: '/api/v1/sync/push',
      query: '',
      keyId: requestContext.keyId,
      nonce: requestContext.nonce,
      timestamp: requestContext.timestamp.toIso8601String(),
      requestId: requestContext.requestId,
      canonicalJsonBody: signingService.canonicalizeJson('{"encryptedPayload":"$base64Ciphertext"}'),
    );

    // 4. Construct the Envelope
    return SyncEnvelope(
      envelopeId: envelopeId,
      batchId: batchId,
      deviceId: requestContext.deviceId,
      familyId: requestContext.familyId,
      sessionId: requestContext.sessionId,
      keyId: requestContext.keyId,
      trustEvidenceId: trustEvidence.deviceId, // Derived trust link
      sequenceNumber: maxSequenceNumber,
      schemaVersion: '1.0',
      encryptedPayload: base64Ciphertext,
      signature: signature,
    );
  }
}
