import 'package:flutter_test/flutter_test.dart';

import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';

void main() {
  test('MedicineEntity requires familyId and memberId (RULE-043)', () {
    final entity = MedicineEntity(
      id: 'm1',
      familyId: 'f1',
      memberId: 'mem1',
      name: 'Aspirin',
      dosage: '100mg',
      form: 'Pill',
      instructions: 'Take with water',
      createdAtUtc: DateTime.utc(2026),
      updatedAtUtc: DateTime.utc(2026),
    );

    expect(entity.familyId, 'f1');
    expect(entity.memberId, 'mem1');
  });
}
