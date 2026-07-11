import 'package:lifecircle_mobile/src/features/device_trust/domain/device_trust.dart';

/// Interface for hardware-backed application attestation.
/// iOS: App Attest
/// Android: Play Integrity API
abstract class AppAttestationService {
  /// Generates a cryptographic attestation payload asserting the binary's integrity.
  Future<String> generateAttestationPayload(String nonce);

  /// Validates the device integrity locally (if supported by OS) or
  /// returns the cached result of a remote attestation verification.
  Future<AppAttestationState> getAttestationState();
}
