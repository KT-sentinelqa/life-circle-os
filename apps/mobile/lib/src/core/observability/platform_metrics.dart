/// Platform Metrics Collector — Phase 4 Sprint 2
///
/// Provides a lightweight, in-process metrics facade for LifeCircle OS.
/// Tracks counters and latency histograms that can be exported to a monitoring
/// back-end (Prometheus, Cloud Monitoring, Datadog) via a pluggable exporter.
///
/// Metrics are NEVER collected in the domain layer — only in subscribers,
/// application services, and infrastructure.

/// A single named counter.
class Counter {
  Counter(this.name, {this.tags = const {}});

  final String name;
  final Map<String, String> tags;
  int _value = 0;

  int get value => _value;

  void increment([int by = 1]) => _value += by;
  void reset() => _value = 0;
}

/// A simple latency histogram backed by a list of recorded durations (ms).
class LatencyHistogram {
  LatencyHistogram(this.name);

  final String name;
  final List<double> _samples = [];

  void record(Duration duration) {
    _samples.add(duration.inMicroseconds / 1000.0);
  }

  double get p50 => _percentile(50);
  double get p95 => _percentile(95);
  double get p99 => _percentile(99);
  double get mean => _samples.isEmpty ? 0 : _samples.reduce((a, b) => a + b) / _samples.length;
  int get sampleCount => _samples.length;

  double _percentile(int p) {
    if (_samples.isEmpty) return 0;
    final sorted = List<double>.from(_samples)..sort();
    final index = ((p / 100) * (sorted.length - 1)).round();
    return sorted[index];
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'count': sampleCount,
    'mean_ms': mean.toStringAsFixed(2),
    'p50_ms': p50.toStringAsFixed(2),
    'p95_ms': p95.toStringAsFixed(2),
    'p99_ms': p99.toStringAsFixed(2),
  };
}

/// Central metrics registry — instantiate once at app startup via DI.
class PlatformMetrics {
  final _counters = <String, Counter>{};
  final _histograms = <String, LatencyHistogram>{};

  Counter counter(String name, {Map<String, String> tags = const {}}) {
    return _counters.putIfAbsent(name, () => Counter(name, tags: tags));
  }

  LatencyHistogram histogram(String name) {
    return _histograms.putIfAbsent(name, () => LatencyHistogram(name));
  }

  /// Export all metrics as a JSON-serializable snapshot.
  Map<String, dynamic> export() => {
    'counters': _counters.map((k, v) => MapEntry(k, v.value)),
    'histograms': _histograms.map((k, v) => MapEntry(k, v.toJson())),
    'exportedAt': DateTime.now().toUtc().toIso8601String(),
  };

  /// Named standard platform metric keys — prevents magic string drift.
  static const String eventsPublished = 'events.published';
  static const String subscriberFailures = 'subscriber.failures';
  static const String outboxDepth = 'outbox.depth';
  static const String syncDurationMs = 'sync.duration_ms';
  static const String sdkErrorRate = 'sdk.errors';
  static const String eventBusLatencyMs = 'eventbus.latency_ms';
}
