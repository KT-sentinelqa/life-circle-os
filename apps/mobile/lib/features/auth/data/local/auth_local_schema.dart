/// LifeCircle OS — Local database schema DDL constants.
///
/// These SQL statements define the local SQLite schema for offline storage.
/// Schema versioning is managed by [DatabaseManager.onCreate] / [DatabaseManager.onUpgrade].
///
/// Governed by: docs/epic-1-user-registration.md §3 | docs/mobile-architecture.md
library;

/// Current schema version — increment when adding columns or tables.
const int kSchemaVersion = 1;

/// DDL: local users cache table.
const String kCreateUsersLocalTable = '''
  CREATE TABLE IF NOT EXISTS users_local (
    id           TEXT    PRIMARY KEY     NOT NULL,
    email        TEXT    UNIQUE          NOT NULL,
    full_name    TEXT                    NOT NULL,
    role         TEXT                    NOT NULL,
    jwt_token    TEXT,
    is_verified  INTEGER NOT NULL DEFAULT 0,
    synced_at    INTEGER,
    created_at   INTEGER                 NOT NULL
  )
''';

/// DDL: local families cache table.
const String kCreateFamiliesLocalTable = '''
  CREATE TABLE IF NOT EXISTS families_local (
    id        TEXT    PRIMARY KEY NOT NULL,
    name      TEXT                NOT NULL,
    owner_id  TEXT                NOT NULL,
    synced_at INTEGER,
    created_at INTEGER            NOT NULL
  )
''';

/// DDL: sync outbox table for offline mutation queuing.
///
/// Events are inserted as PENDING, updated to SYNCED or FAILED after sync.
/// See [OutboxDatasource] for read/write operations.
const String kCreateSyncOutboxTable = '''
  CREATE TABLE IF NOT EXISTS sync_outbox (
    id              TEXT    PRIMARY KEY NOT NULL,
    event_type      TEXT                NOT NULL,
    payload         TEXT                NOT NULL,
    status          TEXT    NOT NULL DEFAULT 'PENDING',
    retry_count     INTEGER NOT NULL DEFAULT 0,
    idempotency_key TEXT    UNIQUE      NOT NULL,
    created_at      INTEGER             NOT NULL,
    last_attempt_at INTEGER
  )
''';

/// Outbox entry status values.
const String kStatusPending = 'PENDING';
const String kStatusSynced  = 'SYNCED';
const String kStatusFailed  = 'FAILED';
