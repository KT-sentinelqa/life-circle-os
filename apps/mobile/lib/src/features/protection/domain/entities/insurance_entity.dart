import 'package:freezed_annotation/freezed_annotation.dart';

part 'insurance_entity.freezed.dart';

/// Represents a family insurance policy (e.g., Car, Health)
/// and its renewal status.
@freezed
class InsuranceEntity with _$InsuranceEntity {
  /// Creates an immutable insurance record.
  const factory InsuranceEntity({
    required String id,
    required String name,
    required String type,
    required DateTime renewalDate,
    @Default(false) bool isRenewed,
  }) = _InsuranceEntity;
}
