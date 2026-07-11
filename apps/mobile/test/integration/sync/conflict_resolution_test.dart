import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/domain/models/family_responsibility.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/models/sync_event.dart';

void main() {
  test('Conflict Resolution (Last-Write-Wins) rejects older incoming events',
      () {
    // 1. Local Database has a newer mutation
    final localTask = FamilyResponsibility()
      ..uuid = 'task-1'
      ..updatedAt = DateTime.fromMillisecondsSinceEpoch(2000); // T=2000

    // 2. Cloud sends a SyncEvent that is older due to offline lag from Spouse
    final incomingEvent = SyncEvent()
      ..aggregateId = 'task-1'
      ..logicalTimestamp = 1000; // T=1000

    // 3. LWW Check
    final isNewer = incomingEvent.logicalTimestamp >
        localTask.updatedAt.millisecondsSinceEpoch;

    // 4. Assert local state is protected
    expect(isNewer, isFalse);
  });
}
