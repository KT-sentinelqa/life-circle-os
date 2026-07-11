# Consent & Revocation Policy

## 1. Explicit Consent
Upon initial launch, the Family Administrator must explicitly consent to the cryptographic generation of a device identity and the creation of a Household.

## 2. Revocation (The Kill Switch)
Consent is not permanent. 
- You may revoke device consent at any time via **Settings > Devices > Revoke**.
- You may revoke entirely via **Settings > Account > Delete Household**. This action triggers a cryptographic tombstone event that instructs the cloud to purge all sync queues associated with the Household UUID. This action is irreversible.
