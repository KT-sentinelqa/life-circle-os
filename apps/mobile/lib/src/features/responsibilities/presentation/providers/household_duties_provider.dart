import 'package:lifecircle_mobile/src/features/responsibilities/domain/entities/household_duty_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'household_duties_provider.g.dart';

/// Provides the current list of delegated household responsibilities.
@riverpod
Future<List<HouseholdDutyEntity>> householdDutiesList(
  HouseholdDutiesListRef ref,
) async {
  return [
    const HouseholdDutyEntity(
      id: 'duty-1',
      assigneeId: 'user-dil',
      assigneeName: 'Priya',
      taskName: 'Morning Medicines',
      isCompleted: true,
    ),
    const HouseholdDutyEntity(
      id: 'duty-2',
      assigneeId: 'user-dil',
      assigneeName: 'Priya',
      taskName: 'Weekly Grocery',
      isCompleted: false,
    ),
    const HouseholdDutyEntity(
      id: 'duty-3',
      assigneeId: 'user-son',
      assigneeName: 'Amit',
      taskName: 'Clear Car EMI',
      isCompleted: false,
    ),
    const HouseholdDutyEntity(
      id: 'duty-4',
      assigneeId: 'user-son',
      assigneeName: 'Amit',
      taskName: 'Renew Vehicle Insurance',
      isCompleted: false,
    ),
    const HouseholdDutyEntity(
      id: 'duty-5',
      assigneeId: 'user-child',
      assigneeName: 'Aarav',
      taskName: 'Birthday Party',
      isCompleted: false,
      specialEventDate: 'in 14 days',
    ),
    const HouseholdDutyEntity(
      id: 'duty-6',
      assigneeId: 'user-son',
      assigneeName: 'Amit',
      taskName: "Parents' Anniversary",
      isCompleted: false,
      specialEventDate: 'in 21 days',
    ),
  ];
}
