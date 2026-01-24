import 'package:flutter/foundation.dart';
import 'package:glow_core/glow_core.dart';
import 'package:glow_observability/glow_observability.dart';

/// Handles application errors.
class ErrorHandler {
  const ErrorHandler({Logger? logger})
      : _logger = logger ?? const ConsoleLogger();

  final Logger _logger;

  /// Handles generic errors.
  bool handleError(Object error, StackTrace stack) {
    _logger.error(
      'Uncaught error',
      error,
      stack,
    );

    // TODO: Send to crash reporting service (Firebase Crashlytics, Sentry, etc.)
    return true;
  }

  /// Handles Flutter framework errors.
  void handleFlutterError(FlutterErrorDetails details) {
    FlutterError.presentError(details);

    _logger.error(
      'Flutter error',
      details.exception,
      details.stack,
    );

    // TODO: Send to crash reporting service
  }
}
