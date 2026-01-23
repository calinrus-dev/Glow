import 'package:glow_domain/glow_domain.dart';
import '../models/entry_dto.dart';

/// Mapper extension for EntryDTO ↔ EntryEntity conversion
extension EntryDTOMapper on EntryDTO {
  /// Convert DTO to Entity
  EntryEntity toEntity() {
    return EntryEntity(
      id: id,
      channelId: channelId,
      authorId: authorId,
      content: content,
      attachments: attachments,
      replyToId: replyToId,
      createdAt: DateTime.parse(createdAt),
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
      editedAt: editedAt != null ? DateTime.parse(editedAt!) : null,
    );
  }
}

/// Mapper extension for EntryEntity ↔ EntryDTO conversion
extension EntryEntityMapper on EntryEntity {
  /// Convert Entity to DTO
  EntryDTO toDTO() {
    return EntryDTO(
      id: id,
      channelId: channelId,
      authorId: authorId,
      content: content,
      attachments: attachments,
      replyToId: replyToId,
      createdAt: createdAt.toIso8601String(),
      updatedAt: updatedAt?.toIso8601String(),
      editedAt: editedAt?.toIso8601String(),
    );
  }
}
