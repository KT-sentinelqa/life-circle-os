import 'package:isar/isar.dart';

part 'emergency_contact.g.dart';

/// Represents an emergency contact stored in Isar.
/// Fully available offline.
@collection
class EmergencyContact {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  late String name;
  late String role;
  late String phone;

  @Index()
  late String householdId;

  late DateTime createdAt;
  late DateTime updatedAt;
}
