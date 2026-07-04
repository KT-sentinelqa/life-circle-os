import 'network_exception.dart';

class AuthenticationException extends NetworkException {
  const AuthenticationException([super.message = 'Authentication failed']) : super(statusCode: 401);
}
