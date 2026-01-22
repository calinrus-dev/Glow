/// Base class for all failures in the application
abstract class Failure {
  const Failure({
    required this.message,
    this.code,
    this.stackTrace,
  });

  /// Human-readable error message
  final String message;

  /// Optional error code
  final String? code;

  /// Optional stack trace
  final StackTrace? stackTrace;

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

/// Network-related failure
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
    super.stackTrace,
  });
}

/// Server-related failure
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
    super.stackTrace,
    this.statusCode,
  });

  final int? statusCode;
}

/// Cache-related failure
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
    super.stackTrace,
  });
}

/// Validation failure
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
    super.stackTrace,
    this.field,
  });

  final String? field;
}

/// Authentication failure
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
    super.stackTrace,
  });
}

/// Authorization failure
class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.code,
    super.stackTrace,
  });
}

/// Generic/unknown failure
class UnknownFailure extends Failure {
  const UnknownFailure({
    required super.message,
    super.code,
    super.stackTrace,
  });
}
