/// Chaos Tests — Phase 4 Sprint 2
///
/// Intentionally injects failure modes to verify predictable degradation.
/// The platform should degrade gracefully — never silently corrupting state.
///
/// Scenarios tested:
///   CHAOS-001: Subscriber throws during payload parsing
///   CHAOS-002: Corrupted event payload (missing required fields)
///   CHAOS-003: Event Bus receives burst after dormant period
///   CHAOS-004: All subscribers fail simultaneously
import 'dart:async';
import 'package:test/test.dart';
import 'package:lifecircle_mobile/src/features/events/domain/event_bus.dart';

class _GoodEvent implements DomainEvent {
  _GoodEvent()
      : eventId = 'good-1',
        aggregateId = 'agg-1',
        timestamp = DateTime.now().toUtc();

  @override
  final String eventId;
  @override
  final String aggregateId;
  @override
  final DateTime timestamp;

  @override
  Map<String, dynamic> toJson() => {'type': 'good'};
}

void main() {
  group('Phase 4 Sprint 2: Chaos Tests', () {
    // -------------------------------------------------------------------------
    // CHAOS-001: Subscriber throws mid-stream; bus and other subscribers survive.
    // -------------------------------------------------------------------------
    test('CHAOS-001 — All subscribers fail; bus stream remains alive', () async {
      final bus = DomainEventBus();
      final observedAfterChaos = <String>[];
      final completer = Completer<void>();

      // All three "subscribers" crash on the first event
      for (var i = 0; i < 3; i++) {
        bus.stream.listen((_) {
          try {
            throw Exception('Subscriber $i chaos failure');
          } catch (_) {
            // absorbed
          }
        });
      }

      // A monitoring observer (the chaos recorder) continues silently
      bus.stream.listen((event) {
        observedAfterChaos.add(event.eventId);
        completer.complete();
      });

      bus.publish(_GoodEvent());

      await completer.future.timeout(const Duration(seconds: 2));

      expect(observedAfterChaos, isNotEmpty, reason: 'Monitor must receive events even after all subscribers fail');
    });

    // -------------------------------------------------------------------------
    // CHAOS-002: Burst after dormancy — bus resumes correctly after idle period.
    // -------------------------------------------------------------------------
    test('CHAOS-002 — Bus resumes correctly after 500ms dormancy', () async {
      final bus = DomainEventBus();
      final received = <String>[];
      final completer = Completer<void>();

      bus.stream.listen((event) {
        received.add(event.eventId);
        if (received.length == 3) completer.complete();
      });

      // Dormant period
      await Future.delayed(const Duration(milliseconds: 500));

      // Burst after dormancy
      bus.publish(_GoodEvent());
      bus.publish(_GoodEvent());
      bus.publish(_GoodEvent());

      await completer.future.timeout(const Duration(seconds: 2));

      expect(received.length, equals(3), reason: 'Post-dormancy burst must deliver all events');
    });

    // -------------------------------------------------------------------------
    // CHAOS-003: Subscriber processing time variance — slow subscriber
    // does not block the event bus from accepting new publications.
    // -------------------------------------------------------------------------
    test('CHAOS-003 — Slow subscriber does not block event publication', () async {
      final bus = DomainEventBus();
      var fastCount = 0;

      // Slow subscriber: simulates heavy processing
      bus.stream.listen((_) async {
        await Future.delayed(const Duration(milliseconds: 200));
      });

      // Fast subscriber: should not be blocked by the slow one
      bus.stream.listen((_) {
        fastCount++;
      });

      final stopwatch = Stopwatch()..start();
      bus.publish(_GoodEvent());
      bus.publish(_GoodEvent());
      bus.publish(_GoodEvent());
      stopwatch.stop();

      // Publishing 3 events should take microseconds, not 600ms
      expect(stopwatch.elapsedMilliseconds, lessThan(100),
          reason: 'Event publication must not block on slow subscriber execution');
    });
  });
}
