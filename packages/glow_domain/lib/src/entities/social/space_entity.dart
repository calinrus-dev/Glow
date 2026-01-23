import 'package:freezed_annotation/freezed_annotation.dart';

part 'space_entity.freezed.dart';
part 'space_entity.g.dart';

/// Space visibility
enum SpaceVisibility {
  public,
  private,
  unlisted,
}

/// Space entity (top-level container for communities)
@freezed
class SpaceEntity with _$SpaceEntity {
  const factory SpaceEntity({
    required String id,
    required String name,
    required String slug,
    String? description,
    String? iconUrl,
    String? coverUrl,
    required SpaceVisibility visibility,
    required String ownerId,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _SpaceEntity;

  factory SpaceEntity.fromJson(Map<String, dynamic> json) =>
      _$SpaceEntityFromJson(json);
}
