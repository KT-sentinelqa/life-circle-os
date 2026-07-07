import 'package:lifecircle_mobile/src/features/finance/domain/entities/emi_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'emi_provider.g.dart';

/// Provides the current list of active EMI obligations for the family.
@riverpod
Future<List<EmiEntity>> emiList(EmiListRef ref) async {
  // Hardcoded presentation stub for Showcase (Sprint 2.4)
  final now = DateTime.now();
  return [
    EmiEntity(
      id: 'emi-1',
      name: 'Car Loan',
      amount: 16674,
      dueDate: now.add(const Duration(days: 3)),
    ),
    EmiEntity(
      id: 'emi-2',
      name: 'Home Loan',
      amount: 45000,
      dueDate: now.add(const Duration(days: 15)),
    ),
    EmiEntity(
      id: 'emi-3',
      name: 'School Fee',
      amount: 12500,
      dueDate: now.add(const Duration(days: 10)),
    ),
    EmiEntity(
      id: 'emi-4',
      name: 'Electricity Bill',
      amount: 3200,
      dueDate: now.add(const Duration(days: 4)),
    ),
  ];
}
