import 'package:dio/dio.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/models/sync_event.dart';

/// Interface representing the eventual FastAPI Cloud Runtime (Phase 4.4C)
abstract class CloudSyncClient {
  /// Pushes an Outbox event to the Cloud. Returns true if ACK'd.
  Future<bool> pushEvent(SyncEvent event);

  /// Fetches new events from the Cloud Inbox.
  Future<List<SyncEvent>> fetchEvents(String lastSyncToken);
}

/// Real HTTP client connecting to FastAPI local backend for Phase L0.1
class HttpCloudSyncClient implements CloudSyncClient {
  HttpCloudSyncClient(this._dio);
  final Dio _dio;

  @override
  Future<bool> pushEvent(SyncEvent event) async {
    try {
      // In L0.1, we POST sync events to the local FastAPI outbox (if it exists)
      // or simply ACK it. For now, we attempt POST /api/v1/sync/events
      final response = await _dio.post<dynamic>(
        '/api/v1/sync/events',
        data: event.toJson(),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      // If the backend endpoint doesn't exist yet, we catch the error
      // but still return false so the local app knows sync failed.
      return false;
    }
  }

  @override
  Future<List<SyncEvent>> fetchEvents(String lastSyncToken) async {
    try {
      final response = await _dio.get<dynamic>(
        '/api/v1/sync/events',
        queryParameters: {'since': lastSyncToken},
      );
      if (response.data is List) {
        return (response.data as List)
            .map((e) => SyncEvent.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
