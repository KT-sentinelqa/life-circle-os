import 'package:lifecircle_mobile/src/sdk/v1/models/dto/timeline_entry_dto.dart';

abstract class TimelineSDK {
  /// Records a cross-domain activity into the immutable timeline stream.
  Future<void> recordActivity(String householdId, TimelineEntryDTO entry);

  /// Retrieves the chronological stream of activities.
  Future<List<TimelineEntryDTO>> getTimeline(String householdId);

  /// Subscribes to realtime updates of the Timeline.
  Stream<TimelineEntryDTO> subscribeToStream(String householdId);
}
