import 'package:isar/isar.dart';

part 'sync_event.g.dart';

/// Enumerates the state of a Sync Event to facilitate the Inbox/Outbox pattern.
enum SyncEventState {
  pendingUpload, // In Outbox, waiting to be sent to the Cloud
  pendingMerge,  // In Inbox, waiting to be merged into the local DB
  processed      // Safely merged or uploaded. Safe to delete.
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
  
  @enumerated
  late SyncEventState state;
  
  // For telemetry/retry logic
  late int retryCount;
  late DateTime createdAt;
}
