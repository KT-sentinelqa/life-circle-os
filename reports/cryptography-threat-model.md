# Cryptography Threat Model

**Status:** Proposed
**Version:** 1.0

This document outlines the threat vectors targeting the Cryptographic Infrastructure of LifeCircle OS, paired with their respective mitigations.

## 1. Physical / Local Device Threats

### 1.1 Stolen Device (At-Rest Extraction)
- **Threat:** An attacker steals the physical device and attempts to dump the NAND flash to read local SQLite databases.
- **Mitigation:** All data is encrypted with AES-256-GCM. The Master Key required to decrypt the Domain Keys resides in the non-exportable hardware enclave. It cannot be extracted via flash dumping.

### 1.2 Rooted / Jailbroken Device
- **Threat:** Malware on a rooted device attempts to hook memory or bypass OS sandboxing to read keys.
- **Mitigation:** The `RiskEngine` blocks rooted devices. Additionally, hardware-backed keys in the Secure Enclave operate out-of-process. The OS cannot extract the private key material, even as root. 

### 1.3 RAM Extraction (Cold Boot)
- **Threat:** An attacker freezes RAM to extract symmetric Domain Keys while the application is active.
- **Mitigation:** Domain Keys are wiped from memory immediately after use. Flutter/Dart garbage collection will be forced or `ffi` mechanisms used for critical key buffers if necessary.

### 1.4 Backup Restoration (Device Cloning)
- **Threat:** An attacker restores an iCloud/Google Drive backup to a new device.
- **Mitigation:** Hardware keys are strictly excluded from OS backups (`kSecAttrAccessibleWhenUnlockedThisDeviceOnly`). The new device will boot, realize the keys are missing, drop to `DeviceTrustLevel.unknown`, and force re-authentication.

---

## 2. Network / Transport Threats

### 2.1 MITM & Certificate Pinning Bypass
- **Threat:** A corporate proxy or malicious WiFi attempts to intercept TLS traffic using a trusted root CA.
- **Mitigation:** LifeCircle implements strict Certificate Pinning (Leaf/Intermediate). If the pin fails, the TLS handshake is aborted, and no payload is transmitted.

### 2.2 Replay Attacks
- **Threat:** An attacker captures a valid API request and resends it later to duplicate an action.
- **Mitigation:** All payloads are signed with Ed25519. The payload strictly includes a monotonic `logicalTimestamp` and a unique `eventId` nonce. The backend rejects duplicate nonces or stale timestamps.

### 2.3 Downgrade Attacks
- **Threat:** An attacker forces the client to use a weak encryption suite or older TLS version.
- **Mitigation:** The HTTP client is hardcoded to require TLS 1.3. Cryptographic algorithms (AES-256-GCM) are hardcoded and do not negotiate with the server.

---

## 3. Key Compromise Threats

### 3.1 Session Key Compromise
- **Threat:** The backend accidentally logs the symmetric session token, or an attacker steals it.
- **Mitigation:** A stolen token cannot sign Sync Payloads. The attacker would also need to steal the hardware-backed asymmetric private key, which is mathematically infeasible without physical device compromise.

### 3.2 Side-Channel Attacks
- **Threat:** An attacker measures power or timing variations during cryptographic operations.
- **Mitigation:** Ed25519 is specifically designed to be constant-time and immune to cache-timing attacks.

### 3.3 Backend Master Key Compromise
- **Threat:** The central cloud provider is breached.
- **Mitigation:** While LifeCircle is not currently end-to-end encrypted (E2EE) due to Caregiver emergency delegation requirements, the local Master Key architecture ensures that a backend breach does not compromise the offline device's local enclave storage.
