import 'exception.dart';
import 'failure.dart';

/// Maps exceptions to failures
class ErrorMapper {
  const ErrorMapper();

  /// Convert exception to failure
  Failure mapExceptionToFailure(Object exception, [StackTrace? stackTrace]) {
    if (exception is NetworkException) {
      return NetworkFailure(
        message: exception.message,
        code: exception.code,
        stackTrace: stackTrace,
      );
    }

    if (exception is ServerException) {
      return ServerFailure(
        message: exception.message,
        code: exception.code,
        statusCode: exception.statusCode,
        stackTrace: stackTrace,
      );
    }

    if (exception is CacheException) {
      return CacheFailure(
        message: exception.message,
        code: exception.code,
        stackTrace: stackTrace,
      );
    }

    if (exception is ValidationException) {
      return ValidationFailure(
        message: exception.message,
        code: exception.code,
        field: exception.field,
        stackTrace: stackTrace,
      );
    }

    if (exception is AuthException) {
      return AuthFailure(
        message: exception.message,
        code: exception.code,
        stackTrace: stackTrace,
      );
    }

    return UnknownFailure(
      message: exception.toString(),
      stackTrace: stackTrace,
    );
  }
}
