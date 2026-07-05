import 'package:isar/isar.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/medicine_streak.dart';

part 'isar_medicine_streak.g.dart';

/// Isar collection mapping for [MedicineStreak].
@collection
class IsarMedicineStreak {
  /// Creates an empty [IsarMedicineStreak].
  IsarMedicineStreak();

  /// Creates this Isar model from a pure domain [MedicineStreak].
  IsarMedicineStreak.fromEntity(MedicineStreak entity) {
    id = entity.id;
    familyId = entity.familyId;
    memberId = entity.memberId;
    medicineId = entity.medicineId;
    currentStreak = entity.currentStreak;
    longestStreak = entity.longestStreak;
    lastPerfectDateUtc = entity.lastPerfectDateUtc;
  }

  /// Auto-incremented Isar ID.
  Id isarId = Isar.autoIncrement;

  /// Domain entity unique identifier.
  @Index(unique: true, replace: true)
  late String id;

  /// Family ID for scoped querying.
  @Index()
  late String familyId;

  /// Member ID for scoped querying.
  @Index()
  late String memberId;

  /// Associated medicine ID, if applicable.
  @Index()
  String? medicineId;

  /// The current streak.
  late int currentStreak;

  /// The historical longest streak.
  late int longestStreak;

  /// The most recent day of perfect adherence.
  DateTime? lastPerfectDateUtc;

  /// Converts this Isar model to a pure domain [MedicineStreak].
  MedicineStreak toEntity() {
    return MedicineStreak(
      id: id,
      familyId: familyId,
      memberId: memberId,
      medicineId: medicineId,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      lastPerfectDateUtc: lastPerfectDateUtc,
    );
  }
}
