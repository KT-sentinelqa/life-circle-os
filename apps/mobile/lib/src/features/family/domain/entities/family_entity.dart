import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_entity.freezed.dart';
part 'family_entity.g.dart';

@freezed
class FamilyEntity with _$FamilyEntity {
  const factory FamilyEntity({
    required String id,
    required String name,
    required DateTime createdAt,
  }) = _FamilyEntity;

  factory FamilyEntity.fromJson(Map<String, dynamic> json) => _$FamilyEntityFromJson(json);
}
