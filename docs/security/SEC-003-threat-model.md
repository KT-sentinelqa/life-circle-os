# SEC-003: Threat Model

This document outlines the primary threat vectors targeting LifeCircle OS and the architectural countermeasures implemented to neutralize them.

## Threat Vectors & Countermeasures

### 1. Physical Device Compromise (Theft/Loss)
* **Threat**: An attacker gains physical access to an unlocked device containing family medical/financial schedules.
* **Countermeasure**: Sensitive data is encrypted at rest using Isar encryption wrapped by the OS hardware keystore (Android Keystore / iOS Secure Enclave). Biometric re-authentication is required to view Restricted data.

### 2. Network Interception (Man-in-the-Middle)
* **Threat**: Cloud synchronization traffic is intercepted on public Wi-Fi.
* **Countermeasure**: Mandatory TLS 1.3 for all outbound connections. Certificate pinning prevents trust-store manipulation.

### 3. Rogue Family Member / Escalation of Privilege
* **Threat**: A child or distant relative gains access to parental financial configurations.
* **Countermeasure**: The `FamilyConsentModel` strictly enforces Least Privilege. Role-Based Access Control (RBAC) verifies permissions at the domain level before querying the local database.

### 4. Supply Chain / Dependency Poisoning
* **Threat**: A third-party Flutter package introduces malicious exfiltration code.
* **Countermeasure**: Strict enforcement of `SEC-010-third-party-vendor-policy`. Mandatory SBOM generation and dependency scanning in CI/CD.

## Continuous Review
This Threat Model must be reviewed and updated before the release of any new major feature Epic (e.g., The Responsibility Engine).
