import 'package:glow_core/glow_core.dart';

/// Crash reporter implementation
class CrashReporterImpl implements CrashReporter {
  const CrashReporterImpl();

  @override
  Future<void> reportException(
    dynamic exception,
    StackTrace? stackTrace, {
    String? reason,
    Map<String, dynamic>? metadata,
  }) async {
    // TODO: Implement actual crash reporting (e.g., Sentry)
    // ignore: avoid_print
    print('Crash: $exception\n$stackTrace');
  }

  @override
  Future<void> reportMessage(
    String message, {
    Map<String, dynamic>? metadata,
  }) async {
    // TODO: Implement message reporting
    // ignore: avoid_print
    print('Message: $message');
  }

  @override
  void setUserIdentifier(String identifier) {
    // TODO: Implement user ID setting
  }

  @override
  void setCustomKey(String key, dynamic value) {
    // TODO: Implement custom key setting
  }
}
