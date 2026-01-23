import 'package:glow_core/glow_core.dart';

import 'package:glow_core/glow_core.dart';
import 'package:glow_domain/glow_domain.dart';
import '../datasources/{{feature_name.snakeCase()}}_remote_ds.dart';
import '../datasources/{{feature_name.snakeCase()}}_local_ds.dart';
import '../mappers/{{feature_name.snakeCase()}}_mapper.dart';

/// Implementation of {{feature_name.pascalCase()}}Repository
class {{feature_name.pascalCase()}}RepositoryImpl implements {{feature_name.pascalCase()}}Repository {
  {{feature_name.pascalCase()}}RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final {{feature_name.pascalCase()}}RemoteDataSource remoteDataSource;
  final {{feature_name.pascalCase()}}LocalDataSource localDataSource;

  @override
  Future<Either<Failure, {{feature_name.pascalCase()}}Entity>> get{{feature_name.pascalCase()}}(String id) async {
    try {
      final dto = await remoteDataSource.get{{feature_name.pascalCase()}}(id);
      final entity = {{feature_name.pascalCase()}}Mapper.toEntity(dto);
      await localDataSource.cache(entity);
      return Right(entity);
    } catch (e) {
      // Try local cache
      try {
        final cached = await localDataSource.get(id);
        return Right(cached);
      } catch (_) {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<{{feature_name.pascalCase()}}Entity>>> getAll() async {
    try {
      final dtos = await remoteDataSource.getAll();
      final entities = dtos.map({{feature_name.pascalCase()}}Mapper.toEntity).toList();
      await localDataSource.cacheAll(entities);
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, {{feature_name.pascalCase()}}Entity>> create({{feature_name.pascalCase()}}Entity entity) async {
    try {
      final dto = {{feature_name.pascalCase()}}Mapper.toDto(entity);
      final created = await remoteDataSource.create(dto);
      final createdEntity = {{feature_name.pascalCase()}}Mapper.toEntity(created);
      await localDataSource.cache(createdEntity);
      return Right(createdEntity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, {{feature_name.pascalCase()}}Entity>> update({{feature_name.pascalCase()}}Entity entity) async {
    try {
      final dto = {{feature_name.pascalCase()}}Mapper.toDto(entity);
      final updated = await remoteDataSource.update(dto);
      final updatedEntity = {{feature_name.pascalCase()}}Mapper.toEntity(updated);
      await localDataSource.cache(updatedEntity);
      return Right(updatedEntity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> delete(String id) async {
    try {
      await remoteDataSource.delete(id);
      await localDataSource.delete(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
class {{feature_name.pascalCase()}}RepositoryImpl implements {{feature_name.pascalCase()}}Repository {
  const {{feature_name.pascalCase()}}RepositoryImpl();
}
