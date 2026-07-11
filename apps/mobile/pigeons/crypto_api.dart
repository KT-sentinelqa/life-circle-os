import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/features/crypto/infrastructure/pigeon/crypto_api.g.dart',
  swiftOut: 'ios/Runner/CryptoApi.g.swift',
  kotlinOut: 'android/app/src/main/kotlin/com/lifecircle/mobile/CryptoApi.g.kt',
  kotlinOptions: KotlinOptions(
    package: 'com.lifecircle.mobile',
  ),
))

class PigeonCryptoCapabilities {
  PigeonCryptoCapabilities({
    required this.supportsSecureEnclave,
    required this.supportsStrongBox,
    required this.supportsHardwareKeys,
    required this.supportsBiometrics,
    required this.supportsAttestation,
    required this.supportsKeyWrapping,
  });

  bool supportsSecureEnclave;
  bool supportsStrongBox;
  bool supportsHardwareKeys;
  bool supportsBiometrics;
  bool supportsAttestation;
  bool supportsKeyWrapping;
}

class PigeonKeyMetadata {
  PigeonKeyMetadata({
    required this.keyId,
    required this.isHardwareBacked,
    required this.algorithm,
  });

  String keyId;
  bool isHardwareBacked;
  String algorithm;
}

@HostApi()
abstract class NativeCryptoApi {
  /// Queries the OS for its physical cryptographic capabilities.
  PigeonCryptoCapabilities getCapabilities();

  /// Generates a key in the native Keystore/Keychain/Enclave.
  PigeonKeyMetadata generateKey(String keyId, bool requireHardware, bool requireBiometrics);

  /// Cryptographically destroys the key material in the enclave/keystore.
  void destroyKey(String keyId);

  /// Uses the native hardware to sign a payload (private key never leaves hardware).
  Uint8List signPayload(String keyId, Uint8List payload);

  /// Unwraps a Domain KEK using the hardware-backed Root Platform Key.
  Uint8List unwrapKey(String keyId, Uint8List wrappedKey);

  /// Requests a cryptographic attestation object from the OS using the Server Nonce.
  Uint8List requestAttestation(String keyId, Uint8List challenge);
}
