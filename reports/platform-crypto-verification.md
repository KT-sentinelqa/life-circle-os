# SEC-004C Platform Crypto Verification

**Status:** Verified
**Date:** 2026-07-11

This document certifies the successful abstraction and integration of the native cryptographic boundaries.

## Verification Checklist

### 1. Capability Discovery
- [x] **Verified.** The `CryptoCapabilities` domain entity accurately queries the OS (via `CryptoPlugin.kt` and `CryptoPlugin.swift`) to resolve true availability of Secure Enclave, StrongBox, and Biometric configurations. It ensures we **never** blindly assume hardware exists.

### 2. Apple Secure Enclave & Keychain (SEC-004C.1)
- [x] **Secure Enclave Available:** Configured using `kSecAttrTokenIDSecureEnclave` inside iOS.
- [x] **Keychain Accessibility:** Appropriately bound `kSecAttrAccessibleWhenUnlockedThisDeviceOnly` for device-bound keys and `kSecAttrAccessibleWhenUnlocked` for migratable keys.
- [x] **Biometric Invalidations:** Handled via `SecAccessControlCreateWithFlags` leveraging `.biometryCurrentSet`.

### 3. Android Keystore & StrongBox (SEC-004C.2)
- [x] **Keystore Available:** Leverages `AndroidKeyStore`.
- [x] **StrongBox Fallback:** Safely delegates to TEE Keystore if `CryptoCapabilities.supportsStrongBox` returns `false`.
- [x] **Hardware-backed Detection:** Evaluates `pm.hasSystemFeature(PackageManager.FEATURE_HARDWARE_KEYSTORE)` prior to provisioning.

### 4. Type-Safe Integration
- [x] **Verified.** We have officially abandoned brittle `MethodChannel` raw strings. The `pigeons/crypto_api.dart` defines an immutable `NativeCryptoApi` contract that explicitly types `generateKey`, `destroyKey`, `signPayload`, and `unwrapKey`.

## Next Steps
The native enclaves are mapped. The final piece of SEC-004C is the backend Attestation checks (App Attest & Play Integrity) for SEC-004C.3.
