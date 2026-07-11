# Cryptographic Policy

**Status:** Locked
**Version:** 1.0

This policy defines the authoritative cryptographic standards for LifeCircle OS. It exists to prevent future engineers from introducing weak, inconsistent, or deprecated cryptographic choices into the platform.

## 1. Approved Algorithms
Only the following algorithms are permitted for new development:

| Operation | Approved Algorithms | Minimum Key Size |
|---|---|---|
| **Data At Rest (Symmetric)** | AES-GCM | 256-bit |
| **Digital Signatures (Asymmetric)** | Ed25519, ECDSA (P-256) | 256-bit |
| **Key Agreement / Derivation** | X25519, ECDH (P-256) | 256-bit |
| **Password Hashing** | Argon2id | 128-bit salt, 32-byte hash, m=65536, t=3, p=4 |
| **Cryptographic Hashing** | SHA-256, SHA-384, SHA-512 | 256-bit |

## 2. Prohibited Algorithms
The following algorithms are strictly prohibited and will fail CI/CD gating:
- **Symmetric:** DES, 3DES, RC4, AES-CBC (due to padding oracle vulnerabilities), AES-ECB.
- **Asymmetric:** RSA (unless strictly required by legacy integrations, minimum 2048-bit), DSA.
- **Hashing:** MD5, SHA-1.
- **KDF:** PBKDF2, scrypt, bcrypt (Argon2id is the sole allowed KDF).

## 3. Rotation Rules
- **Session Keys:** Rotated automatically every 30 days.
- **Domain KEKs:** Rotated annually or upon suspected compromise.
- **Data Encryption Keys (DEKs):** Rotated only when the underlying data is mutated.

## 4. Randomness Requirements
All Initialization Vectors (IVs), Nonces, Salts, and symmetric key material MUST be generated using the OS-provided Cryptographically Secure Pseudorandom Number Generator (CSPRNG):
- `SecureRandom` (Android)
- `SecRandomCopyBytes` (iOS)
- **Prohibited:** `dart:math` `Random()` must never be used for security operations.

## 5. Deprecation Policy
Cryptographic standards evolve. 
- When an algorithm transitions to "Legacy" status by NIST, a migration plan must be drafted within 90 days.
- When an algorithm transitions to "Deprecated", its usage in LifeCircle OS is considered a `P0` vulnerability and must be eradicated.

## 6. AAD Enforcement
All Authenticated Encryption (AES-GCM) payloads **MUST** bind contextual metadata via Authenticated Additional Data (AAD). 
Failure to bind `userId`, `familyId`, and `deviceId` to a payload is considered a critical security bypass, as it allows ciphertext to be copied laterally across accounts.
