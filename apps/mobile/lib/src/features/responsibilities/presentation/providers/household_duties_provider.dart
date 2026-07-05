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
      taskName: 'Medicines',
      isCompleted: true,
    ),
    const HouseholdDutyEntity(
      id: 'duty-2',
      assigneeId: 'user-dil',
      assigneeName: 'Priya',
      taskName: 'Grocery',
      isCompleted: true,
    ),
    const HouseholdDutyEntity(
      id: 'duty-3',
      assigneeId: 'user-son',
      assigneeName: 'Amit',
      taskName: 'EMI Payments',
      isCompleted: true,
    ),
    const HouseholdDutyEntity(
      id: 'duty-4',
      assigneeId: 'user-son',
      assigneeName: 'Amit',
      taskName: 'Insurance',
      isCompleted: true,
    ),
    const HouseholdDutyEntity(
      id: 'duty-5',
      assigneeId: 'user-child',
      assigneeName: 'Aarav',
      taskName: 'Birthday',
      isCompleted: false,
      specialEventDate: 'in 14 days',
    ),
  ];
}
