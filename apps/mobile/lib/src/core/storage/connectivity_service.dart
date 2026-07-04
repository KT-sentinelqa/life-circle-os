import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the [ConnectivityService].
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService(Connectivity());
});

/// Service to monitor network connectivity status.
class ConnectivityService {
  /// Creates a [ConnectivityService].
  const ConnectivityService(this._connectivity);

  final Connectivity _connectivity;

  /// Returns a stream of connectivity results.
  Stream<List<ConnectivityResult>> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged;
  }

  /// Checks the current connectivity status.
  Future<List<ConnectivityResult>> checkConnectivity() async {
    return _connectivity.checkConnectivity();
  }

  /// Helper to determine if currently online.
  Future<bool> isOnline() async {
    final results = await checkConnectivity();
    return results.any((result) => result != ConnectivityResult.none);
  }
}
