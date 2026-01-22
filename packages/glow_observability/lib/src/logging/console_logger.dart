import 'dart:developer' as developer;

import 'package:glow_core/glow_core.dart';

/// Console logger implementation.
class ConsoleLogger implements Logger {
  const ConsoleLogger();

  @override
  void debug(String message, [Map<String, dynamic>? metadata]) {
    developer.log(message, name: 'DEBUG');
  }

  @override
  void info(String message, [Map<String, dynamic>? metadata]) {
    developer.log(message, name: 'INFO');
  }

  @override
  void warning(String message, [Map<String, dynamic>? metadata]) {
    developer.log(message, name: 'WARNING');
  }

  @override
  void error(
    String message, [
    dynamic exception,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  ]) {
    developer.log(
      message,
      name: 'ERROR',
      error: exception,
      stackTrace: stackTrace,
    );
  }

  @override
  void fatal(
    String message, [
    dynamic exception,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  ]) {
    developer.log(
      message,
      name: 'FATAL',
      error: exception,
      stackTrace: stackTrace,
    );
  }
}
