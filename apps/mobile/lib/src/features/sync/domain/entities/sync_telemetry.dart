import 'package:flutter/foundation.dart';

@immutable
class SyncTelemetryEvent {
  const SyncTelemetryEvent({
    required this.batchId,
    required this.queueDepth,
    required this.batchSize,
    required this.syncLatencyMs,
    required this.retryCount,
    required this.conflictCount,
    required this.duplicateCount,
    required this.signatureFailures,
    required this.sessionFailures,
    required this.trustFailures,
    required this.transportFailures,
    required this.timestamp,
  });

  final String batchId;
  final int queueDepth;
  final int batchSize;
  final int syncLatencyMs;
  final int retryCount;
  final int conflictCount;
  final int duplicateCount;
  final int signatureFailures;
  final int sessionFailures;
  final int trustFailures;
  final int transportFailures;
  final DateTime timestamp;
}
