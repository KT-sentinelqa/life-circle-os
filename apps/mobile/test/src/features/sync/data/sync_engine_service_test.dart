import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/sync/data/sync_engine_service.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/outbox_entry_entity.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/repositories/sync_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/infrastructure/cloud_sync_client.dart';
import 'package:mocktail/mocktail.dart';

class MockSyncRepository extends Mock implements SyncRepository {}

class MockCloudSyncClient extends Mock implements CloudSyncClient {}

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  group('SyncEngineService', () {
    late MockSyncRepository mockSyncRepository;
    late MockCloudSyncClient mockCloudSyncClient;
    late MockConnectivity mockConnectivity;
    late StreamController<List<ConnectivityResult>> connectivityController;

    setUp(() {
      mockSyncRepository = MockSyncRepository();
      mockCloudSyncClient = MockCloudSyncClient();
      mockConnectivity = MockConnectivity();
      connectivityController = StreamController<List<ConnectivityResult>>();

      when(() => mockConnectivity.onConnectivityChanged)
          .thenAnswer((_) => connectivityController.stream);
    });

    tearDown(() {
      connectivityController.close();
    });

    test('Triggers sync when connectivity becomes online', () async {
      when(mockSyncRepository.getPendingEntries)
          .thenAnswer((_) async => <OutboxEntryEntity>[]);

      final engine = SyncEngineService(
        mockSyncRepository,
        mockCloudSyncClient,
        mockConnectivity,
      );

      // Simulate coming online via WiFi
      connectivityController.add(
        const <ConnectivityResult>[ConnectivityResult.wifi],
      );

      // Wait for stream to process
      await Future<void>.delayed(Duration.zero);

      verify(mockSyncRepository.getPendingEntries).called(1);
      engine.dispose();
    });
  });
}
