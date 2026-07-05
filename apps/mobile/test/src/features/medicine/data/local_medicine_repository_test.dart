import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/storage/database_service.dart';
import 'package:lifecircle_mobile/src/core/time/app_clock.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/repositories/local_medicine_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockDatabaseService extends Mock implements DatabaseService {}

class MockAppClock extends Mock implements AppClock {}

void main() {
  test('LocalMedicineRepository injects Clock abstraction', () {
    final db = MockDatabaseService();
    final clock = MockAppClock();
    final repository = LocalMedicineRepository(db, clock);
    expect(repository.clock, clock);
  });
}
