import 'package:lifecircle_mobile/src/core/network/exceptions/network_exception.dart';

/// Exception thrown when authentication fails (e.g. 401 Unauthorized).
class AuthenticationException extends NetworkException {
  /// Creates an [AuthenticationException].
  const AuthenticationException([super.message = 'Authentication failed']) 
      : super(statusCode: 401);
}
