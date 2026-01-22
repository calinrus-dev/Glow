/// World visibility
enum WorldVisibility {
  public,
  private,
  unlisted,
}

/// World entity (top-level container)
class WorldEntity {
  const WorldEntity({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.iconUrl,
    this.coverUrl,
    required this.visibility,
    required this.ownerId,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String slug;
  final String? description;
  final String? iconUrl;
  final String? coverUrl;
  final WorldVisibility visibility;
  final String ownerId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorldEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'WorldEntity(id: $id, name: $name, slug: $slug)';
}
