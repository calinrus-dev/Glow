import 'package:glow_core/glow_core.dart';

import 'package:glow_core/glow_core.dart';
import '../entities/{{feature_name.snakeCase()}}_entity.dart';

/// Repository interface for {{feature_name.pascalCase()}}
abstract class {{feature_name.pascalCase()}}Repository {
  /// Get {{feature_name.snakeCase()}} by ID
  Future<Either<Failure, {{feature_name.pascalCase()}}Entity>> get{{feature_name.pascalCase()}}(String id);
  
  /// Get all {{feature_name.snakeCase()}}s
  Future<Either<Failure, List<{{feature_name.pascalCase()}}Entity>>> getAll();
  
  /// Create new {{feature_name.snakeCase()}}
  Future<Either<Failure, {{feature_name.pascalCase()}}Entity>> create({{feature_name.pascalCase()}}Entity entity);
  
  /// Update {{feature_name.snakeCase()}}
  Future<Either<Failure, {{feature_name.pascalCase()}}Entity>> update({{feature_name.pascalCase()}}Entity entity);
  
  /// Delete {{feature_name.snakeCase()}}
  Future<Either<Failure, void>> delete(String id);
}
abstract class {{feature_name.pascalCase()}}Repository {
  // Add methods here
}
