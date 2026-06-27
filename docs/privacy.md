# LifeCircle OS — Privacy Architecture

> **Status:** Locked (v1.0)  
> **Author:** Gemini (Implementation Engineer)  
> **Reviewed & Approved By:** Krishna & ChatGPT Architecture Board  
> **Date:** June 26, 2026  

---

## 1. Privacy Principles

To protect the sacred nature of family life, all product development and data processing must strictly adhere to the following principles:
* **Privacy by Design:** Privacy is embedded proactively into the core architecture, data schemas, and domain models.
* **Privacy by Default:** Access controls, settings, and sharing rules are set to maximum privacy out-of-the-box.
* **Data Minimization:** We collect only the absolute minimum data required to execute verified user features.
* **Purpose Limitation:** Data processed for a specific function (e.g., medicine logging) must never be used for secondary processing.
* **Storage Limitation:** Data is retained only as long as necessary to fulfill the specified purpose.
* **User Sovereignty:** Families own and control their records, files, and configurations.
* **Explicit Consent:** Consent must be clear, transparent, and obtained without manipulation.
* **Transparency:** Operations, data flows, and rights handling are documented clearly in plain language.
* **Accountability:** Built-in checks verify that all security, encryption, and rights processes execute successfully.

---

## 2. Bounded Context Data Minimization Matrix

We collect only the absolute minimum data required to execute the platform's core functional epics:

| Bounded Context | Stored Attributes | Primary Storage | Encryption Level | Purpose Limitation |
| :--- | :--- | :--- | :--- | :--- |
| **Identity** | Phone numbers, device tokens, family role definitions. | PostgreSQL (Cloud) | TLS 1.3 / AES-256 (At-rest) | Device registration and push notification routing. |
| **Medicines** | Medicine schedules, names, dosages, timestamps of intake. | Isar DB (Local) & PostgreSQL (Cloud) | AES-256-GCM (Local) / Column-level AES-256 (Cloud) | Log medicine intake and alert family coordinators of missed doses. |
| **Finance** | Bill names, amounts, due dates, EMIs, payment status flags. | Isar DB (Local) & PostgreSQL (Cloud) | AES-256-GCM (Local) / Event-logged hash tables (Cloud) | Coordinate bill payments and prevent duplicate payments. |
| **Household** | Shared chore descriptions, task owners, domestic helper logs. | Isar DB (Local) & PostgreSQL (Cloud) | AES-256-GCM (Local) | Assign tasks and verify repair schedules among family members. |

---

## 3. Data Governance & Classification Policies

### Data Governance Model
* **Data Owner:** The Family (ultimate sovereign of the information).
* **Data Fiduciary:** LifeCircle OS (custodian bound by ethical processing rules).
* **Data Processor:** Approved hosting and backup infrastructure providers.
* **Data Steward:** Engineering and Operations teams (enforcing compliance rules).
* *All processing activities must be documented, auditable, and reviewable.*

### Data Classification Policy
To guide encryption, access permissions, and auditing rules, data is classified into five categories:
* **Public:** Public documentation, marketing resources, and open API specifications.
* **Internal:** Operational metadata, logging metrics, and server execution errors.
* **Confidential:** Shared household task descriptions, chore assignees, and helper attendance logs.
* **Sensitive:** Medical information (medicine names, schedules, dose timestamps) and financial records (EMIs, bill details).
* **Restricted:** Authentication credentials, cryptographic keys, and recovery parameters.

---

## 4. Data Subject Rights & Verification Protocols

LifeCircle OS implements data rights handling that aligns with current India DPDP and GDPR regulatory frameworks:

### Data Subject Rights
Users shall have the right to:
* **Access:** View all raw data fields, family logs, and settings.
* **Correction:** Request modification of erroneous, incomplete, or outdated information.
* **Erasure:** Request absolute deletion of profiles, devices, and histories.
* **Portability:** Retrieve structured, machine-readable exports of their data.
* **Consent Withdrawal:** Withdraw permissions for cloud sync or notification services at any time.
* **Grievance Redressal:** Access formal channels to resolve disputes or request policy disclosures.
* **Nomination Rights:** Appoint a designated successor to manage or inherit access in the event of death or incapacity.

### Data Deletion & Retention Pipeline
When erasure is requested:
1. Profiles, tokens, and active logs are immediately marked as `"deleted"` and removed from active synchronization nodes.
2. Database records are purged from active production databases within 24 hours.
3. **Retention Policy:** Encrypted backup retention periods shall be purpose-driven, legally justified, and periodically reviewed. The current operational target is 90 days unless legal obligations require otherwise.
4. Permanent, automated deletion from all system archives is executed immediately following the retention window.

---

## 5. Consent, Guardianship & Family Invites

* **No Dark Patterns:** All consent screens utilize plain, un-manipulative language. Options to opt-out or decline are styled with equal visual weight to accept prompts.
* **Family Invites:** Invited family members must explicitly accept a verification token on their local device to link to a family group. Shared dashboards remain disabled until consent is verified.
* **Elderly Guardianship Consent:** Setting up a profile for Ramesh requires Aarav to verify authorization. Ramesh receives a persistent, simple notice stating that his medicine schedules are shared within his family circle.

---

## 6. Telemetry, Analytics & Security Controls

### Telemetry & Analytics Controls
* **Zero Tracker SDKs:** No tracking, ad, or telemetry modules are compiled into the application code.
* **Sanitized Crash Reporting:** Sentry error reporting is strictly configured to strip all personal identifiers, IP addresses, and request payloads. We log only raw stack traces and hardware parameters.
* **No Cookies/Tracking Pixels:** No tracking cookies are set on any client interface.

### Privacy Security Controls
We enforce technical protections to preserve data anonymity and privacy:
* Encryption at rest (AES-256-GCM) on mobile and PostgreSQL columns.
* Encryption in transit (TLS 1.3 minimum) with certificate pinning.
* Comprehensive access logging and active consent auditing logs.
* Secure cryptographic erasure and verified deletion pipelines.
* Complete isolation of credentials and API keys in secure secrets vaults.

### Accessible Privacy Experiences
Privacy notices and consent agreements must remain accessible:
* Support Dynamic Type scaling up to 200%.
* Native compatibility with VoiceOver and TalkBack.
* Multi-language translation support (focusing on Indian regional languages).
* Plain-language, elder-friendly explanations of how data is shared.

---

## 7. Compliance Roadmap & Cross-Border Policy

### Cross-Border Data Policy
* **Default Residency:** All user data is stored within certified cloud regions located physically inside India.
* **Diaspora & Expansion:** Regional storage zones will be deployed for global jurisdictions. Cross-border transfers must comply with local laws and require explicit user consent.

### Regulatory Roadmap
* **Phase 1:** India DPDP Act alignment (enforcing notice guidelines, grievance redressal, and nomination protocols).
* **Phase 2:** GDPR readiness (controllers/processor boundaries, impact assessments).
* **Phase 3:** Global privacy framework compliance.

---

## 8. Ethical Data Principles

LifeCircle OS shall never:
* Sell user data or profiles.
* Build behavioral profiles or monitor family routines.
* Monetize elderly activity or accessibility options.
* Monetize health schedules or medical information.
* Implement dark patterns to capture consent or block deletions.
* Hide account deletion or export mechanisms.
* Lock users into proprietary binary formats.
* *Trust is the product. Revenue exists to sustain trust, not exploit it.*

---

## 9. Institutional Privacy Principle

> **Core Philosophy:**  
> Privacy is permanent. Family trust endures. Engineers are custodians of generational privacy.

🙏 श्री गणेशाय नमः
