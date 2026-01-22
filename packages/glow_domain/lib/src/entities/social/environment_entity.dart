/// Environment entity (sub-space within a world)
class EnvironmentEntity {
  const EnvironmentEntity({
    required this.id,
    required this.worldId,
    required this.name,
    required this.slug,
    this.description,
    this.iconUrl,
    required this.position,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String worldId;
  final String name;
  final String slug;
  final String? description;
  final String? iconUrl;
  final int position;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnvironmentEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'EnvironmentEntity(id: $id, name: $name, worldId: $worldId)';
}
