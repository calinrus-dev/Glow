/// Common error codes used across the application
class ErrorCodes {
  const ErrorCodes._();

  // Network errors
  static const String networkTimeout = 'NETWORK_TIMEOUT';
  static const String networkUnavailable = 'NETWORK_UNAVAILABLE';
  static const String networkUnknown = 'NETWORK_UNKNOWN';

  // Server errors
  static const String serverError = 'SERVER_ERROR';
  static const String serverNotFound = 'SERVER_NOT_FOUND';
  static const String serverUnauthorized = 'SERVER_UNAUTHORIZED';
  static const String serverForbidden = 'SERVER_FORBIDDEN';
  static const String serverBadRequest = 'SERVER_BAD_REQUEST';

  // Cache errors
  static const String cacheNotFound = 'CACHE_NOT_FOUND';
  static const String cacheWriteFailed = 'CACHE_WRITE_FAILED';

  // Validation errors
  static const String validationInvalidEmail = 'VALIDATION_INVALID_EMAIL';
  static const String validationRequired = 'VALIDATION_REQUIRED';
  static const String validationTooShort = 'VALIDATION_TOO_SHORT';
  static const String validationTooLong = 'VALIDATION_TOO_LONG';

  // Auth errors
  static const String authInvalidCredentials = 'AUTH_INVALID_CREDENTIALS';
  static const String authSessionExpired = 'AUTH_SESSION_EXPIRED';
  static const String authUserNotFound = 'AUTH_USER_NOT_FOUND';

  // Permission errors
  static const String permissionDenied = 'PERMISSION_DENIED';
  static const String permissionInsufficientRole =
      'PERMISSION_INSUFFICIENT_ROLE';
}
