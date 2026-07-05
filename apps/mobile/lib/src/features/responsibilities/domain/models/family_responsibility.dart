import 'package:isar/isar.dart';
import 'responsibility_category.dart';
import 'responsibility_status.dart';

part 'family_responsibility.g.dart';

@collection
class FamilyResponsibility {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  late String name;

  @Enumerated(EnumType.name)
  late ResponsibilityCategory category;

  @Index()
  late String primaryOwnerId;

  @Index()
  String? backupOwnerId;

  @Enumerated(EnumType.name)
  late ResponsibilityStatus status;

  late DateTime dueDate;

  int escalationDelayMinutes = 30;

  String? completionEvidenceUri;

  int confidenceScore = 100;

  late DateTime createdAt;
  late DateTime updatedAt;
}
