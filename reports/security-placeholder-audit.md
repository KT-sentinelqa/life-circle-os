# SEC-000: Production Placeholder Audit

**Status:** Completed
**Scope:** Repository-wide (`apps/mobile/lib`)
**Date:** 2026-07-11

## Findings Inventory

| ID | File | Category | Severity | Production Path | Replacement Strategy |
|---|---|---|---|---|---|
| SEC-001 | `LocalAuthRepository` | Authentication | Critical | Yes | Replace `mock_access_token_otp` and `forceDemoLogin` with real backend auth. |
| SEC-002 | `DemoService` / `demo_service.dart` | Authorization | High | Yes | Remove or strictly `#if DEBUG` gate the "Investor Demo" bypass. |
| SEC-003 | `MockDeviceCryptoService` | Device Trust | Critical | Yes | Implement real hardware-backed KeyStore/SecureEnclave generation. |
| SEC-004 | `HttpCloudSyncClient` | Synchronization | Critical | Yes | Replace fake `pushEvent` HTTP mock with authenticated robust sync queue. |
| SEC-005 | `EncryptionService` (Init) | Cryptography | High | Yes | Ensure `secureStorage.getOrCreateEncryptionKey` utilizes strong OS-level entropy. |
| SEC-006 | `wizard_choice_screen.dart` | Authentication | Medium | Yes | Remove mock family setup bypass (Developer Alpha shortcut). |
| SEC-007 | `DashboardScreen` | Analytics / UI | Low | Yes | Replace "Investor Demo Mock Data" with real `Isar` stream ingestion. |
| SEC-008 | `device_trust_screen.dart` | Device Trust | High | Yes | Replace "// Mock Device Info" with actual device telemetry collection. |
| SEC-009 | `auth_screen.dart` | Configuration | Medium | Yes | Remove "Explore Demo" UI bypass in production paths. |
| SEC-010 | `peace_index_service_test.dart` | Infrastructure | Low | No (Test) | Retain test fakes (`_FakeTrustedClock`) but ensure separation from production DI. |

## Conclusion
Phase 2 execution should strictly target these exact IDs. The presence of `DemoService` and `MockDeviceCryptoService` in production DI graphs compromises the security posture and must be addressed sequentially.
