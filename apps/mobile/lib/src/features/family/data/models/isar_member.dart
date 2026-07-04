import 'package:isar/isar.dart';
import 'package:lifecircle_mobile/src/core/utils/hash.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_member_entity.dart';

part 'isar_member.g.dart';

@collection
class IsarMember {
  Id get internalId => fastHash(id);

  late String id;
  @Index()
  late String userId;
  @Index()
  late String familyId;
  @Enumerated(EnumType.name)
  late MemberRole role;

  FamilyMemberEntity toDomain() {
    return FamilyMemberEntity(
      id: id,
      userId: userId,
      familyId: familyId,
      role: role,
    );
  }

  static IsarMember fromDomain(FamilyMemberEntity member) {
    return IsarMember()
      ..id = member.id
      ..userId = member.userId
      ..familyId = member.familyId
      ..role = member.role;
  }
}
