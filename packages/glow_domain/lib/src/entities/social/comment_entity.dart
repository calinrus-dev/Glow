/// Comment entity
class CommentEntity {
  const CommentEntity({
    required this.id,
    required this.postId,
    required this.authorId,
    required this.content,
    this.replyToId,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String postId;
  final String authorId;
  final String content;
  final String? replyToId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'CommentEntity(id: $id, postId: $postId)';
}
