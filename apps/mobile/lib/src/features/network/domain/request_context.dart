import 'package:flutter/foundation.dart';

/// An immutable envelope canonicalizing an API request payload.
@immutable
class RequestContext {
  const RequestContext({
    required this.requestId,
    required this.sessionId,
    required this.deviceId,
    required this.familyId,
    required this.nonce,
    required this.timestamp,
    required this.trustLevel,
    required this.keyId,
    required this.attestationId,
    required this.schemaVersion,
    required this.apiVersion,
    required this.traceId,
    required this.correlationId,
  });

  final String requestId;
  final String sessionId;
  final String deviceId;
  final String familyId;
  final String nonce;
  final DateTime timestamp;
  final String trustLevel;
  final String keyId;
  final String attestationId;
  final String schemaVersion;
  final String apiVersion;
  final String traceId;
  final String correlationId;

  Map<String, String> toHeaders() {
    return {
      'X-Request-Id': requestId,
      'X-Session-Id': sessionId,
      'X-Device-Id': deviceId,
      'X-Family-Id': familyId,
      'X-Nonce': nonce,
      'X-Timestamp': timestamp.toIso8601String(),
      'X-Trust-Level': trustLevel,
      'X-Key-Id': keyId,
      'X-Attestation-Id': attestationId,
      'X-Schema-Version': schemaVersion,
      'X-Api-Version': apiVersion,
      'X-Trace-Id': traceId,
      'X-Correlation-Id': correlationId,
    };
  }
}
