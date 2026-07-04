import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_member_entity.freezed.dart';
part 'family_member_entity.g.dart';

/// Represents the role of a family member.
enum MemberRole { 
  /// Administrator of the family.
  admin, 
  
  /// Standard member of the family.
  standard,
}

/// Represents a member of a family.
@freezed
class FamilyMemberEntity with _$FamilyMemberEntity {
  /// Creates a [FamilyMemberEntity].
  const factory FamilyMemberEntity({
    /// Unique identifier for the member record.
    required String id,
    
    /// The associated user ID.
    required String userId,
    
    /// The associated family ID.
    required String familyId,
    
    /// The role of the member.
    @Default(MemberRole.standard) MemberRole role,
  }) = _FamilyMemberEntity;

  /// Creates a [FamilyMemberEntity] from a JSON object.
  factory FamilyMemberEntity.fromJson(Map<String, dynamic> json) => 
      _$FamilyMemberEntityFromJson(json);
}
