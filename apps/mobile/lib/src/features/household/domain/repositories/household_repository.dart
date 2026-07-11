import 'package:lifecircle_mobile/src/features/household/domain/aggregates/household_aggregate.dart';

abstract class HouseholdRepository {
  Future<void> save(HouseholdAggregate aggregate);
  Future<HouseholdAggregate?> getById(String householdId);
}
