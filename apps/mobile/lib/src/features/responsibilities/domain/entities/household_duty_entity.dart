import 'package:freezed_annotation/freezed_annotation.dart';

part 'household_duty_entity.freezed.dart';

/// Represents a delegated household responsibility or chore.
@freezed
class HouseholdDutyEntity with _$HouseholdDutyEntity {
  /// Creates an immutable household duty record.
  const factory HouseholdDutyEntity({
    required String id,
    required String assigneeId,
    required String assigneeName,
    required String taskName,
    required bool isCompleted,
    String? specialEventDate,
  }) = _HouseholdDutyEntity;
}
