# Risk Register

| Risk ID | Category | Description | Probability | Impact | Mitigation Strategy |
|---|---|---|---|---|---|
| R-001 | Technical | Isar Database corruption on device causing data loss. | Low | High | Ensure users understand the cloud sync acts as a backup. Emphasize offline resilience testing in QA-001. |
| R-002 | Business | High price point ($99/yr) limits top-of-funnel adoption. | Medium | Medium | Offer 30-day unrestricted trial. Focus marketing on "Cost of Mental Load" vs "Cost of App". |
| R-003 | Legal | GDPR/DPDP non-compliance due to sync metadata. | Low | High | External legal counsel review of Privacy Policy and Data Processing Agreements prior to Public Beta. |
| R-004 | Security | Device theft compromises family data. | Medium | High | Enforce biometric lock/Passkey (SEC-026) and 15-minute idle timeouts (ADR-034). |
| R-005 | Product | One parent adopts the app, the other refuses to use it. | High | High | Ensure UI is utterly simple ("Calm Design"). Allow primary user to operate effectively even if partner is passive. |
