enum DeviceTrustLevel {
  verified,
  trusted,
  limited,
  restricted,
  blocked,
  unknown,
}

enum BiometricState {
  none,
  enrolled,
  verified,
  lockedOut,
  permanentlyLockedOut,
}

enum DeviceRiskLevel {
  low,
  medium,
  high,
  critical,
}

enum AppAttestationState {
  unverified,
  verified,
  failed,
  unsupported,
}

class DeviceTrustResult {
  const DeviceTrustResult({
    required this.trustLevel,
    required this.riskLevel,
    required this.biometricState,
    required this.attestationState,
    required this.hasSecureHardware,
    required this.isSessionExpired,
    required this.requiresReAuthentication,
    required this.confidenceScore,
    required this.lastVerificationUtc,
    required this.evaluationTimestamp,
    required this.signalVersion,
    required this.trustVersion,
    required this.evidenceIds,
    required this.evaluationDuration,
    required this.policyVersion,
  });

  final DeviceTrustLevel trustLevel;
  final DeviceRiskLevel riskLevel;
  final BiometricState biometricState;
  final AppAttestationState attestationState;
  final bool hasSecureHardware;
  final bool isSessionExpired;
  final bool requiresReAuthentication;
  final int confidenceScore; // 0 - 100
  final DateTime lastVerificationUtc;
  final DateTime evaluationTimestamp;
  final String signalVersion;
  final String trustVersion;
  final List<String> evidenceIds;
  final Duration evaluationDuration;
  final String policyVersion;

  @override
  String toString() {
    return 'DeviceTrustResult(level: $trustLevel, score: $confidenceScore, risk: $riskLevel)';
  }
}
