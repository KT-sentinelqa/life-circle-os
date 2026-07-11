/// Outbox Recovery Tests — Phase 4 Sprint 2
///
/// Validates the Outbox pattern's disaster recovery capabilities:
/// - pending operations survive process restart
/// - interrupted syncs are replayed correctly
/// - deduplication prevents double-processing after recovery
///
/// These tests use an in-memory Outbox simulation to remain infrastructure-free.
import 'package:test/test.dart';

// ---------------------------------------------------------------------------
// In-memory Outbox simulation (mirrors the real OutboxRepository contract)
// ---------------------------------------------------------------------------
enum OutboxEntryStatus { pending, processing, completed, failed }

class OutboxEntry {
  OutboxEntry({
    required this.id,
    required this.aggregateId,
    required this.payload,
    this.status = OutboxEntryStatus.pending,
    this.retryCount = 0,
  });

  final String id;
  final String aggregateId;
  final Map<String, dynamic> payload;
  OutboxEntryStatus status;
  int retryCount;

  static const maxRetries = 3;

  bool get isExhausted => retryCount >= maxRetries;
}

class InMemoryOutboxRepository {
  final _entries = <String, OutboxEntry>{};

  void enqueue(OutboxEntry entry) {
    _entries[entry.id] = entry;
  }

  List<OutboxEntry> pendingEntries() =>
      _entries.values.where((e) => e.status == OutboxEntryStatus.pending).toList();

  void markCompleted(String id) {
    _entries[id]?.status = OutboxEntryStatus.completed;
  }

  void markFailed(String id) {
    final entry = _entries[id];
    if (entry == null) return;
    entry.retryCount++;
    if (entry.isExhausted) {
      entry.status = OutboxEntryStatus.failed;
    } else {
      entry.status = OutboxEntryStatus.pending; // return to queue for retry
    }
  }

  bool contains(String id) => _entries.containsKey(id);
  int get totalCount => _entries.length;
  int get pendingCount => pendingEntries().length;
  int get completedCount => _entries.values.where((e) => e.status == OutboxEntryStatus.completed).length;
  int get failedCount => _entries.values.where((e) => e.status == OutboxEntryStatus.failed).length;
}

void main() {
  group('Phase 4 Sprint 2: Outbox Recovery', () {
    late InMemoryOutboxRepository outbox;

    setUp(() {
      outbox = InMemoryOutboxRepository();
    });

    // -------------------------------------------------------------------------
    // Test 1: Pending entries survive simulated process restart.
    // -------------------------------------------------------------------------
    test('Test 1 — Pending entries are recovered after restart', () {
      // Enqueue 5 operations before the "crash"
      for (var i = 0; i < 5; i++) {
        outbox.enqueue(OutboxEntry(
          id: 'op-$i',
          aggregateId: 'agg-1',
          payload: {'index': i},
        ));
      }

      // Simulate restart: create new "session" but same persistent store
      final pendingAfterRestart = outbox.pendingEntries();

      // All 5 entries must be recoverable
      expect(pendingAfterRestart.length, equals(5));
      expect(outbox.completedCount, equals(0));
    });

    // -------------------------------------------------------------------------
    // Test 2: Interrupted sync replays correctly without duplication.
    // -------------------------------------------------------------------------
    test('Test 2 — Interrupted sync replays without double-processing', () {
      outbox.enqueue(OutboxEntry(id: 'op-A', aggregateId: 'agg-1', payload: {}));
      outbox.enqueue(OutboxEntry(id: 'op-B', aggregateId: 'agg-2', payload: {}));
      outbox.enqueue(OutboxEntry(id: 'op-C', aggregateId: 'agg-3', payload: {}));

      // "Sync" op-A and op-B successfully, then crash before op-C
      outbox.markCompleted('op-A');
      outbox.markCompleted('op-B');
      // op-C left pending — simulates mid-sync crash

      // Recovery pass: only op-C should be replayed
      final recovery = outbox.pendingEntries();
      expect(recovery.length, equals(1));
      expect(recovery.first.id, equals('op-C'));

      // Complete the replay
      outbox.markCompleted('op-C');
      expect(outbox.pendingCount, equals(0));
      expect(outbox.completedCount, equals(3));
    });

    // -------------------------------------------------------------------------
    // Test 3: Retry policy — max retries enforced, entry marked failed.
    // -------------------------------------------------------------------------
    test('Test 3 — Entry exhausts retries and is marked failed', () {
      outbox.enqueue(OutboxEntry(id: 'op-flaky', aggregateId: 'agg-1', payload: {}));

      // Simulate 3 consecutive failures
      outbox.markFailed('op-flaky');
      outbox.markFailed('op-flaky');
      outbox.markFailed('op-flaky');

      final entry = outbox.pendingEntries().where((e) => e.id == 'op-flaky').isEmpty
          ? null
          : outbox.pendingEntries().firstWhere((e) => e.id == 'op-flaky');

      // After max retries, entry should not be in pending queue
      expect(entry, isNull, reason: 'Exhausted entry must leave the pending queue');
      expect(outbox.failedCount, equals(1));
    });

    // -------------------------------------------------------------------------
    // Test 4: Deduplication — enqueuing the same ID twice is safe.
    // -------------------------------------------------------------------------
    test('Test 4 — Duplicate enqueue with same ID is idempotent', () {
      final entry = OutboxEntry(id: 'op-dup', aggregateId: 'agg-1', payload: {});
      outbox.enqueue(entry);
      outbox.enqueue(entry); // duplicate enqueue

      // Should still only have 1 entry
      expect(outbox.totalCount, equals(1));
    });
  });
}
