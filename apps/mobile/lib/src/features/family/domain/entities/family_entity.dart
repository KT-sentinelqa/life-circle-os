import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_entity.freezed.dart';
part 'family_entity.g.dart';

/// Represents a family in the system.
@freezed
class FamilyEntity with _$FamilyEntity {
  /// Creates a [FamilyEntity].
  const factory FamilyEntity({
    /// Unique identifier for the family.
    required String id,

    /// The name of the family.
    required String name,

    /// The creation date of the family.
    required DateTime createdAt,
  }) = _FamilyEntity;

  /// Creates a [FamilyEntity] from a JSON object.
  factory FamilyEntity.fromJson(Map<String, dynamic> json) =>
      _$FamilyEntityFromJson(json);
}
