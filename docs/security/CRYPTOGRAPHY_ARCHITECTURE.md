# Cryptography Architecture

**Status:** Proposed
**Version:** 1.0

This document defines the overarching cryptographic architecture for LifeCircle OS. It establishes the foundations for key operations, data protection, and platform-level guarantees.

## 1. Trust Boundaries
LifeCircle OS operates under a Zero-Trust local model:
- **Client (Mobile App):** Untrusted by default until Device Trust attestation succeeds. Responsible for local at-rest encryption and mutual TLS (mTLS) to the backend.
- **Backend Services:** Trusted, but assumes clients are hostile. Validates all attestations, assertions, and signatures before granting data access.
- **Local Storage (SQLite/Hive):** Assumed to be physically compromised in the event of device theft. All PII and Medical Data must be encrypted before writing.

## 2. Algorithm Standardization
We strictly adhere to the following cryptographic primitives to guarantee modern security margins:

| Purpose | Algorithm | Rationale |
|---|---|---|
| **Data At Rest** | AES-256-GCM | Authenticated encryption prevents tampering. |
| **Key Agreement** | X25519 (or P-256) | Forward secrecy for session derivations. |
| **Digital Signatures** | Ed25519 (or ECDSA P-256) | High performance, deterministic, resistant to side-channels. Required for Sync payloads. |
| **Key Derivation** | Argon2id | Memory-hard derivation for user-supplied secrets (if any). |
| **Randomness** | Platform CSPRNG | `SecureRandom` on Android, `SecRandomCopyBytes` on iOS. |
| **Transport** | TLS 1.3 | Enforced with Certificate Pinning. |

## 3. Cryptographic Operations

### 3.1 Data Encryption
All local domain entities containing PII (Medical Logs, Finance, Auth Tokens) will be serialized to JSON, encrypted using AES-256-GCM via a Data Encryption Key (DEK), and then persisted. 
The Initialization Vector (IV/Nonce) is uniquely generated per record via CSPRNG.

### 3.2 Authenticated Additional Data (AAD)
AAD is a first-class design element. To prevent encrypted blobs from being copied into another family or account without detection, the following context must be authenticated alongside the ciphertext:
- `familyId`
- `userId`
- `deviceId`
- `schemaVersion`
- `recordType`

### 3.3 Versioned Metadata Payload
Every encrypted object must contain the following metadata to ensure deterministic rotation and migration:
- `algorithm`
- `keyVersion`
- `keyId`
- `createdAt`
- `rotationVersion`
- `aadVersion`

### 3.4 Digital Signatures (Secure Sync)
Every payload sent to the backend must be signed.
- A logical timestamp and unique Nonce are prepended to the JSON payload.
- The payload is signed using the hardware-backed Ed25519/P-256 private key.
- The backend verifies the signature using the registered public key, preventing Replay and MITM attacks.

### 3.3 Certificate Pinning
To prevent MITM attacks via compromised root CAs (or corporate proxies), the application will pin the Leaf or Intermediate certificates of the LifeCircle API. Any TLS handshake failing the pin will instantly sever the connection and drop the `DeviceTrustResult` confidence score.

## 4. Hardware Integrations
LifeCircle relies heavily on the **Android Keystore** and **iOS Secure Enclave** for asymmetric keys.
- Keys generated in these enclaves are marked as `non-exportable`.
- Biometric-bound keys require FaceID/TouchID invocation before the OS allows signing operations.
