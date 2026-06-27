/// LifeCircle OS — OutboxDatasource: SQLite read/write for sync_outbox.
///
/// Governed by: docs/mobile-architecture.md | LC-S1-007
library;

import 'package:sqflite/sqflite.dart';

import '../../auth/data/local/auth_local_schema.dart';
import 'outbox_entry.dart';

/// Max retry attempts before an entry is permanently marked FAILED.
const int kMaxRetries = 5;

/// Data source for the [sync_outbox] SQLite table.
class OutboxDatasource {
  const OutboxDatasource(this._db);

  final Database _db;

  /// Enqueue a new [OutboxEntry] with PENDING status.
  ///
  /// Uses [ConflictAlgorithm.ignore] — duplicate idempotency keys are silently
  /// dropped, ensuring at-most-once enqueue per unique operation.
  Future<void> enqueue(OutboxEntry entry) async {
    await _db.insert(
      'sync_outbox',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  /// Returns all PENDING entries ordered by [created_at] ascending (FIFO).
  Future<List<OutboxEntry>> getPending() async {
    final rows = await _db.query(
      'sync_outbox',
      where: 'status = ?',
      whereArgs: [kStatusPending],
      orderBy: 'created_at ASC',
    );
    return rows.map(OutboxEntry.fromMap).toList();
  }

  /// Mark an entry as SYNCED and record the sync timestamp.
  Future<void> markSynced(String id) async {
    await _db.update(
      'sync_outbox',
      {
        'status':          kStatusSynced,
        'last_attempt_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Increment retry_count. If retries exceed [kMaxRetries], mark FAILED.
  Future<void> markFailed(String id) async {
    final rows = await _db.query(
      'sync_outbox',
      columns: ['retry_count'],
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return;

    final currentRetries = rows.first['retry_count'] as int;
    final newRetries = currentRetries + 1;
    final now = DateTime.now().millisecondsSinceEpoch;

    await _db.update(
      'sync_outbox',
      {
        'retry_count':     newRetries,
        'last_attempt_at': now,
        'status': newRetries >= kMaxRetries ? kStatusFailed : kStatusPending,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Delete all SYNCED entries older than [age] to prevent unbounded growth.
  Future<int> purgeOlderThan(Duration age) async {
    final cutoff = DateTime.now()
        .subtract(age)
        .millisecondsSinceEpoch;
    return _db.delete(
      'sync_outbox',
      where: 'status = ? AND created_at < ?',
      whereArgs: [kStatusSynced, cutoff],
    );
  }

  /// Count of PENDING entries (used for badge / progress indicators).
  Future<int> pendingCount() async {
    final result = await _db.rawQuery(
      'SELECT COUNT(*) AS cnt FROM sync_outbox WHERE status = ?',
      [kStatusPending],
    );
    return result.first['cnt'] as int;
  }

  /// Delete all entries (used in test teardown / account deletion).
  Future<void> clear() async {
    await _db.delete('sync_outbox');
  }
}
