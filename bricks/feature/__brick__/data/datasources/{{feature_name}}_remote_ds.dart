import '../models/{{feature_name.snakeCase()}}_dto.dart';

/// Remote data source for {{feature_name.pascalCase()}}
abstract class {{feature_name.pascalCase()}}RemoteDataSource {
  Future<{{feature_name.pascalCase()}}Dto> get{{feature_name.pascalCase()}}(String id);
  Future<List<{{feature_name.pascalCase()}}Dto>> getAll();
  Future<{{feature_name.pascalCase()}}Dto> create({{feature_name.pascalCase()}}Dto dto);
  Future<{{feature_name.pascalCase()}}Dto> update({{feature_name.pascalCase()}}Dto dto);
  Future<void> delete(String id);
}

/// Implementation of remote data source using API
class {{feature_name.pascalCase()}}RemoteDataSourceImpl implements {{feature_name.pascalCase()}}RemoteDataSource {
  {{feature_name.pascalCase()}}RemoteDataSourceImpl(this.apiClient);

  final dynamic apiClient; // Replace with actual ApiClient type

  @override
  Future<{{feature_name.pascalCase()}}Dto> get{{feature_name.pascalCase()}}(String id) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<List<{{feature_name.pascalCase()}}Dto>> getAll() async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<{{feature_name.pascalCase()}}Dto> create({{feature_name.pascalCase()}}Dto dto) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<{{feature_name.pascalCase()}}Dto> update({{feature_name.pascalCase()}}Dto dto) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }
}
class {{feature_name.pascalCase()}}RemoteDataSource {
  const {{feature_name.pascalCase()}}RemoteDataSource();
}
