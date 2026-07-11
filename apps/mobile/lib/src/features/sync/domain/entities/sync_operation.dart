import 'package:flutter/foundation.dart';

enum MutationType {
  create,
  update,
  delete,
}

enum SyncOperationStatus {
  pending,
  inFlight,
  failed,
  deadLetter,
  archived,
}

@immutable
class SyncOperation {
  const SyncOperation({
    required this.operationId,
    required this.entityId,
    required this.entityType,
    required this.mutationType,
    required this.payload,
    required this.timestamp,
    required this.sequenceNumber,
    required this.idempotencyKey,
    required this.status,
    required this.retryCount,
    required this.attempt,
    this.nextRetryAt,
  });

  final String operationId;
  final String entityId;
  final String entityType;
  final MutationType mutationType;
  final String payload; // JSON blob
  final DateTime timestamp;
  final int sequenceNumber;
  final String idempotencyKey;
  final SyncOperationStatus status;
  final int retryCount;
  final int attempt;
  final DateTime? nextRetryAt;

  SyncOperation copyWith({
    SyncOperationStatus? status,
    int? retryCount,
    int? attempt,
    DateTime? nextRetryAt,
  }) {
    return SyncOperation(
      operationId: operationId,
      entityId: entityId,
      entityType: entityType,
      mutationType: mutationType,
      payload: payload,
      timestamp: timestamp,
      sequenceNumber: sequenceNumber,
      idempotencyKey: idempotencyKey,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      attempt: attempt ?? this.attempt,
      nextRetryAt: nextRetryAt ?? this.nextRetryAt,
    );
  }
}
