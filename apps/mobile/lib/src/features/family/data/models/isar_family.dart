import 'package:isar/isar.dart';

import 'package:lifecircle_mobile/src/core/utils/hash.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_entity.dart';

part 'isar_family.g.dart';

/// Isar collection representing a [FamilyEntity].
@collection
class IsarFamily {
  /// Creates an [IsarFamily].
  IsarFamily();

  /// Creates an [IsarFamily] from a [FamilyEntity].
  factory IsarFamily.fromDomain(FamilyEntity family) {
    return IsarFamily()
      ..id = family.id
      ..name = family.name
      ..createdAt = family.createdAt;
  }

  /// The internal Isar ID based on the UUID hash.
  Id get internalId => fastHash(id);

  /// The UUID of the family.
  late String id;
  
  /// The name of the family.
  late String name;
  
  /// The time the family was created.
  late DateTime createdAt;

  /// Converts this Isar model to a [FamilyEntity].
  FamilyEntity toDomain() {
    return FamilyEntity(
      id: id,
      name: name,
      createdAt: createdAt,
    );
  }
}
