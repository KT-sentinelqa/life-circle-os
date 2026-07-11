import 'package:flutter/foundation.dart';

enum ConflictResolutionStatus {
  merged,
  acceptedLocal,
  acceptedRemote,
  retryRequired,
  transformAndRetry,
  duplicate,
  ignored,
  escalateManual,
  rejected,
}

@immutable
class ConflictResolutionResult {
  const ConflictResolutionResult({
    required this.status,
    this.resolvedPayload,
  });

  final ConflictResolutionStatus status;
  final String? resolvedPayload; // Only present if transformed or merged
}

@immutable
class ConflictAuditRecord {
  const ConflictAuditRecord({
    required this.conflictId,
    required this.entityType,
    required this.entityId,
    required this.localVersion,
    required this.remoteVersion,
    required this.resolverUsed,
    required this.resolutionResult,
    required this.timestamp,
    required this.operator,
  });

  final String conflictId;
  final String entityType;
  final String entityId;
  final int localVersion;
  final int remoteVersion;
  final String resolverUsed;
  final ConflictResolutionStatus resolutionResult;
  final DateTime timestamp;
  final String operator; // 'automatic' or 'manual'
}
