# Session Policy

**Status:** Proposed (SEC-005)

This document formalizes the overarching policies governing Session Management, Identity Continuity, and State Transitions within LifeCircle OS.

## 1. Timeout & Expiry Policy
- **Access Token:** 15 minutes.
- **Refresh Token:** 30 days (mutated on every use).
- **Absolute Session Maximum:** 90 days.
- **Max Refresh Chain:** 72 hours. Even with valid active usage, the user must undergo a complete authentication flow every 72 hours.
- **Idle Timeout:** 7 days of complete inactivity suspends the session.

## 2. Refresh Policy
Refreshes are NOT automatic. Every refresh attempt MUST:
1. Validate current `TrustEvidence`.
2. Pass the `PolicyEngine` validation.
3. Validate the `SessionBinding` hash against the Server's known hash.
4. Issue entirely new Access and Refresh tokens (Refresh Token Rotation).
5. If an old refresh token is reused, the entire session chain is immediately **Revoked**.

## 3. Step-Up Authentication Policy
Controlled entirely by the `PolicyEngine`. Step-up authentication (re-prompting Biometrics or PIN) is required when:
- **Operations:** Ownership transfer, Master Key rotation, Emergency Delegate creation, Recovery Code export, Payment changes.
- **Trigger:** The API request invokes an operation that demands a recent authentication timestamp or elevated trust limits.

## 4. Concurrency Policy
- **Maximum Active Devices:** 5.
- **Collision Resolution:** If a 6th device successfully authenticates, the system MUST **Revoke the oldest idle session**. It does NOT reject the new login.

## 5. Suspension & Revocation Policy
- **Suspension:** Triggered by Idle Timeouts, step-up requirements, or minor state mutations. Resumable via Biometric/PIN re-authentication.
- **Revocation:** Triggered by explicitly compromised trust (Fraud Signals, Revoked Attestation, Refresh Token Reuse). Irreversible. Requires full credential login.

## 6. Logout Policy
Logout is deterministic and cryptographic.
1. Local `destroyKey()` is called on all domain KEKs.
2. Local Access/Refresh tokens are zeroized in memory and Keychain/Keystore.
3. The Backend is notified to actively revoke the token chain.
4. State transitions to `Destroyed`.
