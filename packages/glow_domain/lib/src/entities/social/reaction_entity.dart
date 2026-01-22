/// Reaction type
enum ReactionType {
  like,
  love,
  laugh,
  wow,
  sad,
  angry,
}

/// Reaction entity
class ReactionEntity {
  const ReactionEntity({
    required this.id,
    required this.targetId,
    required this.targetType,
    required this.userId,
    required this.type,
    required this.createdAt,
  });

  final String id;
  final String targetId;
  final String targetType;
  final String userId;
  final ReactionType type;
  final DateTime createdAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReactionEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ReactionEntity(id: $id, type: $type, targetId: $targetId)';
}
