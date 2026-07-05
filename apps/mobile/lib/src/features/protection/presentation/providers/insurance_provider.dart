import 'package:lifecircle_mobile/src/features/protection/domain/entities/insurance_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'insurance_provider.g.dart';

/// Provides the current list of active insurance policies for the family.
@riverpod
Future<List<InsuranceEntity>> insuranceList(InsuranceListRef ref) async {
  final now = DateTime.now();
  return [
    InsuranceEntity(
      id: 'ins-1',
      name: 'Car Insurance',
      type: 'Vehicle',
      renewalDate: now.add(const Duration(days: 27)),
    ),
    InsuranceEntity(
      id: 'ins-2',
      name: 'Health Insurance',
      type: 'Health',
      renewalDate: now.add(const Duration(days: 54)),
    ),
  ];
}
