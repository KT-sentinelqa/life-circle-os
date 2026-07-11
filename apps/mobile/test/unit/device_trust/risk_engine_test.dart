import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/device_trust/application/risk_engine.dart';
import 'package:lifecircle_mobile/src/features/device_trust/domain/device_signals.dart';
import 'package:lifecircle_mobile/src/features/device_trust/domain/device_trust.dart';

void main() {
  group('Risk Engine SEC-003', () {
    late RiskEngine engine;

    setUp(() {
      engine = const RiskEngine();
    });

    DeviceSignals _buildSignals({
      bool isRootedOrJailbroken = false,
      bool isEmulator = false,
      bool isHooked = false,
      bool isDebugged = false,
      bool hasHardwareKeys = true,
      BiometricState biometricState = BiometricState.verified,
      AppAttestationState attestationState = AppAttestationState.verified,
      Duration sessionAge = const Duration(hours: 1),
    }) {
      return DeviceSignals(
        isRootedOrJailbroken: isRootedOrJailbroken,
        isEmulator: isEmulator,
        isHooked: isHooked,
        isDebugged: isDebugged,
        hasHardwareKeys: hasHardwareKeys,
        biometricState: biometricState,
        attestationState: attestationState,
        sessionAge: sessionAge,
      );
    }

    test('Rooted device drops score to 0 and becomes Blocked', () {
      final signals = _buildSignals(isRootedOrJailbroken: true);
      final result = engine.evaluate(signals);

      expect(result.trustLevel, DeviceTrustLevel.blocked);
      expect(result.riskLevel, DeviceRiskLevel.critical);
      expect(result.confidenceScore, 0);
      expect(result.requiresReAuthentication, isTrue);
    });

    test('Hooked binary drops score to 0 and becomes Blocked', () {
      final signals = _buildSignals(isHooked: true);
      final result = engine.evaluate(signals);

      expect(result.trustLevel, DeviceTrustLevel.blocked);
      expect(result.riskLevel, DeviceRiskLevel.critical);
      expect(result.confidenceScore, 0);
    });

    test('Debugger attached makes device Restricted', () {
      final signals = _buildSignals(isDebugged: true);
      final result = engine.evaluate(signals);

      expect(result.trustLevel, DeviceTrustLevel.restricted);
      expect(result.riskLevel, DeviceRiskLevel.high);
      expect(result.confidenceScore, lessThanOrEqualTo(30));
    });

    test('Missing hardware keys makes device Unknown / Requires Re-Auth', () {
      final signals = _buildSignals(hasHardwareKeys: false);
      final result = engine.evaluate(signals);

      expect(result.trustLevel, DeviceTrustLevel.unknown);
      expect(result.requiresReAuthentication, isTrue);
    });

    test('Perfect signals yields Verified and score 100', () {
      final signals = _buildSignals(
        hasHardwareKeys: true,
        biometricState: BiometricState.verified,
        attestationState: AppAttestationState.verified,
        sessionAge: const Duration(minutes: 5),
      );
      final result = engine.evaluate(signals);

      expect(result.trustLevel, DeviceTrustLevel.verified);
      expect(result.riskLevel, DeviceRiskLevel.low);
      expect(result.confidenceScore, greaterThanOrEqualTo(90));
      expect(result.requiresReAuthentication, isFalse);
    });

    test('Pending biometric yields Trusted but not Verified', () {
      final signals = _buildSignals(
        hasHardwareKeys: true,
        biometricState: BiometricState.enrolled, // Enrolled but not verified this session
        attestationState: AppAttestationState.verified,
      );
      final result = engine.evaluate(signals);

      expect(result.trustLevel, DeviceTrustLevel.trusted);
      expect(result.riskLevel, DeviceRiskLevel.low);
      expect(result.confidenceScore, greaterThanOrEqualTo(70));
    });

    test('Old session (24h+) makes device Limited', () {
      final signals = _buildSignals(
        sessionAge: const Duration(hours: 25),
        biometricState: BiometricState.none,
      );
      final result = engine.evaluate(signals);

      expect(result.trustLevel, DeviceTrustLevel.limited);
      expect(result.riskLevel, DeviceRiskLevel.medium);
      expect(result.requiresReAuthentication, isTrue);
    });

    test('Failed attestation makes device Restricted', () {
      final signals = _buildSignals(attestationState: AppAttestationState.failed);
      final result = engine.evaluate(signals);

      expect(result.trustLevel, DeviceTrustLevel.restricted);
      expect(result.riskLevel, DeviceRiskLevel.high);
    });
  });
}
