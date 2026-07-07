# ADR-024: Local Data Migration Strategy

## Context
Isar schemas evolve. As we add fields to `FamilyResponsibility`, we must migrate the local database on millions of devices without causing data loss.

## Decision
We mandate an **Encrypted Backup & Rollback Protocol** for all migrations.

### The Protocol
1. Before `Isar.open()` attempts a schema upgrade, copy the existing `.isar` file to `.isar.backup`.
2. Attempt the migration.
3. If successful, delete the backup.
4. If a `MigrationException` occurs, delete the corrupted new file, restore `.isar.backup`, and launch the app in **Degraded Mode** (read-only) while reporting the failure to Telemetry (anonymized per SEC-017).

## Consequences
* Briefly doubles the disk space required during startup on the day of an update.
* Provides a 100% guarantee against permanent local data loss due to developer migration errors.
