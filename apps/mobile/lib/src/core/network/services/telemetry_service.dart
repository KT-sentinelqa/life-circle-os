/// Abstract interface for tracking application telemetry.
abstract interface class TelemetryService {
  /// Tracks a network request.
  void trackRequest(
    String method,
    String path,
    Duration duration,
    int statusCode,
  );
  
  /// Tracks an operation failure.
  void trackFailure(
    String operation,
    Object error,
  );
}
