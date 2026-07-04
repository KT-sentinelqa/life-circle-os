import 'package:dio/dio.dart';
import 'dart:io';

class RetryPolicy {
  final int maxAttempts;
  final Set<int> retryableStatuses;
  final Set<int> nonRetryableStatuses;

  const RetryPolicy({
    this.maxAttempts = 3,
    this.retryableStatuses = const {429, 500, 502, 503, 504},
    this.nonRetryableStatuses = const {400, 401, 403, 404, 422},
  });

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
