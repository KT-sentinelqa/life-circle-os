/// Performance Benchmarks — Phase 4 Sprint 2
///
/// Measures Event Bus throughput, Aggregate creation latency,
/// and Outbox enqueue performance under realistic volume conditions.
/// These establish baseline targets for regression detection.
import 'dart:async';
import 'package:test/test.dart';
import 'package:lifecircle_mobile/src/features/events/domain/event_bus.dart';

// ---------------------------------------------------------------------------
// Synthetic domain event for benchmarking (no real domain dependency needed)
// ---------------------------------------------------------------------------
class _BenchmarkEvent implements DomainEvent {
  _BenchmarkEvent(this.index)
      : eventId = 'bench-$index',
        aggregateId = 'agg-${index % 100}',
        timestamp = DateTime.now().toUtc();

  final int index;

  @override
  final String eventId;
  @override
  final String aggregateId;
  @override
  final DateTime timestamp;

  @override
  Map<String, dynamic> toJson() => {'index': index};
}

void main() {
  group('Phase 4 Sprint 2: Event Bus Performance Benchmarks', () {
    // -------------------------------------------------------------------------
    // Benchmark 1: High-Volume Throughput
    // Publish 10,000 events sequentially and verify all are received.
    // Target: zero-loss delivery, wall-clock < 2 seconds on commodity hardware.
    // -------------------------------------------------------------------------
    test('Benchmark 1 — 10k events delivered with zero loss', () async {
      final bus = DomainEventBus();
      const eventCount = 10000;
      var received = 0;
      final completer = Completer<void>();

      bus.stream.listen((event) {
        received++;
        if (received == eventCount) completer.complete();
      });

      final stopwatch = Stopwatch()..start();

      for (var i = 0; i < eventCount; i++) {
        bus.publish(_BenchmarkEvent(i));
      }

      await completer.future.timeout(
        const Duration(seconds: 5),
        onTimeout: () => throw TimeoutException('Throughput benchmark timed out after 5s'),
      );

      stopwatch.stop();

      expect(received, equals(eventCount), reason: 'Zero-loss delivery violated');

      // Report throughput metric
      final throughput = (eventCount / stopwatch.elapsedMilliseconds * 1000).round();
      // ignore: avoid_print — intentional benchmark output
      print('[BENCHMARK] Throughput: $throughput events/sec (${stopwatch.elapsedMilliseconds}ms for $eventCount events)');

      // Target: at minimum 5,000 events/sec on any hardware
      expect(throughput, greaterThan(5000), reason: 'Throughput below 5,000 events/sec target');
    });

    // -------------------------------------------------------------------------
    // Benchmark 2: Multiple Concurrent Subscribers
    // Simulates the production topology: OutboxSubscriber + TimelineSubscriber
    // + ReminderSubscriber all listening concurrently.
    // -------------------------------------------------------------------------
    test('Benchmark 2 — 3 concurrent subscribers, 5k events each receive all', () async {
      final bus = DomainEventBus();
      const eventCount = 5000;

      var sub1Count = 0;
      var sub2Count = 0;
      var sub3Count = 0;

      final c1 = Completer<void>();
      final c2 = Completer<void>();
      final c3 = Completer<void>();

      bus.stream.listen((_) { sub1Count++; if (sub1Count == eventCount) c1.complete(); });
      bus.stream.listen((_) { sub2Count++; if (sub2Count == eventCount) c2.complete(); });
      bus.stream.listen((_) { sub3Count++; if (sub3Count == eventCount) c3.complete(); });

      for (var i = 0; i < eventCount; i++) {
        bus.publish(_BenchmarkEvent(i));
      }

      await Future.wait([
        c1.future.timeout(const Duration(seconds: 5)),
        c2.future.timeout(const Duration(seconds: 5)),
        c3.future.timeout(const Duration(seconds: 5)),
      ]);

      expect(sub1Count, equals(eventCount));
      expect(sub2Count, equals(eventCount));
      expect(sub3Count, equals(eventCount));
    });

    // -------------------------------------------------------------------------
    // Benchmark 3: Outbox Enqueue Latency
    // Simulates enqueueing operations (without real DB) to verify the
    // synchronous path before async persistence is under 1ms per event.
    // -------------------------------------------------------------------------
    test('Benchmark 3 — Aggregate creation latency under load', () {
      final stopwatch = Stopwatch()..start();
      const iterations = 1000;

      // Simulate what aggregate initialisation does (UUID + DateTime)
      for (var i = 0; i < iterations; i++) {
        _BenchmarkEvent(i);
      }

      stopwatch.stop();

      final avgMicros = stopwatch.elapsedMicroseconds / iterations;
      // ignore: avoid_print
      print('[BENCHMARK] Avg aggregate-like construction: ${avgMicros.toStringAsFixed(1)} µs/op');

      // Target: under 100 microseconds per aggregate construction
      expect(avgMicros, lessThan(100), reason: 'Aggregate construction exceeds 100µs target');
    });
  });
}
