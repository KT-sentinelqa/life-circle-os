import 'package:isar/isar.dart';

part 'family_peace_index.g.dart';

@collection
class FamilyPeaceIndex {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String householdId;

  late int overallScore; // 0 to 100

  late int healthScore;
  late int financeScore;
  late int householdScore;

  late DateTime lastCalculatedAt;
}
