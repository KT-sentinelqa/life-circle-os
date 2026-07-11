# SEC-026: Authentication Policy

**Status:** Enforced | **Phase:** 6A

## Policy Rules

### 1. Brute-Force Protection
* **Rate Limiting:** Any given IP address is limited to 10 authentication attempts per 5 minutes.
* **Account Lockout:** After 5 consecutive failed authentication attempts for a specific account, the account is locked for 15 minutes. An email alert is sent to the primary address.

### 2. Multi-Factor Authentication (MFA)
* **Enforcement:** MFA is strongly encouraged for all users, but explicitly enforced for any account designated as a "Family Administrator."
* **Methods:** Passkeys act as inherent MFA (possession of device + biometric/PIN). If falling back to Email OTP, a secondary factor (Authenticator App / TOTP) must be registered.

### 3. Session Invalidation
* **Remote Wipe:** A user must be able to view all active sessions (registered devices) from the Family Settings screen and invalidate any of them.
* **Invalidation Action:** Invalidating a session instantly deletes the device's public key from the cloud, rejecting all future sync events from that device, and triggers an APNs/FCM silent push to wipe the local Isar database on the target device.

### 4. Zero Trust Assertion
* No API endpoint (other than `/auth/login` and `/auth/register`) may be accessed without a valid, non-expired JWT Access Token AND a valid Device Signature attached to the payload.
