# Data Processing Agreement (DPA)

This DPA applies to the extent LifeCircle OS processes any personal data on behalf of the Household Administrator (acting as the Data Controller under GDPR/DPDP).

## 1. Scope of Processing
We process encrypted sync events strictly for the purpose of routing them between authorized devices within the designated Household UUID.

## 2. Sub-processors
LifeCircle OS utilizes the following sub-processors for infrastructure:
- **[Cloud Provider e.g. AWS/GCP]:** For hosting the Sync API and encrypted PostgreSQL/Redis datastores.
- **[Error Tracking e.g. Sentry]:** For collecting scrubbed crash reports (SEC-029).

We do NOT use sub-processors for advertising, behavioral analytics, or data monetization.

## 3. Security Measures
Data in transit is secured via TLS 1.3. Data at rest (the sync queue) is stored in encrypted databases. Device-to-device payloads can be configured for End-to-End Encryption (E2EE) where LifeCircle OS servers only route opaque ciphertexts.
