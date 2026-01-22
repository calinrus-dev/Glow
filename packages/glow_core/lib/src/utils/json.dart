import 'dart:convert';

/// JSON utilities
class JsonUtils {
  const JsonUtils._();

  /// Safely decode JSON
  static Map<String, dynamic>? tryDecodeObject(String source) {
    try {
      final decoded = json.decode(source);
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (_) {
      return null;
    }
  }

  /// Safely encode JSON
  static String? tryEncode(dynamic object) {
    try {
      return json.encode(object);
    } catch (_) {
      return null;
    }
  }
}
