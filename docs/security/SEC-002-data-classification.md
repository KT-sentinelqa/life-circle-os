# SEC-002: Data Classification Framework

All data handled by LifeCircle OS is categorized into one of five tiers. This categorization dictates the mandatory encryption standards and synchronization policies.

## Classification Tiers

| Level | Definition | Examples | Encryption Requirement | Cloud Sync Policy |
| :--- | :--- | :--- | :--- | :--- |
| **Public** | Non-identifiable, application-level data. | Themes, Onboarding assets | Optional | Allowed |
| **Internal** | Application state and non-sensitive settings. | UI Preferences | AES-256 | Allowed |
| **Confidential** | General family coordination data. | Household duties, Anniversaries | AES-256-GCM | Requires Explicit Consent |
| **Sensitive** | Financial and critical health-adjacent records. | Medicines, Insurance, EMIs | Device Keystore + AES-256-GCM | Opt-in Only |
| **Restricted** | Future high-risk integrations. | EMR/Health Records | Highest available hardware protection | Separate, granular approval |

## Enforcement
No database schema or API contract may be merged without explicitly declaring its data classification tier in the PRD and ADR.
