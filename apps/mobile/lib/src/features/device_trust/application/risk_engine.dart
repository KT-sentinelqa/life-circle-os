import 'package:lifecircle_mobile/src/features/device_trust/domain/device_signals.dart';
import 'package:lifecircle_mobile/src/features/device_trust/domain/device_trust.dart';

/// Evaluates raw device signals against the Threat Model to compute a [DeviceTrustResult].
class RiskEngine {
  const RiskEngine();

  DeviceTrustResult evaluate(DeviceSignals signals) {
    // 1. Critical Threats (Score 0, Blocked)
    if (signals.isRootedOrJailbroken || signals.isHooked) {
      return DeviceTrustResult(
        trustLevel: DeviceTrustLevel.blocked,
        riskLevel: DeviceRiskLevel.critical,
        biometricState: signals.biometricState,
        attestationState: signals.attestationState,
        hasSecureHardware: signals.hasHardwareKeys,
        isSessionExpired: true,
        requiresReAuthentication: true,
        confidenceScore: 0,
        lastVerificationUtc: DateTime.now().toUtc(),
        evaluationTimestamp: DateTime.now().toUtc(),
        signalVersion: '1.0',
        trustVersion: '1.0',
        evidenceIds: [],
        evaluationDuration: const Duration(milliseconds: 1),
        policyVersion: '1.0',
      );
    }

    // 2. High Threats (Score 10-30, Restricted)
    if (signals.isDebugged || signals.isEmulator || signals.attestationState == AppAttestationState.failed) {
      return DeviceTrustResult(
        trustLevel: DeviceTrustLevel.restricted,
        riskLevel: DeviceRiskLevel.high,
        biometricState: signals.biometricState,
        attestationState: signals.attestationState,
        hasSecureHardware: signals.hasHardwareKeys,
        isSessionExpired: false,
        requiresReAuthentication: true,
        confidenceScore: 20, // Arbitrary baseline for restricted
        lastVerificationUtc: DateTime.now().toUtc(),
        evaluationTimestamp: DateTime.now().toUtc(),
        signalVersion: '1.0',
        trustVersion: '1.0',
        evidenceIds: [],
        evaluationDuration: const Duration(milliseconds: 1),
        policyVersion: '1.0',
      );
    }

    // 3. Hardware Failures (Unknown)
    if (!signals.hasHardwareKeys) {
      return DeviceTrustResult(
        trustLevel: DeviceTrustLevel.unknown,
        riskLevel: DeviceRiskLevel.medium,
        biometricState: signals.biometricState,
        attestationState: signals.attestationState,
        hasSecureHardware: false,
        isSessionExpired: true,
        requiresReAuthentication: true,
        confidenceScore: 0,
        lastVerificationUtc: DateTime.now().toUtc(),
        evaluationTimestamp: DateTime.now().toUtc(),
        signalVersion: '1.0',
        trustVersion: '1.0',
        evidenceIds: [],
        evaluationDuration: const Duration(milliseconds: 1),
        policyVersion: '1.0',
      );
    }

    // 4. Time-bound Threats (Score 40-69, Limited)
    if (signals.sessionAge.inHours >= 24) {
      return DeviceTrustResult(
        trustLevel: DeviceTrustLevel.limited,
        riskLevel: DeviceRiskLevel.medium,
        biometricState: signals.biometricState,
        attestationState: signals.attestationState,
        hasSecureHardware: signals.hasHardwareKeys,
        isSessionExpired: true,
        requiresReAuthentication: true,
        confidenceScore: 60,
        lastVerificationUtc: DateTime.now().toUtc(),
        evaluationTimestamp: DateTime.now().toUtc(),
        signalVersion: '1.0',
        trustVersion: '1.0',
        evidenceIds: [],
        evaluationDuration: const Duration(milliseconds: 1),
        policyVersion: '1.0',
      );
    }

    // 5. Trusted (Score 70-89)
    if (signals.biometricState != BiometricState.verified) {
      return DeviceTrustResult(
        trustLevel: DeviceTrustLevel.trusted,
        riskLevel: DeviceRiskLevel.low,
        biometricState: signals.biometricState,
        attestationState: signals.attestationState,
        hasSecureHardware: signals.hasHardwareKeys,
        isSessionExpired: false,
        requiresReAuthentication: false,
        confidenceScore: 80,
        lastVerificationUtc: DateTime.now().toUtc(),
        evaluationTimestamp: DateTime.now().toUtc(),
        signalVersion: '1.0',
        trustVersion: '1.0',
        evidenceIds: [],
        evaluationDuration: const Duration(milliseconds: 1),
        policyVersion: '1.0',
      );
    }

    // 6. Verified (Score 90-100)
    return DeviceTrustResult(
      trustLevel: DeviceTrustLevel.verified,
      riskLevel: DeviceRiskLevel.low,
      biometricState: signals.biometricState,
      attestationState: signals.attestationState,
      hasSecureHardware: signals.hasHardwareKeys,
      isSessionExpired: false,
      requiresReAuthentication: false,
      confidenceScore: 100,
      lastVerificationUtc: DateTime.now().toUtc(),
      evaluationTimestamp: DateTime.now().toUtc(),
      signalVersion: '1.0',
      trustVersion: '1.0',
      evidenceIds: [],
      evaluationDuration: const Duration(milliseconds: 1),
      policyVersion: '1.0',
    );
  }
}
