import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/time/app_clock.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/entities/user.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/dosage_schedule_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/repositories/medicine_repository.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_form_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockMedicineRepository extends Mock implements MedicineRepository {}
class MockAppClock extends Mock implements AppClock {}

class FakeMedicineEntity extends Fake implements MedicineEntity {}
class FakeDosageScheduleEntity extends Fake implements DosageScheduleEntity {}

class MockAuth extends Auth {
  @override
  AsyncValue<User?> build() {
    return const AsyncValue.data(
      User(
        id: 'u1', 
        name: 'Test', 
        email: 'test@test.com', 
        familyId: 'f1',
      ),
    );
  }
}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeMedicineEntity());
    registerFallbackValue(FakeDosageScheduleEntity());
  });

  group('MedicineFormNotifier', () {
    late MockMedicineRepository mockRepo;
    late MockAppClock mockClock;
    late ProviderContainer container;

    setUp(() {
      mockRepo = MockMedicineRepository();
      mockClock = MockAppClock();
      
      when(() => mockClock.now()).thenReturn(DateTime.parse('2026-01-01'));
      when(() => mockRepo.getMedicines(any(), any()))
          .thenAnswer((_) async => []);
      
      container = ProviderContainer(
        overrides: [
          authProvider.overrideWith(MockAuth.new),
          medicineRepositoryProvider.overrideWithValue(mockRepo),
          appClockProvider.overrideWithValue(mockClock),
        ],
      );
    });

    test('saveMedicine saves and refreshes', () async {
      when(() => mockRepo.saveMedicine(any(), any())).thenAnswer((_) async {});
      
      final notifier = container.read(medicineFormProvider.notifier);
      await notifier.saveMedicine(
        name: 'Aspirin',
        dosage: '100mg',
        form: 'Pill',
        instructions: 'Take with water',
        frequencyPerDay: 2,
      );

      verify(() => mockRepo.saveMedicine(any(), any()));
      verify(() => mockRepo.getMedicines('f1', 'u1')).called(2);
    });
    
    test('deleteMedicine deletes and refreshes', () async {
      when(() => mockRepo.deleteMedicine(any())).thenAnswer((_) async {});
      
      final notifier = container.read(medicineFormProvider.notifier);
      await notifier.deleteMedicine('m1');

      verify(() => mockRepo.deleteMedicine('m1'));
      verify(() => mockRepo.getMedicines('f1', 'u1')).called(2);
    });
  });
}
