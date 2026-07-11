import 'package:lifecircle_mobile/src/features/timeline/domain/aggregates/timeline_aggregate.dart';

abstract class TimelineRepository {
  Future<void> save(TimelineAggregate aggregate);
  Future<TimelineAggregate?> getByHouseholdId(String householdId);
}
