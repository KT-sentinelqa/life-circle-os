import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/core/storage/database_service.dart';
import 'package:lifecircle_mobile/src/features/adherence/data/repositories/local_adherence_repository.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/repositories/adherence_repository.dart';

/// Provides the AdherenceRepository implementation.
final adherenceRepositoryProvider = Provider<AdherenceRepository>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return LocalAdherenceRepository(dbService);
});
