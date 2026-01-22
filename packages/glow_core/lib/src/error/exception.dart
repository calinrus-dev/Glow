/// Base class for custom exceptions
class AppException implements Exception {
  const AppException({
    required this.message,
    this.code,
  });

  final String message;
  final String? code;

  @override
  String toString() => 'AppException(message: $message, code: $code)';
}

/// Network exception
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
  });
}

/// Server exception
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.code,
    this.statusCode,
  });

  final int? statusCode;
}

/// Cache exception
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code,
  });
}

/// Validation exception
class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.code,
    this.field,
  });

  final String? field;
}

/// Authentication exception
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.code,
  });
}

/// Parse exception
class ParseException extends AppException {
  const ParseException({
    required super.message,
    super.code,
  });
}
