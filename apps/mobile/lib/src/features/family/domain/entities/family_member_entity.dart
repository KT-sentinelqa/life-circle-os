import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_member_entity.freezed.dart';
part 'family_member_entity.g.dart';

enum MemberRole { admin, standard }

@freezed
class FamilyMemberEntity with _$FamilyMemberEntity {
  const factory FamilyMemberEntity({
    required String id,
    required String userId,
    required String familyId,
    @Default(MemberRole.standard) MemberRole role,
  }) = _FamilyMemberEntity;

  factory FamilyMemberEntity.fromJson(Map<String, dynamic> json) => _$FamilyMemberEntityFromJson(json);
}
