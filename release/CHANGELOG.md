# Changelog

All notable changes to LifeCircle OS will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Phase 7 Release Engineering Scaffolding.
- Enterprise Security, Identity, and Telemetry infrastructure.
- Offline-first capabilities via Isar.

### Changed
- Refactored `DashboardScreen` and `ResponsibilitiesScreen` to fully reactive StreamProviders.

### Deprecated
- Initial mocked provider logic removed.

### Removed
- Static UI test mocks.

### Fixed
- Idempotency key implementation in SyncEvent.
- Privacy boundaries in Notification payload generation.

### Security
- SEC-030 and SEC-028 enforced on all telemetry transmission.
