import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// Implements SEC-028 Analytics Privacy Policy.
/// Ensure no PII is transmitted in telemetry.
class AnalyticsService {
  AnalyticsService({bool isOptedOut = false}) : _isOptedOut = isOptedOut;
  final bool _isOptedOut;

  /// Logs a behavior event without PII.
  Future<void> logEvent(
    String eventName,
    Map<String, dynamic> properties,
  ) async {
    if (_isOptedOut) return;

    // SEC-028 Guard: Strip any accidental PII strings
    final safeProperties = _sanitizeProperties(properties);

    final payload = {
      'event': eventName,
      'properties': safeProperties,
      'timestamp': DateTime.now().toUtc().toIso8601String(),
    };

    // In a real implementation, this pushes to a privacy-first sink like PostHog or a custom DB.
    if (kDebugMode) {
      developer.log('[Analytics] Logged: ${jsonEncode(payload)}');
    }
  }

  Map<String, dynamic> _sanitizeProperties(Map<String, dynamic> raw) {
    final clean = <String, dynamic>{};
    for (final entry in raw.entries) {
      // Allow known safe types
      if (entry.value is bool || entry.value is num) {
        clean[entry.key] = entry.value;
      }
      // Only allow strings if they are UUIDs, enums (e.g. category names), or known safe values.
      // We drop free-text strings to avoid accidental PII leakage.
      else if (entry.value is String) {
        final val = entry.value as String;
        if (_isSafeString(val)) {
          clean[entry.key] = val;
        } else {
          clean[entry.key] = '[REDACTED]';
        }
      }
    }
    return clean;
  }

  bool _isSafeString(String val) {
    // Basic UUID check
    final uuidRegex = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
      caseSensitive: false,
    );
    if (uuidRegex.hasMatch(val)) return true;

    // Known categories
    final knownCategories = ['health', 'finance', 'household', 'event'];
    if (knownCategories.contains(val.toLowerCase())) return true;

    // Allow simple discrete status values
    final knownStatuses = ['pending', 'completed', 'escalated', 'dueSoon'];
    if (knownStatuses.contains(val)) return true;

    return false;
  }
}
