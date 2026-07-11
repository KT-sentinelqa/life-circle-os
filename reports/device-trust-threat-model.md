# SEC-003: Device Trust Threat Model

**Status:** Locked
**Scope:** Device Trust Domain
**Date:** 2026-07-11

This document defines the canonical threat model for the LifeCircle OS mobile application. It outlines the attack vectors the Device Trust subsystem must evaluate and the corresponding mitigations expected from the `RiskEngine`.

---

## 1. Local Device Compromise

### Rooted / Jailbroken Devices
- **Threat:** An attacker gains administrative access to the OS, allowing them to bypass sandboxing, read secure storage, and extract cryptographic keys or cached medical data.
- **Mitigation:** The `RiskEngine` consumes OS-level jailbreak detection signals. If detected, `DeviceTrustLevel` drops to `Blocked`.

### Emulator Detection
- **Threat:** The application is run in an emulator for automated scraping or reverse engineering.
- **Mitigation:** The `RiskEngine` evaluates hardware characteristics. Emulators are assigned a `Restricted` or `Blocked` trust level depending on the context.

### Tampered Binaries / Hooking (e.g., Frida)
- **Threat:** Attackers modify the application binary or attach dynamic instrumentation frameworks to bypass authorization checks or extract secrets in memory.
- **Mitigation:** Future implementation of iOS App Attest and Android Play Integrity API. `RiskEngine` will lower trust to `Blocked` if integrity fails.

### Debugger Attachment
- **Threat:** An attacker attaches a debugger to inspect memory or manipulate execution flows.
- **Mitigation:** Anti-debugging checks feed into the `RiskEngine`. Presence of a debugger forces a `Restricted` state, blocking access to sensitive Financial or Medical endpoints.

---

## 2. Session and Authentication Threats

### Session Hijacking / Token Theft
- **Threat:** A valid session token is extracted and used on an untrusted device.
- **Mitigation:** Tokens must be cryptographically bound to the hardware via mutual TLS (mTLS) or payload signing. If a token is presented without the corresponding hardware signature from the `DeviceCryptoService`, it is rejected.

### Replay Attacks
- **Threat:** An attacker intercepts a valid, signed payload and replays it to mutate state or access data.
- **Mitigation:** `DeviceCryptoService` includes strict, monotonic logical timestamps and unique event IDs in every signed payload.

### Device Cloning
- **Threat:** A full device backup is restored to a different physical device, transferring the secure storage.
- **Mitigation:** Hardware-backed keys stored in the Android Keystore / iOS Secure Enclave are non-exportable. A cloned device will fail to produce valid cryptographic signatures.

### Secure Storage Failures
- **Threat:** The Secure Storage subsystem fails or is wiped by the OS, leaving the app in an indeterminate state.
- **Mitigation:** `RiskEngine` evaluates key presence. If keys are missing but a session exists, the state drops to `Unknown` and re-authentication is forced.

---

## 3. Trust Levels Matrix
The `RiskEngine` computes a dynamic confidence score mapped to the following states:

| Trust Level | Definition | Risk Score Range | Capability |
|---|---|---|---|
| **Verified** | Hardware backed, biometric verified, pristine OS. | 90-100 | Full access |
| **Trusted** | Hardware backed, OS intact, biometric pending. | 70-89 | Normal operations |
| **Limited** | Anomalous behavior or old session. | 40-69 | Read-only |
| **Restricted** | Unverified attestation or debugger present. | 10-39 | Emergency Break-Glass only |
| **Blocked** | Rooted, hooked, or known compromised. | 0-9 | Forced Logout |
| **Unknown** | Fresh install or storage failure. | N/A | Requires Re-authentication |
