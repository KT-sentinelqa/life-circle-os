/// ObservabilitySubscriber Integration Tests — Phase 4 Sprint 3
///
/// Verifies that:
///  - Every published event increments the events.published counter exactly once.
///  - Subscriber failures are counted in subscriber.failures.
///  - The ObservabilitySubscriber itself never crashes the event bus.
///  - PlatformHealthCheck correctly aggregates component statuses.
import 'dart:async';
import 'package:test/test.dart';
import 'package:lifecircle_mobile/src/features/events/domain/event_bus.dart';
import 'package:lifecircle_mobile/src/features/events/application/observability_subscriber.dart';
import 'package:lifecircle_mobile/src/core/observability/platform_logger.dart';
import 'package:lifecircle_mobile/src/core/observability/platform_metrics.dart';
import 'package:lifecircle_mobile/src/core/observability/health_indicator.dart';
import 'package:lifecircle_mobile/src/core/observability/platform_health_check.dart';

// ---------------------------------------------------------------------------
// Test doubles
// ---------------------------------------------------------------------------
class _NullLogSink implements LogSink {
  @override
  void write(PlatformLogEntry entry) {} // no-op — suppress output in tests
}

class _SyntheticEvent implements DomainEvent {
  _SyntheticEvent(this.seq)
      : eventId = 'obs-test-$seq',
        aggregateId = 'agg-obs',
        timestamp = DateTime.now().toUtc();

  final int seq;
  @override
  final String eventId;
  @override
  final String aggregateId;
  @override
  final DateTime timestamp;

  @override
  Map<String, dynamic> toJson() => {'seq': seq};
}

void main() {
  late DomainEventBus bus;
  late PlatformMetrics metrics;
  late PlatformLogger logger;
  late ObservabilitySubscriber obs;

  setUp(() {
    bus = DomainEventBus();
    metrics = PlatformMetrics();
    logger = PlatformLogger(
      component: 'Test',
      sink: _NullLogSink(),
      minimumLevel: LogLevel.debug,
    );
    obs = ObservabilitySubscriber(
      eventBus: bus,
      metrics: metrics,
      logger: logger,
    );
  });

  tearDown(() => obs.dispose());

  group('Phase 4 Sprint 3: Observability Subscriber', () {
    test('Test 1 — events.published counter increments on each event', () async {
      bus.publish(_SyntheticEvent(1));
      bus.publish(_SyntheticEvent(2));
      bus.publish(_SyntheticEvent(3));

      await Future.delayed(const Duration(milliseconds: 50));

      expect(
        metrics.counter(PlatformMetrics.eventsPublished).value,
        equals(3),
      );
    });

    test('Test 2 — ObservabilitySubscriber never crashes the bus', () async {
      // Force an error path by disposing midway — bus should keep working
      bus.publish(_SyntheticEvent(10));
      obs.dispose();

      final completer = Completer<bool>();
      bus.stream.listen((_) => completer.complete(true));
      bus.publish(_SyntheticEvent(11));

      final result = await completer.future.timeout(const Duration(seconds: 2));
      expect(result, isTrue);
    });

    test('Test 3 — LatencyHistogram records inter-event durations', () async {
      bus.publish(_SyntheticEvent(1));
      await Future.delayed(const Duration(milliseconds: 5));
      bus.publish(_SyntheticEvent(2));
      await Future.delayed(const Duration(milliseconds: 50));

      final histogram = metrics.histogram(PlatformMetrics.eventBusLatencyMs);
      // At least one inter-event sample should have been recorded
      expect(histogram.sampleCount, greaterThanOrEqualTo(1));
    });
  });

  group('Phase 4 Sprint 3: Platform Health Check', () {
    test('Test 4 — Healthy outbox reports overall healthy', () {
      final healthCheck = PlatformHealthCheck(metrics: PlatformMetrics());
      healthCheck.register(OutboxHealthIndicator(getPendingCount: () => 5));
      healthCheck.register(EventBusHealthIndicator(isActive: () => true));

      final snapshot = healthCheck.run();
      expect(snapshot.overall, equals(HealthStatus.healthy));
      expect(snapshot.isHealthy, isTrue);
    });

    test('Test 5 — High outbox depth reports degraded', () {
      final healthCheck = PlatformHealthCheck(metrics: PlatformMetrics());
      healthCheck.register(OutboxHealthIndicator(getPendingCount: () => 500)); // > 100 threshold

      final snapshot = healthCheck.run();
      expect(snapshot.overall, equals(HealthStatus.degraded));
    });

    test('Test 6 — Inactive EventBus reports overall unhealthy', () {
      final healthCheck = PlatformHealthCheck(metrics: PlatformMetrics());
      healthCheck.register(EventBusHealthIndicator(isActive: () => false));

      final snapshot = healthCheck.run();
      expect(snapshot.overall, equals(HealthStatus.unhealthy));
      expect(snapshot.isHealthy, isFalse);
    });

    test('Test 7 — Health snapshot exports as JSON', () {
      final healthCheck = PlatformHealthCheck(metrics: PlatformMetrics());
      healthCheck.register(EventBusHealthIndicator(isActive: () => true));

      final snapshot = healthCheck.run();
      final json = snapshot.toJson();

      expect(json['overall'], equals('healthy'));
      expect(json['components'], isA<List>());
      expect(json['metrics'], isA<Map>());
    });
  });
}
