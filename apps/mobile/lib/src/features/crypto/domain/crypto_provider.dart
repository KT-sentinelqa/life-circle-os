import 'dart:typed_data';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_capabilities.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_identifier.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_metadata.dart';

enum KeyOperation {
  encrypt,
  decrypt,
  sign,
  verify,
}

abstract class CryptoProvider {
  /// Generates a new cryptographic key within the provider's enclave.
  Future<KeyMetadata> generateKey(KeyIdentifier identifier, KeyCapabilities capabilities, String ownerId);

  /// Retrieves the metadata associated with a key.
  Future<KeyMetadata> getKeyMetadata(KeyIdentifier identifier);

  /// Retrieves the raw key material for an operation.
  /// Note: In Hardware Keystores, this may not return material, but instead handle the operation internally.
  /// For SEC-004B, we return the material to the Software layer.
  Future<Uint8List> getKeyMaterial(KeyIdentifier identifier);

  /// Transitions the state of a key (e.g. from Active to Deprecated or Destroyed).
  Future<void> updateKeyMetadata(KeyMetadata metadata);

  /// Destroys the key material cryptographically.
  Future<void> destroyKey(KeyIdentifier identifier);
}

// Exceptions
class PlatformKeystoreUnavailableException implements Exception {}
class HardwareKeystoreRequiredException implements Exception {}
class BiometricInvalidatedException implements Exception {}
class CorruptedKeyMetadataException implements Exception {}
class KeyNotFoundException implements Exception {}
class KeyLifecycleException implements Exception {
  KeyLifecycleException(this.message);
  final String message;
}
