import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_entity.dart';
import 'package:lifecircle_mobile/src/features/family/domain/repositories/family_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockFamilyRepository extends Mock implements FamilyRepository {}

void main() {
  group('FamilyRepository', () {
    late MockFamilyRepository mockRepository;

    setUp(() {
      mockRepository = MockFamilyRepository();
    });

    test('createFamily returns a valid FamilyEntity', () async {
      final mockFamily = FamilyEntity(
        id: 'uuid-1234',
        name: 'Test Family',
        createdAt: DateTime.now(),
      );

      when(() => mockRepository.createFamily(any<String>()))
          .thenAnswer((_) async => mockFamily);

      final family = await mockRepository.createFamily('Test Family');

      expect(family.name, equals('Test Family'));
      expect(family.id, equals('uuid-1234'));
      verify(() => mockRepository.createFamily('Test Family')).called(1);
    });
  });
}
