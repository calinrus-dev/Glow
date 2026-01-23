import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_entity.freezed.dart';
part 'comment_entity.g.dart';

/// Comment entity
@freezed
class CommentEntity with _$CommentEntity {
  const factory CommentEntity({
    required String id,
    required String entryId,
    required String authorId,
    required String content,
    String? replyToId,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _CommentEntity;

  factory CommentEntity.fromJson(Map<String, dynamic> json) =>
      _$CommentEntityFromJson(json);
}
