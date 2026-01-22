/// Post entity
class PostEntity {
  const PostEntity({
    required this.id,
    required this.channelId,
    required this.authorId,
    required this.content,
    this.attachments = const [],
    this.replyToId,
    required this.createdAt,
    this.updatedAt,
    this.editedAt,
  });

  final String id;
  final String channelId;
  final String authorId;
  final String content;
  final List<String> attachments;
  final String? replyToId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? editedAt;

  /// Check if post was edited
  bool get isEdited => editedAt != null;

  /// Check if post is a reply
  bool get isReply => replyToId != null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'PostEntity(id: $id, channelId: $channelId, authorId: $authorId)';
}
