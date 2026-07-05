import 'package:lifecircle_mobile/src/core/storage/database_service.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/services/demo_seed_engine.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'demo_seed_provider.g.dart';

/// Provides the [DemoSeedEngine].
@riverpod
DemoSeedEngine demoSeedEngine(DemoSeedEngineRef ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return DemoSeedEngine(databaseService: dbService);
}
