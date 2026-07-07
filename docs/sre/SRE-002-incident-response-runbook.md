# SRE-002: Incident Response Runbook

## 1. Scope
Immediate triage steps for critical Cloud Trust Platform failures.

## 2. Alert: Dead Letter Queue (DLQ) Backup
**Trigger**: > 1,000 events in the Redis DLQ within 5 minutes.
**Meaning**: A specific event type is consistently failing downstream processing (usually due to a schema mismatch between mobile versions and backend models).
**Action**:
1. Check Cloud Audit Logs for `ValidationException`.
2. Verify `schema_version` of failing events.
3. If caused by a new mobile release, trigger `ADR-023` Kill Switch to disable the offending feature remotely.

## 3. Alert: High Signature Verification Failures
**Trigger**: > 5% of requests failing `signature_verifier.py`.
**Meaning**: Possible active attack (replay or forged payloads) OR a bug in the mobile `DeviceCryptoService` failing to sign correctly.
**Action**:
1. Check source IPs. If centralized, apply WAF rules.
2. If distributed (legitimate users), assume mobile client bug. Trigger `ADR-023` Kill Switch to pause Cloud Sync until hotfix is deployed.

## 4. Alert: PostgreSQL Connection Exhaustion
**Trigger**: Asyncpg pool reports 100% utilization.
**Meaning**: Ingestion API is overwhelmed or a slow query is locking the pool.
**Action**:
1. Increase FastAPI replica count via Kubernetes HPA.
2. Verify Redis Queue is healthy; if Redis is slow, the Ingestion API will block waiting to publish.
