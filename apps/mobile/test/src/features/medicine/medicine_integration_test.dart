import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/notifications/implementations/local_notification_service.dart';
import 'package:lifecircle_mobile/src/core/notifications/providers/notification_provider.dart';
import 'package:lifecircle_mobile/src/core/time/app_clock.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/entities/user.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/repositories/local_medicine_repository.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/dosage_schedule_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_form_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockAuth extends Auth {
  @override
  AsyncValue<User?> build() {
    return const AsyncValue.data(
      User(
        id: 'u1',
        name: 'Test User',
        email: 'test@test.com',
        familyId: 'f1',
      ),
    );
  }
}

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

class MockLocalMedicineRepository extends Mock
    implements LocalMedicineRepository {}

class MockAppClock extends Mock implements AppClock {}

class FakeMedicineEntity extends Fake implements MedicineEntity {}
class FakeDosageScheduleEntity extends Fake implements DosageScheduleEntity {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeMedicineEntity());
    registerFallbackValue(FakeDosageScheduleEntity());
  });

  group('Medicine Integration Test', () {
    late MockFlutterLocalNotificationsPlugin mockPlugin;
    late LocalNotificationService notificationService;
    late MockLocalMedicineRepository mockRepo;
    late MockAppClock mockClock;
    late ProviderContainer container;

    setUp(() {
      mockPlugin = MockFlutterLocalNotificationsPlugin();
      notificationService = LocalNotificationService(mockPlugin);
      mockRepo = MockLocalMedicineRepository();
      mockClock = MockAppClock();

      when(() => mockClock.now()).thenReturn(DateTime.utc(2026));
      when(() => mockRepo.saveMedicine(any(), any()))
          .thenAnswer((_) async {});
      when(() => mockRepo.getMedicines(any(), any()))
          .thenAnswer((_) async => []);

      container = ProviderContainer(
        overrides: [
          authProvider.overrideWith(MockAuth.new),
          medicineRepositoryProvider.overrideWithValue(mockRepo),
          notificationServiceProvider.overrideWithValue(notificationService),
          appClockProvider.overrideWithValue(mockClock),
        ],
      );
    });

    test('Saving medicine generates reminders', () async {
      final notifier = container.read(medicineFormProvider.notifier);

      await notifier.saveMedicine(
        name: 'Antibiotics',
        dosage: '500mg',
        form: 'Tablet',
        instructions: 'After meal',
        frequencyPerDay: 2,
        remindersEnabled: true,
        timesOfDay: ['09:00', '21:00'],
      );

      final pending = notificationService.getPendingRequests();
      // 2 doses * 7 days = 14 requests
      expect(pending.isNotEmpty, isTrue);
      expect(pending.length, 14);

      final firstRequest = pending.first;
      expect(firstRequest.title, 'Time for Antibiotics');
      expect(firstRequest.body, 'Please take your scheduled dose of 500mg.');
    });

    test('Saving medicine with reminders disabled queues nothing', () async {
      final notifier = container.read(medicineFormProvider.notifier);

      await notifier.saveMedicine(
        name: 'Vitamins',
        dosage: '1 pill',
        form: 'Pill',
        instructions: 'Morning',
        frequencyPerDay: 1,
        remindersEnabled: false,
        timesOfDay: ['08:00'],
      );

      final pending = notificationService.getPendingRequests();
      expect(pending.isEmpty, isTrue);
    });
  });
}
