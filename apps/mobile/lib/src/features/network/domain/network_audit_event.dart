class NetworkAuditEvent {
  const NetworkAuditEvent({
    required this.requestId,
    required this.traceId,
    required this.endpoint,
    required this.latencyMs,
    required this.tlsVersion,
    required this.cipherSuite,
    required this.pinValidationSuccess,
    required this.trustLevel,
    required this.attestationLevel,
    required this.retryCount,
    required this.serverRegion,
    required this.httpStatus,
    required this.signatureVerificationSuccess,
  });

  final String requestId;
  final String traceId;
  final String endpoint;
  final int latencyMs;
  final String tlsVersion;
  final String cipherSuite;
  final bool pinValidationSuccess;
  final String trustLevel;
  final String attestationLevel;
  final int retryCount;
  final String serverRegion;
  final int httpStatus;
  final bool signatureVerificationSuccess;
}
