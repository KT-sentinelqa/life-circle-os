import 'package:lifecircle_mobile/src/core/network/exceptions/network_exception.dart';

/// Exception thrown when the server returns an error (5xx or unknown).
class ServerException extends NetworkException {
  /// Creates a [ServerException].
  const ServerException(super.message, {super.statusCode});
}
