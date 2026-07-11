# Migration Guide

This document provides instructions for migrating local Isar databases or network Sync Event schemas when breaking changes are introduced between Release Candidates or Major Versions.

## Upgrading to v0.9.0-rc1

*This is the first Internal Beta release. No migration from previous versions is required as all previous builds were ephemeral developer builds. Existing developer builds should be fully uninstalled before installing v0.9.0-rc1 to ensure a clean Keystore/Keychain state.*

---

### Template for Future Migrations

#### Upgrading to vX.Y.Z
**Database Schema Changes:**
- *Describe what Isar collections changed.*
- **Action Required:** The app will automatically run `DatabaseMigrationService.v2()` on startup. This process takes ~5 seconds. Do not background the app during this time.

**Sync Event Schema Changes:**
- *Describe changes to `sync_events` payload.*
- **Action Required:** Ensure all Outbox events are flushed to the cloud before upgrading. The new binary will reject `v1` schema events in the Outbox.
