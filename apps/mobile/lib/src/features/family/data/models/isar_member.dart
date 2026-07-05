import 'package:isar/isar.dart';

import 'package:lifecircle_mobile/src/core/utils/hash.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_member_entity.dart';

part 'isar_member.g.dart';

/// Isar collection representing a [FamilyMemberEntity].
@collection
class IsarMember {
  /// Creates an [IsarMember].
  IsarMember();

  /// Creates an [IsarMember] from a [FamilyMemberEntity].
  factory IsarMember.fromDomain(FamilyMemberEntity member) {
    return IsarMember()
      ..id = member.id
      ..userId = member.userId
      ..familyId = member.familyId
      ..role = member.role;
  }

  /// The internal Isar ID based on the UUID hash.
  Id get internalId => fastHash(id);

  /// The UUID of the member record.
  late String id;

  /// The UUID of the user.
  @Index()
  late String userId;

  /// The UUID of the family.
  @Index()
  late String familyId;

  /// The role of the member.
  @Enumerated(EnumType.name)
  late MemberRole role;

  /// Converts this Isar model to a [FamilyMemberEntity].
  FamilyMemberEntity toDomain() {
    return FamilyMemberEntity(
      id: id,
      userId: userId,
      familyId: familyId,
      role: role,
    );
  }
}
