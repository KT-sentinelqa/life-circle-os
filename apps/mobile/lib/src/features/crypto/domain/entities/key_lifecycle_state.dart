enum KeyLifecycleState {
  /// Generated but not yet mapped or securely persisted.
  generated,

  /// Persisted securely but not yet the active wrapping key.
  provisioned,

  /// Actively used for all new encryption operations and available for decryption.
  active,

  /// In the process of being replaced by a new key.
  rotating,

  /// Retained only for decryption of legacy offline payloads. Blocked for new encryption.
  deprecated,

  /// Cryptographically erased from the enclave. Material is unrecoverable.
  destroyed,

  /// Material is gone, but metadata is retained for auditing purposes.
  archived,
}
