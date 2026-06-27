/// LifeCircle OS — OutboxEntry: model for a queued sync event.
///
/// Entries are enqueued when a mutation occurs offline and dequeued
/// by [SyncService] when connectivity is restored.
///
/// Governed by: docs/mobile-architecture.md | LC-S1-007
library;

import 'package:equatable/equatable.dart';

import '../../auth/data/local/auth_local_schema.dart';

/// Represents a single outbound event queued for server sync.
class OutboxEntry extends Equatable {
  const OutboxEntry({
    required this.id,
    required this.eventType,
    required this.payload,
    required this.idempotencyKey,
    required this.createdAt,
    this.status = kStatusPending,
    this.retryCount = 0,
    this.lastAttemptAt,
  });

  /// UUID of the outbox entry.
  final String id;

  /// Domain event type, e.g. 'user.registered', 'family.created'.
  final String eventType;

  /// JSON-encoded event payload string.
  final String payload;

  /// Idempotency key — the server deduplicates on this value.
  final String idempotencyKey;

  /// One of [kStatusPending], [kStatusSynced], [kStatusFailed].
  final String status;

  /// Number of sync attempts made so far.
  final int retryCount;

  /// Unix timestamp ms of the last sync attempt, null if never attempted.
  final int? lastAttemptAt;

  /// Unix timestamp ms when this entry was created.
  final int createdAt;

  // ── SQLite Serialisation ───────────────────────────────────────────────────

  Map<String, Object?> toMap() => {
        'id':              id,
        'event_type':      eventType,
        'payload':         payload,
        'status':          status,
        'retry_count':     retryCount,
        'idempotency_key': idempotencyKey,
        'created_at':      createdAt,
        'last_attempt_at': lastAttemptAt,
      };

  factory OutboxEntry.fromMap(Map<String, Object?> map) => OutboxEntry(
        id:              map['id']              as String,
        eventType:       map['event_type']      as String,
        payload:         map['payload']         as String,
        status:          map['status']          as String,
        retryCount:      map['retry_count']     as int,
        idempotencyKey:  map['idempotency_key'] as String,
        createdAt:       map['created_at']      as int,
        lastAttemptAt:   map['last_attempt_at'] as int?,
      );

  OutboxEntry copyWith({
    String? status,
    int? retryCount,
    int? lastAttemptAt,
  }) =>
      OutboxEntry(
        id:              id,
        eventType:       eventType,
        payload:         payload,
        idempotencyKey:  idempotencyKey,
        createdAt:       createdAt,
        status:          status          ?? this.status,
        retryCount:      retryCount      ?? this.retryCount,
        lastAttemptAt:   lastAttemptAt   ?? this.lastAttemptAt,
      );

  @override
  List<Object?> get props => [id, eventType, status, retryCount];
}
