import 'dart:math';
import 'package:dio/dio.dart';
import 'package:lifecircle_mobile/src/features/network/domain/request_context.dart';
import 'package:lifecircle_mobile/src/features/network/application/signing_service.dart';
import 'package:lifecircle_mobile/src/features/network/domain/network_audit_event.dart';

/// 1. Context Interceptor
class ContextInterceptor extends Interceptor {
  ContextInterceptor(this.contextProvider);

  final RequestContext Function() contextProvider;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final context = contextProvider();
    options.headers.addAll(context.toHeaders());
    // Attach context to extra for downstream interceptors
    options.extra['requestContext'] = context;
    super.onRequest(options, handler);
  }
}

/// 2. Signature Interceptor
class SignatureInterceptor extends Interceptor {
  SignatureInterceptor(this.signingService);

  final SigningService signingService;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final context = options.extra['requestContext'] as RequestContext?;
    if (context == null) {
      return super.onRequest(options, handler);
    }

    final rawJsonBody = options.data != null ? options.data.toString() : '';
    final canonicalBody = signingService.canonicalizeJson(rawJsonBody);
    
    // Sort query parameters
    final sortedQueryKeys = options.queryParameters.keys.toList()..sort();
    final queryBuffer = StringBuffer();
    for (var key in sortedQueryKeys) {
      queryBuffer.write('$key=${options.queryParameters[key]}&');
    }
    final queryStr = queryBuffer.toString();

    final signature = await signingService.signCanonicalRequest(
      method: options.method.toUpperCase(),
      uri: options.uri.path,
      query: queryStr,
      keyId: context.keyId,
      nonce: context.nonce,
      timestamp: context.timestamp.toIso8601String(),
      requestId: context.requestId,
      canonicalJsonBody: canonicalBody,
    );

    options.headers['X-Signature'] = signature;
    super.onRequest(options, handler);
  }
}

/// 3. Replay Protection Interceptor (Client Side generation check)
class ReplayProtectionInterceptor extends Interceptor {
  // Mostly a server-side concern, but client can ensure nonces are globally unique.
  final Set<String> _usedNonces = {};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final nonce = options.headers['X-Nonce'] as String?;
    if (nonce != null) {
      if (_usedNonces.contains(nonce)) {
        handler.reject(DioException(
          requestOptions: options,
          error: 'ReplayProtection: Duplicate nonce generated locally.',
        ));
        return;
      }
      _usedNonces.add(nonce);
    }
    super.onRequest(options, handler);
  }
}

/// 4. Retry Policy Interceptor
class RetryPolicyInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final status = err.response?.statusCode;
    if (status == 429 || status == 503) {
      // Logic for Exponential Backoff would go here
      // e.g. schedule retry and resolve handler
    }
    super.onError(err, handler);
  }
}

/// 5. Telemetry Interceptor
class TelemetryInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logEvent(response.requestOptions, response.statusCode ?? 200, true);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logEvent(err.requestOptions, err.response?.statusCode ?? 0, false);
    super.onError(err, handler);
  }

  void _logEvent(RequestOptions options, int status, bool success) {
    final context = options.extra['requestContext'] as RequestContext?;
    final event = NetworkAuditEvent(
      requestId: context?.requestId ?? 'unknown',
      traceId: context?.traceId ?? 'unknown',
      endpoint: options.uri.path,
      latencyMs: 120, // Mock calculation
      tlsVersion: 'TLS 1.3', // Handled native, mocked here
      cipherSuite: 'TLS_AES_256_GCM_SHA384',
      pinValidationSuccess: true, // Native handles drops
      trustLevel: context?.trustLevel ?? 'unknown',
      attestationLevel: context?.attestationId != null ? 'verified' : 'none',
      retryCount: 0,
      serverRegion: 'us-east-1',
      httpStatus: status,
      signatureVerificationSuccess: success, // Server validates
    );
    // Print or stream to observability core
    print('Audit: ${event.endpoint} [${event.httpStatus}]');
  }
}
