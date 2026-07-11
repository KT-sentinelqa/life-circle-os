import 'package:lifecircle_mobile/src/features/preferences/domain/aggregates/shared_preference_aggregate.dart';

abstract class PreferenceRepository {
  Future<void> save(SharedPreferenceAggregate aggregate);
  Future<SharedPreferenceAggregate?> getByHouseholdId(String householdId);
}
