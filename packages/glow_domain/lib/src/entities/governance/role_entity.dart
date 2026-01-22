/// Role entity
class RoleEntity {
  const RoleEntity({
    required this.id,
    required this.worldId,
    required this.name,
    this.description,
    required this.color,
    required this.position,
    required this.permissions,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String worldId;
  final String name;
  final String? description;
  final String color;
  final int position;
  final List<String> permissions;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoleEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'RoleEntity(id: $id, name: $name)';
}
