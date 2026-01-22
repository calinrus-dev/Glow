import '../error/failure.dart';
import '../types/result.dart';

/// Base class for all use cases
abstract class BaseUsecase<T, P> {
  const BaseUsecase();

  /// Execute the use case
  Future<Result<T, Failure>> call(P params);
}
