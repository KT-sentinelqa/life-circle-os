import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_status.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/medicine_streak.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/services/streak_engine.dart';

void main() {
  group('StreakEngine', () {
    late StreakEngine engine;
    late DateTime mockNow;

    setUp(() {
      mockNow = DateTime.utc(2026, 7, 5);
      engine = StreakEngine(nowProvider: () => mockNow);
    });

    test('increments streak on a perfect day', () {
      final record = AdherenceRecord(
        id: 'r1',
        familyId: 'f1',
        memberId: 'u1',
        dateUtc: DateTime.utc(2026, 7),
        dosesScheduled: 1,
        dosesTaken: 1,
        status: AdherenceStatus.perfect,
      );

      final previousStreak = MedicineStreak(
        id: 's1',
        familyId: 'f1',
        memberId: 'u1',
        currentStreak: 5,
        longestStreak: 10,
        lastPerfectDateUtc: DateTime.utc(2026, 6, 30),
      );

      final newStreak = engine.calculateNextStreak(
        newRecord: record,
        previousStreak: previousStreak,
      );

      expect(newStreak.currentStreak, 6);
      expect(newStreak.longestStreak, 10);
      expect(newStreak.lastPerfectDateUtc, DateTime.utc(2026, 7));
    });

    test('breaks streak on non-perfect day', () {
      final record = AdherenceRecord(
        id: 'r1',
        familyId: 'f1',
        memberId: 'u1',
        dateUtc: DateTime.utc(2026, 7),
        dosesScheduled: 1,
        dosesTaken: 0,
        dosesMissed: 1,
        status: AdherenceStatus.critical,
      );

      final previousStreak = MedicineStreak(
        id: 's1',
        familyId: 'f1',
        memberId: 'u1',
        currentStreak: 5,
        longestStreak: 10,
        lastPerfectDateUtc: DateTime.utc(2026, 6, 30),
      );

      final newStreak = engine.calculateNextStreak(
        newRecord: record,
        previousStreak: previousStreak,
      );

      expect(newStreak.currentStreak, 0);
      expect(newStreak.longestStreak, 10);
      // It retains the last perfect date, though the current streak is 0
      expect(newStreak.lastPerfectDateUtc, DateTime.utc(2026, 6, 30));
    });

    test('does not double count same day', () {
      final record = AdherenceRecord(
        id: 'r1',
        familyId: 'f1',
        memberId: 'u1',
        dateUtc: DateTime.utc(2026, 7),
        dosesScheduled: 2,
        dosesTaken: 2,
        status: AdherenceStatus.perfect,
      );

      final previousStreak = MedicineStreak(
        id: 's1',
        familyId: 'f1',
        memberId: 'u1',
        currentStreak: 5,
        longestStreak: 10,
        lastPerfectDateUtc: DateTime.utc(2026, 7),
      );

      final newStreak = engine.calculateNextStreak(
        newRecord: record,
        previousStreak: previousStreak,
      );

      expect(newStreak.currentStreak, 5); // Remained 5
      expect(newStreak.lastPerfectDateUtc, DateTime.utc(2026, 7));
    });
  });
}
