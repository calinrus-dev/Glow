import 'package:glow_domain/glow_domain.dart';
import '../models/{{feature_name.snakeCase()}}_dto.dart';

/// Mapper between {{feature_name.pascalCase()}}Entity and {{feature_name.pascalCase()}}Dto
class {{feature_name.pascalCase()}}Mapper {
  /// Convert DTO to Entity
  static {{feature_name.pascalCase()}}Entity toEntity({{feature_name.pascalCase()}}Dto dto) {
    return {{feature_name.pascalCase()}}Entity(
      id: dto.id,
      name: dto.name,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  /// Convert Entity to DTO
  static {{feature_name.pascalCase()}}Dto toDto({{feature_name.pascalCase()}}Entity entity) {
    return {{feature_name.pascalCase()}}Dto(
      id: entity.id,
      name: entity.name,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
