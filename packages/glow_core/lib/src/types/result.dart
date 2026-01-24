import '../error/failure.dart';

/// Result type for operations that can fail
sealed class Result<T, F extends Failure> {
  const Result();

  /// Create a success result
  const factory Result.success(T value) = Success<T, F>;

  /// Create a failure result
  const factory Result.failure(F failure) = Error<T, F>;

  /// Check if result is success
  bool get isSuccess => this is Success<T, F>;

  /// Check if result is failure
  bool get isFailure => this is Error<T, F>;

  /// Get value or null
  T? get valueOrNull => switch (this) {
        Success(:final value) => value,
        Error() => null,
      };

  /// Get failure or null
  F? get failureOrNull => switch (this) {
        Success() => null,
        Error(:final failure) => failure,
      };

  /// Map success value
  Result<R, F> map<R>(R Function(T value) transform) => switch (this) {
        Success(:final value) => Success(transform(value)),
        Error(:final failure) => Error(failure),
      };

  /// FlatMap for chaining operations
  Result<R, F> flatMap<R>(Result<R, F> Function(T value) transform) =>
      switch (this) {
        Success(:final value) => transform(value),
        Error(:final failure) => Error(failure),
      };

  /// Fold result into a single value
  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(F failure) onFailure,
  }) =>
      switch (this) {
        Success(:final value) => onSuccess(value),
        Error(:final failure) => onFailure(failure),
      };
}

/// Success case
final class Success<T, F extends Failure> extends Result<T, F> {
  const Success(this.value);

  final T value;

  @override
  String toString() => 'Success($value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// Failure case
final class Error<T, F extends Failure> extends Result<T, F> {
  const Error(this.failure);

  final F failure;

  @override
  String toString() => 'Error($failure)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Error &&
          runtimeType == other.runtimeType &&
          failure == other.failure;

  @override
  int get hashCode => failure.hashCode;
}
