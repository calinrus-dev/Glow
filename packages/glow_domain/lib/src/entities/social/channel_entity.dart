/// Channel type
enum ChannelType {
  text,
  voice,
  video,
  announcement,
}

/// Channel entity
class ChannelEntity {
  const ChannelEntity({
    required this.id,
    required this.environmentId,
    required this.name,
    required this.slug,
    this.description,
    required this.type,
    required this.position,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String environmentId;
  final String name;
  final String slug;
  final String? description;
  final ChannelType type;
  final int position;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChannelEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ChannelEntity(id: $id, name: $name, type: $type)';
}
