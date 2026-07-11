# Cryptographic Test Matrix

**Status:** Planned for SEC-004A
**Version:** 1.0

This matrix defines the mandatory unit and integration tests that must pass before any cryptographic primitive is considered production-ready.

## 1. Encryption / Decryption Assertions
| Test ID | Scenario | Expected Result |
|---|---|---|
| CRYPTO-001 | Encrypt payload with AES-256-GCM and decrypt with same key and IV. | Decrypted payload exactly matches original. |
| CRYPTO-002 | Encrypt empty payload. | Succeeds, generates valid ciphertext and authentication tag. |
| CRYPTO-003 | Encrypt extremely large payload (e.g., 5MB). | Succeeds without memory exhaustion or truncation. |

## 2. Authenticated Additional Data (AAD) & Tampering
| Test ID | Scenario | Expected Result |
|---|---|---|
| CRYPTO-004 | Decrypt ciphertext using correct key, IV, and correct AAD. | Succeeds. |
| CRYPTO-005 | Decrypt ciphertext using correct key, IV, but *incorrect* AAD. | Fails (`AEADBadTagException` or equivalent). |
| CRYPTO-006 | Tamper with a single byte of the ciphertext, attempt decryption. | Fails (Authentication Tag mismatch). |
| CRYPTO-007 | Tamper with the Initialization Vector (IV), attempt decryption. | Fails (Authentication Tag mismatch). |

## 3. Key Lifecycle & Rotation
| Test ID | Scenario | Expected Result |
|---|---|---|
| CRYPTO-008 | Decrypt payload with an expired key (Deprecated State). | Succeeds (Reads allowed for legacy data). |
| CRYPTO-009 | Encrypt payload with an expired key (Deprecated State). | Fails (Writes strictly blocked). |
| CRYPTO-010 | Attempt to use a destroyed key. | Fails (KeyNotFoundException). |
| CRYPTO-011 | Rotate KEK: Ensure new EncryptedPayload uses updated `keyVersion`. | Succeeds, ciphertext metadata correctly reflects the new version. |
| CRYPTO-011B | Destroy KEK and attempt decryption. | Fails, proving destruction effectively zeroes out access. |

## 4. Digital Signatures & Nonces
| Test ID | Scenario | Expected Result |
|---|---|---|
| CRYPTO-012 | Sign payload and verify with matching public key. | Verification succeeds. |
| CRYPTO-013 | Verify signature with a different public key. | Verification fails. |
| CRYPTO-014 | Tamper with signed payload before verification. | Verification fails. |
| CRYPTO-015 | Generate 100,000 nonces. | Ensure absolute uniqueness and cryptographic randomness (no collisions). |

## 5. Versioning & Migration
| Test ID | Scenario | Expected Result |
|---|---|---|
| CRYPTO-016 | Encrypted payload generates valid JSON wrapper containing `algorithm`, `keyVersion`, `keyId`, `createdAt`, `aadVersion`. | Metadata is correctly serialized alongside base64 ciphertext. |
| CRYPTO-017 | Attempt decryption of an unsupported `algorithm` version. | Fails (UnsupportedAlgorithmException). |
| CRYPTO-018 | Backward Compatibility: Decrypt a v1 payload using a v2 configured Provider. | Succeeds, provided the v1 key is still in a Valid or Deprecated state. |
| CRYPTO-019 | Wrong Version: Attempt to force decryption with `keyVersion: "99"` when only `"1"` exists. | Fails (KeyNotFoundException). |
| CRYPTO-020 | Migration Trigger: Attempt to decrypt a payload flagged for migration. | Succeeds, but triggers an event to re-encrypt and persist via the current active KEK. |

## 6. Platform Failure Tests
| Test ID | Scenario | Expected Result |
|---|---|---|
| CRYPTO-021 | Attempt to generate key when OS Keychain / Keystore is unavailable. | Fails (PlatformKeystoreUnavailableException). |
| CRYPTO-022 | Request hardware-backed key on device that does not support it (e.g. no Secure Enclave/StrongBox). | Fails gracefully, falls back to software-backed if policy permits, else throws HardwareKeystoreRequiredException. |
| CRYPTO-023 | Biometric enrollment changed (user adds new fingerprint). | OS invalidates key. `KeyManager.getKey` throws BiometricInvalidatedException, forcing re-auth. |
| CRYPTO-024 | Secure Enclave / Keystore reset by OS. | `KeyManager` detects missing key, throws KeyNotFoundException, forces recovery. |
| CRYPTO-025 | Key metadata (capabilities, version, purpose) is corrupted in persistent storage. | Throws CorruptedKeyMetadataException, key is marked Destroyed to prevent unsafe usage. |
