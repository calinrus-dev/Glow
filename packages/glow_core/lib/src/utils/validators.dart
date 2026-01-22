/// Common validators
class Validators {
  const Validators._();

  /// Validate email format
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Validate minimum length
  static bool hasMinLength(String value, int minLength) =>
      value.length >= minLength;

  /// Validate maximum length
  static bool hasMaxLength(String value, int maxLength) =>
      value.length <= maxLength;

  /// Check if value is empty or whitespace
  static bool isEmpty(String value) => value.trim().isEmpty;

  /// Validate URL format
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (_) {
      return false;
    }
  }

  /// Validate phone number (basic)
  static bool isValidPhone(String phone) {
    final phoneRegex = RegExp(r'^\+?[\d\s-()]{10,}$');
    return phoneRegex.hasMatch(phone);
  }
}
