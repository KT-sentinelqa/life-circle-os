/// Health Indicator Interface — Phase 4 Sprint 3
///
/// Every major platform component exposes a HealthIndicator.
/// The PlatformHealthCheck aggregates them into a single dashboard snapshot.
///
/// This follows the Spring Boot Actuator pattern adapted for Flutter/Dart.

enum HealthStatus {
  /// Component is fully operational.
  healthy,

  /// Component is degraded but still serving requests.
  degraded,

  /// Component is not functional. Intervention required.
  unhealthy,
}

/// A point-in-time health reading from one platform component.
class HealthReading {
  const HealthReading({
    required this.component,
    required this.status,
    this.message,
    this.details,
  });

  final String component;
  final HealthStatus status;
  final String? message;
  final Map<String, dynamic>? details;

  Map<String, dynamic> toJson() => {
    'component': component,
    'status': status.name,
    if (message != null) 'message': message,
    if (details != null) 'details': details,
    'checkedAt': DateTime.now().toUtc().toIso8601String(),
  };
}

/// Contract that every checkable platform component must implement.
abstract class HealthIndicator {
  /// Returns a point-in-time health reading for this component.
  HealthReading check();
}
