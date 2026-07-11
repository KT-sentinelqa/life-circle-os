# SEC-004A: Cryptographic Primitives

**Status:** Completed
**Date:** 2026-07-11

## Architecture & Policy Refinements
Based on the refined requirements, the architecture was expanded:
- **`KEY_MANAGEMENT.md`**: Implemented the Root Platform Key -> Domain KEK hierarchy (`Identity`, `Family`, `Sync`, `Storage`, `Audit`), massively reducing the blast radius of domain compromise.
- **`CRYPTOGRAPHIC_POLICY.md`**: Locked down the permitted algorithms. Only AES-256-GCM, Ed25519/P-256, Argon2id, and SHA-2/3 families are allowed.
- **`CRYPTOGRAPHY_ARCHITECTURE.md`**: Introduced AAD and Versioning as mandatory payload constraints.

## Deliverables

### 1. Cryptographic Test Matrix
Produced **`reports/crypto-test-matrix.md`** defining all deterministic encryption, AAD, tampering, rotation, and signature checks.

### 2. Primitive Interfaces
- **`AadContext`**: Mandates `familyId`, `userId`, `deviceId`, `schemaVersion`, and `recordType` to be supplied for every payload to prevent lateral movement.
- **`EncryptedPayload`**: Contains `ciphertext`, `iv`, and a rigid `CryptoMetadata` object (`algorithm`, `keyVersion`, `keyId`, `createdAtUtc`, `rotationVersion`, `aadVersion`).
- **`KeyIdentifier`**: Tracks the deterministic ID and Version of the key used.

### 3. EncryptionService & TDD Suite
- **`EncryptionService`**: Wraps the `encrypt` package's `AESMode.gcm`. Handles secure IV and Nonce generation via CSPRNG.
- **`crypto_primitives_test.dart`**: Complete TDD suite containing:
  - `CRYPTO-001`: Perfect encryption/decryption cycle.
  - `CRYPTO-004/005`: Strict AAD enforcement (bad AAD yields MAC failure).
  - `CRYPTO-006/007`: Ciphertext and IV tampering detection (yields MAC failure).
  - `CRYPTO-015`: Nonce entropy verification.
  - `CRYPTO-016`: Metadata payload extraction.
