# LifeCircle OS — Operations Runbook

**Version**: 1.0
**Owner**: Engineering Lead
**Last Updated**: 2026-07-12

---

## 1. Platform Health Monitoring

### Check platform health
```dart
final healthCheck = serviceLocator<PlatformHealthCheck>();
final snapshot = healthCheck.run();
print(snapshot.toJson());
```

**Expected**: `overall: healthy`

**Degraded indicators to investigate**:
- `Outbox: degraded` → Sync engine latency spike. Check network and API availability.
- `EventBus: unhealthy` → Subscriber registry not started. Force app restart.

---

## 2. Outbox Operations

### View pending Outbox depth
Query the local SQLite `outbox_entries` table:
```sql
SELECT COUNT(*) FROM outbox_entries WHERE status = 'pending';
```

**Action thresholds**:
- < 100: Normal
- 100–1000: Investigate sync coordinator
- > 1000: Escalate to Severity-2

### Force Outbox replay
The Sync Coordinator runs automatically on network reconnect. To trigger manually:
```dart
final syncCoordinator = serviceLocator<SyncCoordinator>();
await syncCoordinator.replayPendingOperations();
```

### Clear failed Outbox entries (CAUTION)
Failed entries are retained for inspection. After RCA, clear them:
```dart
await outboxRepository.clearFailed(before: DateTime.now().subtract(const Duration(days: 7)));
```

---

## 3. Event Bus Operations

### Check subscriber registry status
```dart
final registry = serviceLocator<EventSubscriberRegistry>();
print('Subscribers active: ${registry.activeCount}');
```

### Subscriber failure metrics
```dart
final metrics = serviceLocator<PlatformMetrics>();
final failures = metrics.counter(PlatformMetrics.subscriberFailures).value;
print('Subscriber failures: $failures');
```

> If `subscriberFailures` > 0, check `platform_logger` output for `ERROR` level entries from the `ObservabilitySubscriber`.

---

## 4. Incident Response

### Severity Levels

| Level | Criteria | Response Time |
| :--- | :--- | :--- |
| **S1** | Data loss or security breach | Immediate (< 30 min) |
| **S2** | Outbox stalled > 1000 pending or sync offline > 24h | < 2 hours |
| **S3** | Degraded health indicator with no user impact | < 24 hours |
| **S4** | Performance below benchmark thresholds | < 1 week |

### S1 Response Steps
1. Immediately escalate to Engineering Lead and Security Lead.
2. If data breach: notify legal and follow data breach notification procedure.
3. If sync corruption: halt all write operations until RCA is complete.
4. Open incident ticket within 30 minutes.
5. Assign RCA owner before end of incident.

---

## 5. Release Operations

Refer to [RELEASE_PLAYBOOK.md](./release/RELEASE_PLAYBOOK.md) for the complete release process.

Quick reference:
```bash
# Create release branch
git checkout -b release/v1.0.0

# Beta tag → triggers beta CI and GitHub Release
git tag v1.0.0-beta.1 && git push origin v1.0.0-beta.1

# Stable tag → triggers full release
git tag v1.0.0 && git push origin v1.0.0
```

---

## 6. Useful Diagnostic Commands

```bash
# Run full CI locally before pushing
cd apps/mobile
flutter analyze
flutter format --output=none .
flutter test test/architecture/ test/unit/ test/resilience/ test/observability/
flutter test test/performance/

# Check for outdated dependencies
flutter pub outdated

# Check for known vulnerabilities
dart pub audit
```
