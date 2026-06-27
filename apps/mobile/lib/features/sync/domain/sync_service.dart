/// LifeCircle OS — SyncService: offline outbox replay engine.
///
/// Watches connectivity and flushes the PENDING outbox to the server
/// whenever a network connection is available.
///
/// Last-Write-Wins (LWW) conflict resolution:
///   If [server_updated_at] > [client_created_at] for the same resource,
///   the server version is authoritative. The server sync endpoint returns
///   the winning timestamp in the response so the client can update local state.
///
/// Governed by: docs/mobile-architecture.md | LC-S1-007
library;

import 'dart:convert';

import 'package:dio/dio.dart';

import '../data/local/outbox_datasource.dart';
import '../data/local/outbox_entry.dart';

/// Result of a single outbox event sync attempt.
enum SyncResult { accepted, rejected, networkError }

/// Orchestrates offline outbox replay against the backend sync endpoint.
class SyncService {
  SyncService({
    required OutboxDatasource outboxDatasource,
    required Dio httpClient,
    required String syncEndpointUrl,
  })  : _outbox = outboxDatasource,
        _http = httpClient,
        _syncUrl = syncEndpointUrl;

  final OutboxDatasource _outbox;
  final Dio _http;
  final String _syncUrl;

  /// Flush all PENDING outbox entries to the server.
  ///
  /// For each entry:
  ///   1. POST to [_syncUrl] with idempotency_key header.
  ///   2. On 2xx → mark SYNCED.
  ///   3. On 4xx (client error) → mark FAILED immediately (no retry).
  ///   4. On 5xx / network error → mark FAILED (retry up to kMaxRetries times).
  ///
  /// Returns the number of entries successfully synced.
  Future<int> flush({String? jwtToken}) async {
    final pending = await _outbox.getPending();
    if (pending.isEmpty) return 0;

    int syncedCount = 0;

    for (final entry in pending) {
      final result = await _syncEntry(entry, jwtToken: jwtToken);
      switch (result) {
        case SyncResult.accepted:
          await _outbox.markSynced(entry.id);
          syncedCount++;
        case SyncResult.rejected:
          // 4xx — permanent failure; do not retry
          for (var i = 0; i < kMaxRetries; i++) {
            await _outbox.markFailed(entry.id);
          }
        case SyncResult.networkError:
          await _outbox.markFailed(entry.id);
      }
    }

    return syncedCount;
  }

  // ── Private ────────────────────────────────────────────────────────────────

  Future<SyncResult> _syncEntry(
    OutboxEntry entry, {
    String? jwtToken,
  }) async {
    try {
      final payload = jsonDecode(entry.payload) as Map<String, dynamic>;
      final response = await _http.post<Map<String, dynamic>>(
        _syncUrl,
        data: {
          'events': [
            {
              'id':              entry.id,
              'event_type':      entry.eventType,
              'payload':         payload,
              'idempotency_key': entry.idempotencyKey,
              'created_at':      entry.createdAt,
            },
          ],
        },
        options: Options(
          headers: {
            if (jwtToken != null) 'Authorization': 'Bearer $jwtToken',
            'X-API-Version': '1.0.0',
            'Idempotency-Key': entry.idempotencyKey,
          },
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      final statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) return SyncResult.accepted;
      if (statusCode >= 400 && statusCode < 500) return SyncResult.rejected;
      return SyncResult.networkError;
    } on DioException {
      return SyncResult.networkError;
    }
  }
}
