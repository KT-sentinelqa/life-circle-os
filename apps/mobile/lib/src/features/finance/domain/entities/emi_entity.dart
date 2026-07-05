import 'package:freezed_annotation/freezed_annotation.dart';

part 'emi_entity.freezed.dart';

/// Represents an EMI obligation for a household asset or loan.
@freezed
class EmiEntity with _$EmiEntity {
  /// Creates an immutable EMI record.
  const factory EmiEntity({
    required String id,
    required String name,
    required double amount,
    required DateTime dueDate,
    @Default(false) bool isPaid,
  }) = _EmiEntity;
}
