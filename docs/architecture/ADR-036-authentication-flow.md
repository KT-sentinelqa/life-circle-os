# ADR-036: Authentication Flow

**Date:** 2026-07-10  
**Status:** Accepted  

## Context
We need to define the user experience and technical state machine for the Authentication sequence. Because LifeCircle OS targets non-technical users (elders, busy parents), the flow must be entirely frictionless while maintaining high security.

## Decision
1. **Primary Authentication (Passkeys):** 
   - We will implement WebAuthn/Passkeys as the primary authentication mechanism.
   - Fallback: Email Magic Link / OTP. Passwords are explicitly banned to prevent credential stuffing and reduce user cognitive load.
2. **Local Biometric Unlock:** 
   - Once authenticated with the cloud, the user's session is locked locally by default upon app backgrounding.
   - Returning to the app requires Biometric Unlock (FaceID/TouchID). This ensures the device itself is secure, not just the cloud connection.
3. **State Machine:**
   - `Unauthenticated` -> `Authenticating (Passkey)` -> `Registering Device (ADR-035)` -> `Authenticated`
   - `Authenticated (Backgrounded)` -> `Locked`
   - `Locked` -> `Biometric Prompt` -> `Authenticated`
   - `Authenticated` -> `Logout` -> `Unauthenticated (Wipe Isar)`

## Consequences
- Requires implementing `local_auth` package in Flutter.
- Passkey implementation requires robust backend support (FIDO2 server endpoints).
