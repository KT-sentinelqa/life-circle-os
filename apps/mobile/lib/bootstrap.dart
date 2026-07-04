import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/src/core/services/logger_service.dart';

/// Initializes the application and global error handlers.
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    logger.e(
      details.exceptionAsString(),
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  runApp(
    ProviderScope(
      child: await builder(),
    ),
  );
}
