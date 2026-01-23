import 'package:glow_domain/glow_domain.dart';
import '../models/space_dto.dart';

/// Mapper extension for SpaceDTO ↔ SpaceEntity conversion
extension SpaceDTOMapper on SpaceDTO {
  /// Convert DTO to Entity
  SpaceEntity toEntity() {
    return SpaceEntity(
      id: id,
      name: name,
      slug: slug,
      description: description,
      iconUrl: iconUrl,
      coverUrl: coverUrl,
      visibility: _parseVisibility(visibility),
      ownerId: ownerId,
      createdAt: DateTime.parse(createdAt),
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
    );
  }

  SpaceVisibility _parseVisibility(String value) {
    switch (value.toLowerCase()) {
      case 'public':
        return SpaceVisibility.public;
      case 'private':
        return SpaceVisibility.private;
      case 'unlisted':
        return SpaceVisibility.unlisted;
      default:
        return SpaceVisibility.public;
    }
  }
}

/// Mapper extension for SpaceEntity ↔ SpaceDTO conversion
extension SpaceEntityMapper on SpaceEntity {
  /// Convert Entity to DTO
  SpaceDTO toDTO() {
    return SpaceDTO(
      id: id,
      name: name,
      slug: slug,
      description: description,
      iconUrl: iconUrl,
      coverUrl: coverUrl,
      visibility: visibility.name,
      ownerId: ownerId,
      createdAt: createdAt.toIso8601String(),
      updatedAt: updatedAt?.toIso8601String(),
    );
  }
}
