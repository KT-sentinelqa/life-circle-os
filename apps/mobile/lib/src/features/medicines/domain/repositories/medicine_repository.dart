import 'package:lifecircle_mobile/src/features/medicines/domain/aggregates/medicine_aggregate.dart';

abstract class MedicineRepository {
  Future<void> save(MedicineAggregate aggregate);
  Future<MedicineAggregate?> getById(String medicineId);
}
