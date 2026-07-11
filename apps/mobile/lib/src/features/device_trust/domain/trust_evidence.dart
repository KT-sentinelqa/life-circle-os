enum AttestationStatus {
  unverified,
  hardwareVerified,
  softwareVerified,
  failed,
}

enum AssertionStatus {
  none,
  valid,
  invalid,
}

class TrustEvidence {
  const TrustEvidence({
    required this.deviceId,
    required this.deviceTrustLevel,
    required this.attestationStatus,
    required this.assertionStatus,
    required this.isHardwareBacked,
    required this.isSessionExpired,
    required this.requiresReAuthentication,
    required this.fraudSignals,
    required this.riskScore,
    required this.policyVersion,
    required this.evaluationTimestampUtc,
  });

  final String deviceId;
  final String deviceTrustLevel; 
  final AttestationStatus attestationStatus;
  final AssertionStatus assertionStatus;
  final bool isHardwareBacked;
  final bool isSessionExpired;
  final bool requiresReAuthentication;
  final List<String> fraudSignals;
  final double riskScore;
  final String policyVersion;
  final DateTime evaluationTimestampUtc;

  bool get isTrusted => 
    (attestationStatus == AttestationStatus.hardwareVerified || attestationStatus == AttestationStatus.softwareVerified) &&
    assertionStatus != AssertionStatus.invalid &&
    fraudSignals.isEmpty &&
    riskScore < 50.0;
}
