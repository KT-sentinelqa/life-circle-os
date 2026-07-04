import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/core/storage/database_service.dart';
import 'package:lifecircle_mobile/src/features/sync/data/outbox/outbox_datasource.dart';
import 'package:lifecircle_mobile/src/features/sync/data/repositories/local_sync_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/data/sync_engine_service.dart';

final syncRepositoryProvider = Provider((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return LocalSyncRepository(OutboxDatasource(dbService));
});

final syncEngineProvider = Provider((ref) {
  final repository = ref.watch(syncRepositoryProvider);
  final engine = SyncEngineService(
    repository,
    Connectivity(),
  );
  
  ref.onDispose(() {
    engine.dispose();
  });
  
  return engine;
});
