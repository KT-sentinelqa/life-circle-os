import 'network_exception.dart';

class ServerException extends NetworkException {
  const ServerException(super.message, {super.statusCode});
}
