/// PlatformHealthCheck — Phase 4 Sprint 3
///
/// Aggregates HealthIndicator readings from all registered platform components
/// into a single system-wide snapshot.
///
/// Designed to be called:
///   - On-demand by an operational dashboard
///   - Periodically by a CI smoke-test
///   - After app startup to fail-fast on misconfiguration
import 'package:lifecircle_mobile/src/core/observability/health_indicator.dart';
import 'package:lifecircle_mobile/src/core/observability/platform_metrics.dart';

class PlatformHealthSnapshot {
  const PlatformHealthSnapshot({
    required this.overall,
    required this.readings,
    required this.metricsSnapshot,
    required this.checkedAt,
  });

  final HealthStatus overall;
  final List<HealthReading> readings;
  final Map<String, dynamic> metricsSnapshot;
  final DateTime checkedAt;

  bool get isHealthy => overall == HealthStatus.healthy;

  Map<String, dynamic> toJson() => {
    'overall': overall.name,
    'checkedAt': checkedAt.toIso8601String(),
    'components': readings.map((r) => r.toJson()).toList(),
    'metrics': metricsSnapshot,
  };
}

class PlatformHealthCheck {
  PlatformHealthCheck({required PlatformMetrics metrics}) : _metrics = metrics;

  final PlatformMetrics _metrics;
  final List<HealthIndicator> _indicators = [];

  void register(HealthIndicator indicator) {
    _indicators.add(indicator);
  }

  PlatformHealthSnapshot run() {
    final readings = _indicators.map((i) => i.check()).toList();

    final overall = _determineOverall(readings);

    return PlatformHealthSnapshot(
      overall: overall,
      readings: readings,
      metricsSnapshot: _metrics.export(),
      checkedAt: DateTime.now().toUtc(),
    );
  }

  HealthStatus _determineOverall(List<HealthReading> readings) {
    if (readings.any((r) => r.status == HealthStatus.unhealthy)) {
      return HealthStatus.unhealthy;
    }
    if (readings.any((r) => r.status == HealthStatus.degraded)) {
      return HealthStatus.degraded;
    }
    return HealthStatus.healthy;
  }
}

// ---------------------------------------------------------------------------
// Concrete health indicators for core platform components
// ---------------------------------------------------------------------------

/// Outbox health: reports degraded if the pending depth exceeds a threshold.
class OutboxHealthIndicator implements HealthIndicator {
  OutboxHealthIndicator({
    required this.getPendingCount,
    this.degradedThreshold = 100,
    this.unhealthyThreshold = 1000,
  });

  final int Function() getPendingCount;
  final int degradedThreshold;
  final int unhealthyThreshold;

  @override
  HealthReading check() {
    final depth = getPendingCount();

    if (depth >= unhealthyThreshold) {
      return HealthReading(
        component: 'Outbox',
        status: HealthStatus.unhealthy,
        message: 'Outbox depth critically high — sync engine may be stalled',
        details: {'pendingCount': depth, 'threshold': unhealthyThreshold},
      );
    }

    if (depth >= degradedThreshold) {
      return HealthReading(
        component: 'Outbox',
        status: HealthStatus.degraded,
        message: 'Outbox depth elevated — monitor sync latency',
        details: {'pendingCount': depth, 'threshold': degradedThreshold},
      );
    }

    return HealthReading(
      component: 'Outbox',
      status: HealthStatus.healthy,
      details: {'pendingCount': depth},
    );
  }
}

/// EventBus health: always healthy if the subscriber registry is running.
class EventBusHealthIndicator implements HealthIndicator {
  EventBusHealthIndicator({required this.isActive});

  final bool Function() isActive;

  @override
  HealthReading check() {
    if (!isActive()) {
      return const HealthReading(
        component: 'EventBus',
        status: HealthStatus.unhealthy,
        message: 'EventBus subscriber registry is not running',
      );
    }
    return const HealthReading(
      component: 'EventBus',
      status: HealthStatus.healthy,
    );
  }
}
