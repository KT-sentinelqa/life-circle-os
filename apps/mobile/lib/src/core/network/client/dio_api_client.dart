import 'package:dio/dio.dart';

import 'package:lifecircle_mobile/src/core/network/client/api_client.dart';
import 'package:lifecircle_mobile/src/core/network/exceptions/authentication_exception.dart';
import 'package:lifecircle_mobile/src/core/network/exceptions/network_exception.dart';
import 'package:lifecircle_mobile/src/core/network/exceptions/server_exception.dart';

/// Dio-based implementation of [ApiClient].
class DioApiClient implements ApiClient {
  /// Creates a [DioApiClient].
  const DioApiClient(this.dio);

  /// The underlying Dio instance.
  final Dio dio;

  @override
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return _execute(
      () => dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      ),
    );
  }

  @override
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return _execute(
      () => dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      ),
    );
  }

  @override
  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return _execute(
      () => dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      ),
    );
  }

  @override
  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return _execute(
      () => dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      ),
    );
  }

  Future<T> _execute<T>(
    Future<Response<T>> Function() request,
  ) async {
    try {
      final response = await request();
      return response.data as T;
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        throw e.error! as NetworkException;
      }
      
      final statusCode = e.response?.statusCode;
      if (statusCode == 401 || statusCode == 403) {
        throw AuthenticationException(
          e.message ?? 'Authentication error',
        );
      } else if (statusCode != null && statusCode >= 500) {
        throw ServerException(
          e.message ?? 'Server error', 
          statusCode: statusCode,
        );
      } else {
        throw ServerException(
          e.message ?? 'Unknown network error', 
          statusCode: statusCode,
        );
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
