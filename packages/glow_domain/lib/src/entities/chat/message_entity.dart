/// Message entity
class MessageEntity {
  const MessageEntity({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    this.attachments = const [],
    this.replyToId,
    required this.createdAt,
    this.updatedAt,
    this.editedAt,
  });

  final String id;
  final String conversationId;
  final String senderId;
  final String content;
  final List<String> attachments;
  final String? replyToId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? editedAt;

  /// Check if message was edited
  bool get isEdited => editedAt != null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'MessageEntity(id: $id, conversationId: $conversationId)';
}
