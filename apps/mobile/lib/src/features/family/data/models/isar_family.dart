import 'package:isar/isar.dart';
import 'package:lifecircle_mobile/src/core/utils/hash.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_entity.dart';

part 'isar_family.g.dart';

@collection
class IsarFamily {
  Id get internalId => fastHash(id);

  late String id;
  late String name;
  late DateTime createdAt;

  FamilyEntity toDomain() {
    return FamilyEntity(
      id: id,
      name: name,
      createdAt: createdAt,
    );
  }

  static IsarFamily fromDomain(FamilyEntity family) {
    return IsarFamily()
      ..id = family.id
      ..name = family.name
      ..createdAt = family.createdAt;
  }
}
