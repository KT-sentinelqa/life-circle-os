import 'package:isar/isar.dart';

part 'feature_flag.g.dart';

@collection
class FeatureFlag {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String key;

  late bool isEnabled;

  /// Optional cohort targeting (e.g., 'beta_testers', 'household-123')
  String? targetCohort;

  late DateTime updatedAt;
}
