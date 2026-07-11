/// Interface for accessing OS-level secure keystore and enclave.
/// Android: Android Keystore
/// iOS: Secure Enclave
abstract class KeystoreService {
  /// Generates a new hardware-backed cryptographic keypair.
  Future<void> generateKeyPair();

  /// Checks if a valid keypair exists in the keystore.
  Future<bool> hasValidKeyPair();

  /// Signs the given [payload] using the private key stored in the enclave.
  Future<String> signPayload(String payload);

  /// Retrieves the public key for server registration.
  Future<String> getPublicKey();

  /// Deletes the keypair from the secure enclave.
  Future<void> destroyKeys();
}
