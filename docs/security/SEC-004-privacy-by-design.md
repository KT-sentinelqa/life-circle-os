# SEC-004: Privacy By Design

Privacy in LifeCircle OS is a structural guarantee, not a configuration option.

## 1. Default Privacy
All data is restricted to the creating user by default. Sharing with family members requires an explicit action flow. There are no "public" family profiles.

## 2. Transparency & Consent
Any feature requiring data synchronization or sharing must present a clear, non-technical explanation to the user. Consent dialogs must not use manipulative UI patterns (dark patterns).

## 3. Data Portability
Families own their data. The application must provide a mechanism to export all structural data (medicines, schedules, responsibilities) in a readable format (e.g., JSON/CSV) directly from the local device without requiring cloud interaction.

## 4. The Right to Delete
If a user deletes a record locally, it is marked as a tombstone and permanently purged. If cloud synchronization is enabled, the tombstone forces a hard-delete on the remote server. There is no soft-delete retention beyond 30 days for operational backups.

## 5. No Behavioral Tracking
LifeCircle OS explicitly prohibits the inclusion of SDKs designed to build advertising profiles (e.g., Facebook SDK, Google Analytics for Firebase tracking features, AppsFlyer).
