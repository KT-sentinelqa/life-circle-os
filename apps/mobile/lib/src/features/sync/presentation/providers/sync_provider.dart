import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/core/storage/database_service.dart';
import 'package:lifecircle_mobile/src/features/sync/data/outbox/outbox_datasource.dart';
import 'package:lifecircle_mobile/src/features/sync/data/repositories/local_sync_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/data/sync_engine_service.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/repositories/sync_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/infrastructure/cloud_sync_client.dart';

/// Provider for the local sync repository.
final syncRepositoryProvider = Provider<SyncRepository>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return LocalSyncRepository(OutboxDatasource(dbService));
});

/// Provider for the Cloud Sync HTTP Client.
final cloudSyncClientProvider = Provider<CloudSyncClient>((ref) {
  final baseUrl = dotenv.env['API_URL'] ?? 'http://127.0.0.1:8000';
  final dio = Dio(BaseOptions(baseUrl: baseUrl));
  return HttpCloudSyncClient(dio);
});

/// Provider for the background sync engine service.
final syncEngineProvider = Provider<SyncEngineService>((ref) {
  final repository = ref.watch(syncRepositoryProvider);
  final cloudClient = ref.watch(cloudSyncClientProvider);
  final engine = SyncEngineService(
    repository,
    cloudClient,
    Connectivity(),
  );

  ref.onDispose(engine.dispose);

  return engine;
});
