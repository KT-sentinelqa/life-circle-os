/// ObservabilitySubscriber — Phase 4 Sprint 3
///
/// Wires PlatformMetrics and PlatformLogger into the DomainEventBus.
///
/// Every event that flows through the bus is:
///   1. Counted (events.published counter)
///   2. Latency-tracked (eventbus.latency_ms histogram)
///   3. Logged at DEBUG level with component context
///
/// This subscriber MUST:
///   - Never throw (zero blast radius — per ADR-007)
///   - Never block the publish path
///   - Remain decoupled from all domain logic
///
/// It is the first subscriber registered by the EventSubscriberRegistry
/// so that metrics are captured before any domain-specific subscriber runs.
import 'package:lifecircle_mobile/src/features/events/domain/event_bus.dart';
import 'package:lifecircle_mobile/src/core/observability/platform_logger.dart';
import 'package:lifecircle_mobile/src/core/observability/platform_metrics.dart';

class ObservabilitySubscriber {
  ObservabilitySubscriber({
    required DomainEventBus eventBus,
    required PlatformMetrics metrics,
    required PlatformLogger logger,
  })  : _metrics = metrics,
        _logger = logger {
    _subscription = eventBus.stream.listen(_onEvent, onError: _onError);
  }

  final PlatformMetrics _metrics;
  final PlatformLogger _logger;
  late final dynamic _subscription;

  // Tracks when the last event was published — used to compute inter-event latency.
  DateTime? _lastEventTimestamp;

  void _onEvent(DomainEvent event) {
    try {
      // 1. Increment total published counter
      _metrics.counter(PlatformMetrics.eventsPublished).increment();

      // 2. Record inter-event bus latency
      final now = DateTime.now().toUtc();
      if (_lastEventTimestamp != null) {
        final latency = now.difference(_lastEventTimestamp!);
        _metrics.histogram(PlatformMetrics.eventBusLatencyMs).record(latency);
      }
      _lastEventTimestamp = now;

      // 3. Structured debug log
      _logger.debug(
        'Event received',
        context: {
          'eventId': event.eventId,
          'aggregateId': event.aggregateId,
          'eventType': event.runtimeType.toString(),
          'timestamp': event.timestamp.toIso8601String(),
        },
      );
    } catch (e, st) {
      // Observability failures must NEVER propagate
      _logger.error(
        'ObservabilitySubscriber internal error — metrics collection failed',
        error: e,
        stackTrace: st,
      );
    }
  }

  void _onError(Object error, StackTrace stackTrace) {
    _metrics.counter(PlatformMetrics.subscriberFailures).increment();
    _logger.error(
      'ObservabilitySubscriber stream error',
      error: error,
      stackTrace: stackTrace,
    );
  }

  void dispose() {
    _subscription.cancel();
  }
}
