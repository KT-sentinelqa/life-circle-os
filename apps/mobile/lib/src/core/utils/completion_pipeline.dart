import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:lifecircle_mobile/src/core/utils/trusted_clock.dart';
import 'package:lifecircle_mobile/src/features/peace_of_mind/application/peace_index_service.dart';
import 'package:lifecircle_mobile/src/features/peace_of_mind/domain/models/peace_index_audit_entry.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/domain/models/family_responsibility.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/domain/models/responsibility_status.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/infrastructure/repositories/responsibility_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/models/sync_event.dart';
import 'package:uuid/uuid.dart';

/// CompletionResult — the full observable outcome of a single completion action.
/// Each box in the pipeline is represented. Every field is independently testable.
class CompletionResult {
  // Traces the entire pipeline

  const CompletionResult({
    required this.responsibility,
    required this.auditEntry,
    required this.outboxEvent,
    required this.correlationId,
  });
  final FamilyResponsibility responsibility; // Updated in Isar
  final PeaceIndexAuditEntry auditEntry; // Audit trail entry
  final SyncEvent outboxEvent; // Created in Outbox
  final String correlationId;
}

/// The Trusted Completion Pipeline — Milestone 4.
///
/// Sequence (mirrors the enterprise diagram from the executive review):
///
///   User taps Complete
///     ↓  [< 16ms — optimistic UI already shown]
///   markComplete() called
///     ↓
///   Validate responsibility exists
///     ↓
///   Write completion to Isar (writeTxn)
///     ↓
///   Generate PeaceIndexAuditEntry
///     ↓
///   Write audit entry to Isar (same writeTxn — atomic)
///     ↓
///   Create & write SyncEvent to Outbox (same writeTxn — atomic)
///     ↓
///   Return CompletionResult
///     ↓
///   [Reactive providers propagate automatically — no manual refresh]
///   [Background SyncService picks up Outbox event independently]
///
class CompletionPipeline {
  CompletionPipeline({
    required Isar isar,
    required ResponsibilityRepository repository,
    required PeaceIndexService peaceIndexService,
    required TrustedClock clock,
    required String deviceId,
    Uuid? uuid,
  })  : _isar = isar,
        _repository = repository,
        _peaceIndexService = peaceIndexService,
        _clock = clock,
        _deviceId = deviceId,
        _uuid = uuid ?? const Uuid();
  final Isar _isar;
  final ResponsibilityRepository _repository;
  final PeaceIndexService _peaceIndexService;
  final TrustedClock _clock;
  final Uuid _uuid;
  final String _deviceId;

  /// Executes the full pipeline atomically.
  ///
  /// [correlationId] — optional. If provided (e.g., from a retry), the same ID
  /// is reused so downstream systems can detect duplicates via [idempotencyKey].
  Future<CompletionResult> markComplete(
    String responsibilityUuid,
    String userId, {
    String? correlationId,
    String? evidenceUri,
  }) async {
    // ─── 1. Load responsibility ────────────────────────────────────────────
    final responsibility =
        await _repository.getResponsibilityByUuid(responsibilityUuid);
    if (responsibility == null) {
      throw ResponsibilityNotFoundException(responsibilityUuid);
    }

    // ─── 2. Guard: already completed (idempotency) ─────────────────────────
    if (responsibility.status == ResponsibilityStatus.completed) {
      throw AlreadyCompletedException(responsibilityUuid);
    }

    final now = _clock.now();
    final corrId = correlationId ?? _uuid.v4();
    const previousScore = 100; // Simplified; real implementation reads current

    // ─── 3. Atomic write: responsibility + audit + outbox ─────────────────
    late PeaceIndexAuditEntry auditEntry;
    late SyncEvent outboxEvent;

    await _isar.writeTxn(() async {
      // 3a. Mark responsibility complete
      responsibility.status = ResponsibilityStatus.completed;
      responsibility.completionEvidenceUri = evidenceUri;
      responsibility.confidenceScore = 100;
      responsibility.updatedAt = now;
      await _isar.familyResponsibilitys.put(responsibility);

      // 3b. Generate audit entry (SEC-012 compliant: no PII in audit log)
      auditEntry = PeaceIndexAuditEntry()
        ..householdId = 'household-${responsibility.primaryOwnerId}'
        ..previousScore = previousScore
        ..newScore = previousScore // recalculated reactively by stream
        ..delta = 0
        ..reason = 'Responsibility completed — recovery from prior state'
        ..triggeringResponsibilityUuid = responsibilityUuid
        ..triggeringCategory = responsibility.category.name
        ..calculatedAt = now;
      await _isar.peaceIndexAuditEntrys.put(auditEntry);

      // 3c. Create Outbox event (ADR-028 Canonical Event Envelope)
      outboxEvent = SyncEvent()
        ..eventId = _uuid.v4()
        ..eventType = 'responsibility.completed'
        ..schemaVersion = 1
        ..aggregateId = responsibilityUuid
        ..deviceId = _deviceId
        ..userId = userId
        ..logicalTimestamp = now.millisecondsSinceEpoch
        ..payloadJson = _buildPayload(responsibility, userId, now)
        ..signature = '' // Filled by SyncService before upload (ADR-028)
        ..correlationId = corrId
        ..idempotencyKey =
            'completion-$responsibilityUuid-${now.millisecondsSinceEpoch}'
        ..state = SyncEventState.pendingUpload
        ..retryCount = 0
        ..createdAt = now;
      await _isar.syncEvents.put(outboxEvent);
      // [watchLazy() fires here → peaceIndexStreamProvider recalculates → Dashboard rebuilds]
    });

    return CompletionResult(
      responsibility: responsibility,
      auditEntry: auditEntry,
      outboxEvent: outboxEvent,
      correlationId: corrId,
    );
  }

  String _buildPayload(
    FamilyResponsibility r,
    String userId,
    DateTime timestamp,
  ) {
    // SEC-012: No PII in payload. Domain classification only.
    return jsonEncode({
      'responsibility_uuid': r.uuid,
      'category': r.category.name, // 'health', 'finance', etc.
      'completed_by_user': userId,
      'completed_at_utc': timestamp.toUtc().toIso8601String(),
      'evidence_present': r.completionEvidenceUri != null,
    });
  }
}

class ResponsibilityNotFoundException implements Exception {
  const ResponsibilityNotFoundException(this.uuid);
  final String uuid;
  @override
  String toString() => 'ResponsibilityNotFoundException: $uuid not found';
}

class AlreadyCompletedException implements Exception {
  const AlreadyCompletedException(this.uuid);
  final String uuid;
  @override
  String toString() => 'AlreadyCompletedException: $uuid is already completed';
}
