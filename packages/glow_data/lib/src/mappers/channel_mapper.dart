import 'package:glow_domain/glow_domain.dart';
import '../models/channel_dto.dart';

/// Mapper extension for ChannelDTO ↔ ChannelEntity conversion
extension ChannelDTOMapper on ChannelDTO {
  /// Convert DTO to Entity
  ChannelEntity toEntity() {
    return ChannelEntity(
      id: id,
      spaceId: spaceId,
      name: name,
      slug: slug,
      description: description,
      type: _parseChannelType(type),
      position: position,
      createdAt: DateTime.parse(createdAt),
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
    );
  }

  ChannelType _parseChannelType(String value) {
    switch (value.toLowerCase()) {
      case 'text':
        return ChannelType.text;
      case 'voice':
        return ChannelType.voice;
      case 'video':
        return ChannelType.video;
      case 'announcement':
        return ChannelType.announcement;
      default:
        return ChannelType.text;
    }
  }
}

/// Mapper extension for ChannelEntity ↔ ChannelDTO conversion
extension ChannelEntityMapper on ChannelEntity {
  /// Convert Entity to DTO
  ChannelDTO toDTO() {
    return ChannelDTO(
      id: id,
      spaceId: spaceId,
      name: name,
      slug: slug,
      description: description,
      type: type.name,
      position: position,
      createdAt: createdAt.toIso8601String(),
      updatedAt: updatedAt?.toIso8601String(),
    );
  }
}
