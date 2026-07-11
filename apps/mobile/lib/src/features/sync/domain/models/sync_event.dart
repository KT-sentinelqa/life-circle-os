import 'package:isar/isar.dart';

part 'sync_event.g.dart';

/// Enumerates the state of a Sync Event to facilitate the Inbox/Outbox pattern.
enum SyncEventState {
  pendingUpload, // In Outbox, waiting to be sent to the Cloud
  pendingMerge, // In Inbox, waiting to be merged into the local DB
  processed // Safely merged or uploaded. Safe to delete.
}

@collection
class SyncEvent {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String eventId; // uuid-v4

  late String eventType;
  late int schemaVersion;

  @Index()
  late String aggregateId; // The ID of the FamilyResponsibility mutated

  late String deviceId;
  late String userId;
  late int logicalTimestamp; // Derived from TrustedClock

  late String payloadJson; // Serialized JSON payload
  late String signature; // Cryptographic signature of the payload

  /// Distributed tracing: All events spawned by the same user action share
  /// this ID. Enables end-to-end tracing: UI tap → Outbox → Cloud → ACK → Push.
  late String correlationId;

  /// Prevents duplicate events if the same action is retried.
  /// The cloud ledger rejects any event with a duplicate idempotencyKey.
  late String idempotencyKey;

  @enumerated
  late SyncEventState state;

  // For telemetry/retry logic
  late int retryCount;
  late DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'eventType': eventType,
      'schemaVersion': schemaVersion,
      'aggregateId': aggregateId,
      'deviceId': deviceId,
      'userId': userId,
      'logicalTimestamp': logicalTimestamp,
      'payloadJson': payloadJson,
      'signature': signature,
      'correlationId': correlationId,
      'idempotencyKey': idempotencyKey,
      'state': state.index,
      'retryCount': retryCount,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static SyncEvent fromJson(Map<String, dynamic> json) {
    return SyncEvent()
      ..eventId = json['eventId'] as String
      ..eventType = json['eventType'] as String
      ..schemaVersion = json['schemaVersion'] as int
      ..aggregateId = json['aggregateId'] as String
      ..deviceId = json['deviceId'] as String
      ..userId = json['userId'] as String
      ..logicalTimestamp = json['logicalTimestamp'] as int
      ..payloadJson = json['payloadJson'] as String
      ..signature = json['signature'] as String
      ..correlationId = json['correlationId'] as String
      ..idempotencyKey = json['idempotencyKey'] as String
      ..state = SyncEventState.values[json['state'] as int]
      ..retryCount = json['retryCount'] as int
      ..createdAt = DateTime.parse(json['createdAt'] as String);
  }
}
