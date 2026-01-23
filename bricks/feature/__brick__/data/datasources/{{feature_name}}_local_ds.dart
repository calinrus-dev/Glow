import 'package:glow_domain/glow_domain.dart';

/// Local data source for {{feature_name.pascalCase()}}
abstract class {{feature_name.pascalCase()}}LocalDataSource {
  Future<{{feature_name.pascalCase()}}Entity> get(String id);
  Future<List<{{feature_name.pascalCase()}}Entity>> getAll();
  Future<void> cache({{feature_name.pascalCase()}}Entity entity);
  Future<void> cacheAll(List<{{feature_name.pascalCase()}}Entity> entities);
  Future<void> delete(String id);
  Future<void> clear();
}

/// Implementation of local data source using local storage
class {{feature_name.pascalCase()}}LocalDataSourceImpl implements {{feature_name.pascalCase()}}LocalDataSource {
  {{feature_name.pascalCase()}}LocalDataSourceImpl(this.localStorage);

  final dynamic localStorage; // Replace with actual LocalStorage type

  @override
  Future<{{feature_name.pascalCase()}}Entity> get(String id) async {
    // TODO: Implement local storage retrieval
    throw UnimplementedError();
  }

  @override
  Future<List<{{feature_name.pascalCase()}}Entity>> getAll() async {
    // TODO: Implement local storage retrieval
    throw UnimplementedError();
  }

  @override
  Future<void> cache({{feature_name.pascalCase()}}Entity entity) async {
    // TODO: Implement local storage caching
  }

  @override
  Future<void> cacheAll(List<{{feature_name.pascalCase()}}Entity> entities) async {
    // TODO: Implement local storage caching
  }

  @override
  Future<void> delete(String id) async {
    // TODO: Implement local storage deletion
  }

  @override
  Future<void> clear() async {
    // TODO: Implement local storage clearing
  }
}
class {{feature_name.pascalCase()}}LocalDataSource {
  const {{feature_name.pascalCase()}}LocalDataSource();
}
