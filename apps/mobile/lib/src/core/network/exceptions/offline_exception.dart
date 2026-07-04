import 'network_exception.dart';

class OfflineException extends NetworkException {
  const OfflineException([super.message = 'No internet connection available.']);
}
