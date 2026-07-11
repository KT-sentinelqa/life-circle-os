import 'package:lifecircle_mobile/src/features/timeline/domain/entities/timeline_entry.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/repositories/timeline_repository.dart';
import 'package:lifecircle_mobile/src/features/timeline/application/timeline_lifecycle_service.dart';

class ActivityRecordingService {
  const ActivityRecordingService({
    required this.timelineRepository,
    required this.lifecycleService,
  });

  final TimelineRepository timelineRepository;
  final TimelineLifecycleService lifecycleService;

  /// Consumes cross-domain activity and translates it into the Timeline stream.
  Future<void> recordCrossDomainActivity({
    required String householdId,
    required TimelineEntry entry,
  }) async {
    final timeline = await timelineRepository.getByHouseholdId(householdId);
    
    if (timeline == null) {
      throw Exception('Timeline not found for Household $householdId');
    }

    // Append to Aggregate
    final result = timeline.recordActivity(entry);

    // Dispatch (Persist & Outbox)
    await lifecycleService.dispatch(result);
  }

  /// Soft deletes an activity
  Future<void> removeActivity({
    required String householdId,
    required String entryId,
    required String deletedByActorId,
  }) async {
    final timeline = await timelineRepository.getByHouseholdId(householdId);
    
    if (timeline == null) {
      throw Exception('Timeline not found for Household $householdId');
    }

    final result = timeline.deleteActivity(entryId, deletedByActorId);
    await lifecycleService.dispatch(result);
  }
}
