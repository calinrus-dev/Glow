import 'package:freezed_annotation/freezed_annotation.dart';

part 'space_dto.freezed.dart';
part 'space_dto.g.dart';

/// Data Transfer Object for Space
@JsonSerializable(fieldRename: FieldRename.snake)
@freezed
class SpaceDTO with _$SpaceDTO {
  const factory SpaceDTO({
    required String id,
    required String name,
    required String slug,
    String? description,
    String? iconUrl,
    String? coverUrl,
    required String visibility,
    required String ownerId,
    required String createdAt,
    String? updatedAt,
  }) = _SpaceDTO;

  factory SpaceDTO.fromJson(Map<String, dynamic> json) =>
      _$SpaceDTOFromJson(json);
}
