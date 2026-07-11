/// Platform Structured Logger — Phase 4 Sprint 2
///
/// Provides a consistent, levelled, structured logging interface
/// across all LifeCircle OS platform components.
///
/// Key design decisions:
///  - Domain layer NEVER calls this directly (it would violate Pillar 2).
///  - Only Application Services, Subscribers, and Infrastructure may log.
///  - Output is structured (JSON-friendly) to integrate with log aggregators.

enum LogLevel { debug, info, warn, error, fatal }

/// A single structured log entry.
class PlatformLogEntry {
  const PlatformLogEntry({
    required this.level,
    required this.component,
    required this.message,
    required this.timestamp,
    this.context,
    this.error,
    this.stackTrace,
  });

  final LogLevel level;
  final String component;   // e.g. 'OutboxSubscriber', 'TrustNetworkAggregate'
  final String message;
  final DateTime timestamp;
  final Map<String, dynamic>? context;
  final Object? error;
  final StackTrace? stackTrace;

  Map<String, dynamic> toJson() => {
    'level': level.name.toUpperCase(),
    'component': component,
    'message': message,
    'timestamp': timestamp.toIso8601String(),
    if (context != null) 'context': context,
    if (error != null) 'error': error.toString(),
    if (stackTrace != null) 'stackTrace': stackTrace.toString(),
  };
}

/// Log sink interface — concrete implementations route to console, file, or remote.
abstract class LogSink {
  void write(PlatformLogEntry entry);
}

/// Production console sink (structured JSON output).
class ConsoleLogSink implements LogSink {
  @override
  void write(PlatformLogEntry entry) {
    // In production, this would write to a log aggregator (Datadog, Cloud Logging etc.)
    // ignore: avoid_print — intentional structured output
    print(entry.toJson().toString());
  }
}

/// The platform-wide logger. Obtain via dependency injection — never singleton.
class PlatformLogger {
  PlatformLogger({
    required this.component,
    required LogSink sink,
    this.minimumLevel = LogLevel.info,
  }) : _sink = sink;

  final String component;
  final LogSink _sink;
  final LogLevel minimumLevel;

  void _log(
    LogLevel level,
    String message, {
    Map<String, dynamic>? context,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (level.index < minimumLevel.index) return;

    _sink.write(PlatformLogEntry(
      level: level,
      component: component,
      message: message,
      timestamp: DateTime.now().toUtc(),
      context: context,
      error: error,
      stackTrace: stackTrace,
    ));
  }

  void debug(String message, {Map<String, dynamic>? context}) =>
      _log(LogLevel.debug, message, context: context);

  void info(String message, {Map<String, dynamic>? context}) =>
      _log(LogLevel.info, message, context: context);

  void warn(String message, {Map<String, dynamic>? context, Object? error}) =>
      _log(LogLevel.warn, message, context: context, error: error);

  void error(String message, {
    Map<String, dynamic>? context,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _log(LogLevel.error, message, context: context, error: error, stackTrace: stackTrace);

  void fatal(String message, {
    Map<String, dynamic>? context,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _log(LogLevel.fatal, message, context: context, error: error, stackTrace: stackTrace);
}
