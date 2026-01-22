/// Safe casting utilities
class SafeCast {
  const SafeCast._();

  /// Safely cast to type T
  static T? tryCast<T>(dynamic value) {
    if (value is T) {
      return value;
    }
    return null;
  }

  /// Cast with fallback value
  static T castOr<T>(dynamic value, T fallback) {
    if (value is T) {
      return value;
    }
    return fallback;
  }
}
