import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/time/app_clock.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/entities/user.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_status.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/repositories/medicine_repository.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/today_reminders_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockMedicineRepository extends Mock implements MedicineRepository {}

class MockAppClock extends Mock implements AppClock {}

class MockAuth extends Auth {
  @override
  AsyncValue<User?> build() => const AsyncValue.data(
        User(
          id: 'u1',
          name: 'Test User',
          email: 'test@example.com',
          familyId: 'f1',
        ),
      );
}

void main() {
  group('TodayRemindersNotifier', () {
    late MockMedicineRepository mockRepo;
    late MockAppClock mockClock;
    late ProviderContainer container;

    setUp(() {
      mockRepo = MockMedicineRepository();
      mockClock = MockAppClock();

      final now = DateTime.utc(2026, 1, 1, 12); // Noon
      when(() => mockClock.now()).thenReturn(now);

      when(
        () => mockRepo.getRemindersByStatuses(
          any(),
          any(),
          any(),
        ),
      ).thenAnswer((_) async => []);

      container = ProviderContainer(
        overrides: [
          authProvider.overrideWith(MockAuth.new),
          medicineRepositoryProvider.overrideWithValue(mockRepo),
          appClockProvider.overrideWithValue(mockClock),
        ],
      );
    });

    test('fetches reminders for today', () async {
      final now = mockClock.now();

      final reminders = [
        ReminderEntity(
          id: 'r1',
          medicineId: 'm1',
          familyId: 'f1',
          memberId: 'u1',
          scheduledTimeUtc: DateTime.utc(2026, 1, 1, 8),
          status: ReminderStatus.missed,
          createdAt: now,
          updatedAt: now,
        ),
        ReminderEntity(
          id: 'r2',
          medicineId: 'm2',
          familyId: 'f1',
          memberId: 'u1',
          scheduledTimeUtc: DateTime.utc(2026, 1, 1, 20),
          createdAt: now,
          updatedAt: now,
        ),
      ];

      when(() => mockRepo.getRemindersForDate('f1', 'u1', now))
          .thenAnswer((_) async => reminders);

      final state = await container.read(todayRemindersProvider.future);

      expect(state.length, 2);
      expect(state.first.status, ReminderStatus.missed);
      expect(state.last.status, ReminderStatus.pending);

      verify(() => mockRepo.getRemindersForDate('f1', 'u1', now)).called(1);
    });

    test('takeReminder marks as completed and refreshes', () async {
      final now = mockClock.now();
      when(() => mockRepo.markReminderCompleted('r1', now))
          .thenAnswer((_) async {});
      when(() => mockRepo.getRemindersForDate('f1', 'u1', now))
          .thenAnswer((_) async => []);

      final notifier = container.read(todayRemindersProvider.notifier);
      await notifier.takeReminder('r1');

      verify(() => mockRepo.markReminderCompleted('r1', now)).called(1);
      verify(() => mockRepo.getRemindersForDate('f1', 'u1', now))
          .called(2); // Initial build + refresh
    });

    test('skipReminder marks as skipped and refreshes', () async {
      final now = mockClock.now();
      when(() => mockRepo.markReminderSkipped('r1', now))
          .thenAnswer((_) async {});
      when(() => mockRepo.getRemindersForDate('f1', 'u1', now))
          .thenAnswer((_) async => []);

      final notifier = container.read(todayRemindersProvider.notifier);
      await notifier.skipReminder('r1');

      verify(() => mockRepo.markReminderSkipped('r1', now)).called(1);
    });

    test('snoozeReminder snoozes and refreshes', () async {
      final now = mockClock.now();
      const duration = Duration(minutes: 15);
      when(() => mockRepo.snoozeReminder('r1', duration))
          .thenAnswer((_) async {});
      when(() => mockRepo.getRemindersForDate('f1', 'u1', now))
          .thenAnswer((_) async => []);

      final notifier = container.read(todayRemindersProvider.notifier);
      await notifier.snoozeReminder('r1', duration);

      verify(() => mockRepo.snoozeReminder('r1', duration)).called(1);
    });
  });
}
