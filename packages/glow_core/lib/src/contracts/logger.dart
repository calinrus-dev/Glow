/// Log level
enum LogLevel {
  /// Verbose/debug information
  debug,

  /// General information
  info,

  /// Warning messages
  warning,

  /// Error messages
  error,

  /// Fatal errors
  fatal,
}

/// Contract for logging
abstract class Logger {
  /// Log a debug message
  void debug(String message, [Map<String, dynamic>? metadata]);

  /// Log an info message
  void info(String message, [Map<String, dynamic>? metadata]);

  /// Log a warning
  void warning(String message, [Map<String, dynamic>? metadata]);

  /// Log an error
  void error(
    String message, [
    dynamic exception,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  ]);

  /// Log a fatal error
  void fatal(
    String message, [
    dynamic exception,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  ]);
}
