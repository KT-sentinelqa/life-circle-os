import '../domain/models/sync_event.dart';

/// Interface representing the eventual FastAPI Cloud Runtime (Phase 4.4C)
abstract class CloudSyncClient {
  /// Pushes an Outbox event to the Cloud. Returns true if ACK'd.
  Future<bool> pushEvent(SyncEvent event);
  
  /// Fetches new events from the Cloud Inbox.
  Future<List<SyncEvent>> fetchEvents(String lastSyncToken);
}

/// Mock client to achieve Enterprise Lock on local mechanics in Phase 4.4B
class MockCloudSyncClient implements CloudSyncClient {
  final List<SyncEvent> _serverEvents = [];
  
  @override
  Future<bool> pushEvent(SyncEvent event) async {
    _serverEvents.add(event);
    return true; // Simulate successful ACK
  }

  @override
  Future<List<SyncEvent>> fetchEvents(String lastSyncToken) async {
    // Return events simulating Cloud -> Device sync
    return List.unmodifiable(_serverEvents);
  }
}
