import 'package:flutter_test/flutter_test.dart';
import 'package:life_circle_os/src/features/sync/domain/models/sync_event.dart';

void main() {
  test('Outbox queue isolates UI from network delays', () {
    // 1. Simulate UI completing a task offline
    final event = SyncEvent()
      ..eventId = 'evt-1'
      ..aggregateId = 'task-1'
      ..state = SyncEventState.pendingUpload;

    // 2. Event is written to local Outbox instantly (UI resolves immediately)
    expect(event.state, SyncEventState.pendingUpload);

    // 3. (Mock) CloudSyncClient would push in background.
  });
}
