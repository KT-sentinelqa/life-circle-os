import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'peace_index_service.dart';
import '../../responsibilities/application/responsibility_providers.dart';

final peaceIndexServiceProvider = Provider<PeaceIndexService>((ref) {
  return PeaceIndexService();
});

/// Reactively calculates the Family Peace Index (ADR-022)
final peaceIndexProvider = Provider.family<int, String>((ref, currentUserId) {
  final responsibilitiesAsync = ref.watch(familyResponsibilitiesProvider);
  final service = ref.watch(peaceIndexServiceProvider);
  
  return responsibilitiesAsync.maybeWhen(
    data: (responsibilities) => service.calculateContextualIndex(currentUserId, responsibilities),
    orElse: () => 100, // Default optimistic state
  );
});
