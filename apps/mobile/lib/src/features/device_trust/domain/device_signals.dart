import 'package:lifecircle_mobile/src/features/device_trust/domain/device_trust.dart';

/// The raw signals extracted from the OS, hardware, and runtime.
class DeviceSignals {
  const DeviceSignals({
    required this.isRootedOrJailbroken,
    required this.isEmulator,
    required this.isHooked,
    required this.isDebugged,
    required this.hasHardwareKeys,
    required this.biometricState,
    required this.attestationState,
    required this.sessionAge,
  });

  final bool isRootedOrJailbroken;
  final bool isEmulator;
  final bool isHooked;
  final bool isDebugged;
  final bool hasHardwareKeys;
  final BiometricState biometricState;
  final AppAttestationState attestationState;
  final Duration sessionAge;
}
