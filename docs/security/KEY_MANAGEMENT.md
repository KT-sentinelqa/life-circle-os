# Key Management Model

**Status:** Proposed
**Version:** 1.0

This document defines the key hierarchy, lifecycle, and ownership boundaries for all cryptographic material within the LifeCircle OS mobile client.

## 1. Key Hierarchy
We utilize an enveloped encryption model. A single key is never used for multiple boundaries, drastically reducing the blast radius of any individual key compromise.

```mermaid
graph TD
    RPK[Root Platform Key\n(Hardware Backed)] --> ID[Identity Domain KEK]
    RPK --> FD[Family Domain KEK]
    RPK --> OS[Offline Sync KEK]
    RPK --> SS[Secure Storage KEK]
    RPK --> AD[Audit Domain KEK]
    
    FD --> DEK[Data Encryption Keys\n(AES-256-GCM)]
    DEK --> ED[Encrypted Data]
    
    RPK --> SK[Session Signer Keys\n(Ed25519)]
```

### Root Platform Key (RPK)
- **Role:** The ultimate root of trust. Used strictly to encrypt Domain Key Encryption Keys (KEKs).
- **Storage:** Stored in the Secure Enclave / Android Keystore.
- **Access:** Requires Biometric Authentication (`DeviceTrustResult.biometricState == verified`).

### Domain KEKs (Key Encryption Keys)
- **Role:** Segregates data by bounded contexts (Identity, Family, Sync, Storage, Audit). If a specific domain KEK is rotated, only the DEKs for that domain need re-wrapping, not the entire database.
- **Storage:** Stored encrypted by the RPK in Flutter Secure Storage.

### Data Encryption Keys (DEK)
- **Role:** Unique symmetric keys (or derived keys) for individual rows or large blobs.
- **Storage:** Stored inline with the ciphertext, encrypted by the Domain Key.

### Session Signer Keys (SK)
- **Role:** Asymmetric private keys used to sign HTTP requests and Sync payloads.
- **Storage:** Hardware-backed, strictly non-exportable.

---

## 2. Key Lifecycle

Every key in LifeCircle OS transitions through the following strict states:

1. **Created:** CSPRNG generates the key material in the enclave.
2. **Activated:** The key is registered with the backend or used to wrap the first DEK.
3. **Rotated:** A new key is generated. The old key enters a "Deprecated" state where it can only be used for decryption, not encryption.
4. **Deprecated:** Active only for reading legacy records.
5. **Destroyed:** Cryptographically erased from the Secure Storage/Keystore.

## 3. Key Rotation & Destruction

### Rotation Policies
- **Session Signer Keys:** Rotated automatically every 30 days, or immediately upon `DeviceRiskLevel.high` detection.
- **Domain Keys:** Rotated annually, requiring background re-encryption of the domain's SQLite tables.

### Destruction Policies (Absolute Logout)
When a user explicitly logs out, or when a remote wipe command is received:
1. `destroyKeys()` is called on the Keystore interface.
2. Domain Keys are purged from `SecureStorage`.
3. The SQLite database file is physically deleted.
*Without the hardware-backed Master Key, the remaining ciphertext on the NAND flash is mathematically irretrievable.*

## 4. Key Recovery
If a device is lost or destroyed, the local Master Key is permanently lost.
- **Recovery Strategy:** LifeCircle relies on the Backend as the source of truth for encrypted sync. The user must provision a *new* device, authenticate via standard Multi-Factor mechanisms, establish a new Master Key locally, and synchronize the remote data downwards. Local-only encrypted drafts will be lost.
