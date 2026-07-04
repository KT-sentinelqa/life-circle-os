import 'package:lifecircle_mobile/src/core/network/exceptions/network_exception.dart';

/// Exception thrown when the device is offline.
class OfflineException extends NetworkException {
  /// Creates an [OfflineException].
  const OfflineException([super.message = 'No internet connection available.']);
}
