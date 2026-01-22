/// Conversation type
enum ConversationType {
  direct,
  group,
}

/// Conversation entity
class ConversationEntity {
  const ConversationEntity({
    required this.id,
    required this.type,
    this.name,
    required this.participantIds,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final ConversationType type;
  final String? name;
  final List<String> participantIds;
  final DateTime createdAt;
  final DateTime? updatedAt;

  /// Check if conversation is direct message
  bool get isDirect => type == ConversationType.direct;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversationEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ConversationEntity(id: $id, type: $type)';
}
