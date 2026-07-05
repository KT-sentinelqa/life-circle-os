import 'dart:io';

import 'package:dio/dio.dart';

/// Defines the policy for retrying failed network requests.
class RetryPolicy {
  /// Creates a [RetryPolicy].
  const RetryPolicy({
    this.maxAttempts = 3,
    this.retryableStatuses = const <int>{429, 500, 502, 503, 504},
    this.nonRetryableStatuses = const <int>{400, 401, 403, 404, 422},
  });

  /// The maximum number of retry attempts.
  final int maxAttempts;

  /// The HTTP status codes that should be retried.
  final Set<int> retryableStatuses;

  /// The HTTP status codes that should not be retried.
  final Set<int> nonRetryableStatuses;

  /// Evaluates whether a request should be retried based on the error.
  bool shouldRetry(DioException error, int attempt) {
    if (attempt >= maxAttempts) return false;

    if (error.error is SocketException) return true;

    final statusCode = error.response?.statusCode;
    if (statusCode == null) {
      return error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout;
    }

    if (nonRetryableStatuses.contains(statusCode)) return false;
    if (retryableStatuses.contains(statusCode)) return true;

    return false;
  }
}
