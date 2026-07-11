# ADR-034: Session Lifecycle

**Date:** 2026-07-10  
**Status:** Accepted  

## Context
LifeCircle OS handles extremely sensitive household data (health, finance, legal). Traditional long-lived mobile sessions (e.g., permanent JWTs) pose a significant risk in the event of device theft or account compromise. We must define a robust, enterprise-grade session lifecycle that balances the offline-first requirement with strict security boundaries.

## Decision

1. **Short-Lived Access Tokens (JWT):** Access tokens will expire every 15 minutes.
2. **Long-Lived Refresh Tokens (Opaque):** Refresh tokens will be opaque (non-JWT) strings, valid for 30 days, securely stored in the device's hardware-backed Keystore/Keychain.
3. **Offline-First Caveat:** Because the app is offline-first, local Isar data remains accessible via Biometric Unlock even if the Access Token has expired and network is unavailable to refresh. The access token only guards Cloud Sync Operations.
4. **Absolute Logout:**
    * **Local:** Clears Isar DB completely, destroys cryptographic keys in Keystore, removes all preferences.
    * **Remote:** Calls backend to revoke the specific Refresh Token family.

## Consequences
* **Positive:** Reduced blast radius of compromised tokens. Strict boundaries for sync operations.
* **Negative:** Increased complexity in network layer (automatic token refresh interceptors required).
* **Mitigation:** We will build a robust `Dio` interceptor in the Flutter client to handle `401 Unauthorized` by automatically queuing requests, refreshing the token, and replaying the requests.
