# ADR-009: Founder Decision v1.0 - Authentication Strategy

## Status
Accepted

## Context
As LifeCircle OS scales as a global consumer application, we must balance a frictionless, modern onboarding experience with enterprise-grade security standards. The legacy email/password authentication model introduces friction, security risks, and does not align with the product's primary identity use case. We need a definitive strategy governing identity providers, authentication flows, and security constraints for the v1.0 release.

## Decision
We will standardize the LifeCircle Authentication Strategy according to the "Founder Decision v1.0" model.

### 1. Identity Providers
We explicitly restrict primary identity types to:
- **Email Address** (Direct)
- **Mobile Number** (Direct)
- **Google** (SSO)
- **Apple** (SSO - required on iOS)
- **Microsoft** (SSO - optional, valuable for business users)

*Rejected Identity Providers*: Facebook, X (Twitter), LinkedIn, GitHub. These do not align with the core product vision and add unnecessary maintenance and privacy complexities.

### 2. User Experience Flows
- **Strict Separation**: Login and Registration must be two distinct UX flows. A unified entry screen leads to confusion.
- **Login Flow**: Mobile/Email -> OTP -> Dashboard. Passwords are never requested during standard logins.
- **Registration Flow**:
  - *Google/Apple*: Authenticate -> (Optional OTP) -> Profile -> Family Wizard -> Dashboard.
  - *Email/Mobile*: Input -> OTP -> Create Password -> Profile -> Family Wizard -> Dashboard.
- **Password Purpose**: Passwords are only created *once* during registration and are strictly reserved for account recovery, sensitive actions, device verification, and deletion.

### 3. Future Enhancements
Biometric authentication (Face ID, Touch ID, Fingerprint, Passkey) will be offered as optional upgrades *after* the initial successful login.

### 4. Enterprise Security Constraints
All authentication requests must conform to the following enterprise-grade rules:
- **OTP Expiration**: 5 minutes.
- **Rate Limiting**: Maximum 3 OTP requests per 10 minutes (for both Email and Mobile).
- **Maximum Retries**: 5 attempts per OTP.
- **Device Fingerprinting**: Remember trusted devices. Require a fresh OTP when logging in from a new device.
- **Session Management**: Configurable session expiration, secure refresh token rotation, and immediate token revocation across devices.
- **Password Policy (Registration only)**: Minimum 12 characters, uppercase, lowercase, number, symbol, enforce strength meter, prevent reuse, prevent common passwords, and prevent username inclusion.

## Rationale
- **Consumer Familiarity**: Modeling after top-tier consumer apps (Google, Apple, Airbnb) provides a frictionless experience while fulfilling our strict security standards for managing family, health, and financial data.
- **Security Posture**: By minimizing password usage in the daily login flow and substituting it with OTPs and biometrics, we reduce the surface area for phishing and password fatigue.

## Consequences
- The backend authentication gateway must enforce the specified rate limits and password policies.
- The mobile application must maintain two separate entry points (Login vs. Registration).
- The onboarding experience will route newly registered users directly into the Family Setup Wizard before granting access to the Dashboard.
