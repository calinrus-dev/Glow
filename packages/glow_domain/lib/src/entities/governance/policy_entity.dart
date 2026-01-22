/// Policy type
enum PolicyType {
  contentModeration,
  userBehavior,
  accessControl,
}

/// Policy entity (governance rules)
class PolicyEntity {
  const PolicyEntity({
    required this.id,
    required this.worldId,
    required this.type,
    required this.name,
    required this.rules,
    required this.enabled,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String worldId;
  final PolicyType type;
  final String name;
  final Map<String, dynamic> rules;
  final bool enabled;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PolicyEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'PolicyEntity(id: $id, name: $name, type: $type)';
}
