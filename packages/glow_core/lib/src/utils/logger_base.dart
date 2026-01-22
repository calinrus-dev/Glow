/// Basic logger implementation
abstract class LoggerBase {
  const LoggerBase();

  /// Format a log message
  String formatMessage(
    String level,
    String message, [
    Map<String, dynamic>? metadata,
  ]) {
    final timestamp = DateTime.now().toIso8601String();
    final meta = metadata != null ? ' | $metadata' : '';
    return '[$timestamp] $level: $message$meta';
  }
}
