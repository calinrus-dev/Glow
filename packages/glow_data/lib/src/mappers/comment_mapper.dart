import 'package:glow_domain/glow_domain.dart';

import '../models/comment_dto.dart';

/// Mapper extension for CommentDTO ↔ CommentEntity conversion
extension CommentDTOMapper on CommentDTO {
  /// Convert DTO to Entity
  CommentEntity toEntity() {
    return CommentEntity(
      id: id,
      entryId: entryId,
      authorId: authorId,
      content: content,
      replyToId: replyToId,
      createdAt: DateTime.parse(createdAt),
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
    );
  }
}

/// Mapper extension for CommentEntity ↔ CommentDTO conversion
extension CommentEntityMapper on CommentEntity {
  /// Convert Entity to DTO
  CommentDTO toDTO() {
    return CommentDTO(
      id: id,
      entryId: entryId,
      authorId: authorId,
      content: content,
      replyToId: replyToId,
      createdAt: createdAt.toIso8601String(),
      updatedAt: updatedAt?.toIso8601String(),
    );
  }
}
