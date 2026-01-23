import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_dto.freezed.dart';
part 'comment_dto.g.dart';

/// Data Transfer Object for Comment
@JsonSerializable(fieldRename: FieldRename.snake)
@freezed
class CommentDTO with _$CommentDTO {
  const factory CommentDTO({
    required String id,
    required String entryId,
    required String authorId,
    required String content,
    String? replyToId,
    required String createdAt,
    String? updatedAt,
  }) = _CommentDTO;

  factory CommentDTO.fromJson(Map<String, dynamic> json) =>
      _$CommentDTOFromJson(json);
}
