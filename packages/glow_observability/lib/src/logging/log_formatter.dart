/// Log formatter
class LogFormatter {
  const LogFormatter();

  /// Format log entry as JSON
  String formatAsJson({
    required String level,
    required String message,
    Map<String, dynamic>? metadata,
  }) {
    final entry = {
      'timestamp': DateTime.now().toIso8601String(),
      'level': level,
      'message': message,
      if (metadata != null) 'metadata': metadata,
    };
    return entry.toString();
  }

  /// Format log entry as text
  String formatAsText({
    required String level,
    required String message,
    Map<String, dynamic>? metadata,
  }) {
    final timestamp = DateTime.now().toIso8601String();
    final meta = metadata != null ? ' | $metadata' : '';
    return '[$timestamp] $level: $message$meta';
  }
}
