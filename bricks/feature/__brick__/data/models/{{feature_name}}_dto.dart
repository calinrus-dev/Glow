import 'package:freezed_annotation/freezed_annotation.dart';

part '{{feature_name.snakeCase()}}_dto.freezed.dart';
part '{{feature_name.snakeCase()}}_dto.g.dart';

/// Data Transfer Object for {{feature_name.pascalCase()}}
@freezed
class {{feature_name.pascalCase()}}Dto with _${{feature_name.pascalCase()}}Dto {
  const factory {{feature_name.pascalCase()}}Dto({
    required String id,
    required String name,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _{{feature_name.pascalCase()}}Dto;

  factory {{feature_name.pascalCase()}}Dto.fromJson(Map<String, dynamic> json) =>
      _${{feature_name.pascalCase()}}DtoFromJson(json);
}
class {{feature_name.pascalCase()}}DTO {
  const {{feature_name.pascalCase()}}DTO();
}
