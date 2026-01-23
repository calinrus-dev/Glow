import 'package:freezed_annotation/freezed_annotation.dart';

part '{{feature_name.snakeCase()}}_entity.freezed.dart';
part '{{feature_name.snakeCase()}}_entity.g.dart';

/// {{feature_name.pascalCase()}} entity - Domain model
@freezed
class {{feature_name.pascalCase()}}Entity with _${{feature_name.pascalCase()}}Entity {
  const factory {{feature_name.pascalCase()}}Entity({
    required String id,
    required String name,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _{{feature_name.pascalCase()}}Entity;

  factory {{feature_name.pascalCase()}}Entity.fromJson(Map<String, dynamic> json) =>
      _${{feature_name.pascalCase()}}EntityFromJson(json);
}
class {{feature_name.pascalCase()}}Entity {
  const {{feature_name.pascalCase()}}Entity();
}
