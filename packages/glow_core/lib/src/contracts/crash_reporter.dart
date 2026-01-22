/// Contract for crash reporting
abstract class CrashReporter {
  /// Report an exception
  Future<void> reportException(
    dynamic exception,
    StackTrace? stackTrace, {
    String? reason,
    Map<String, dynamic>? metadata,
  });

  /// Report a message
  Future<void> reportMessage(
    String message, {
    Map<String, dynamic>? metadata,
  });

  /// Set user identifier
  void setUserIdentifier(String identifier);

  /// Set custom key-value pair
  void setCustomKey(String key, dynamic value);
}
