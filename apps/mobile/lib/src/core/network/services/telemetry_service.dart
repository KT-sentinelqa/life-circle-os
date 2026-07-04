abstract interface class TelemetryService {
  void trackRequest(
    String method,
    String path,
    Duration duration,
    int statusCode,
  );
  
  void trackFailure(
    String operation,
    Object error,
  );
}
