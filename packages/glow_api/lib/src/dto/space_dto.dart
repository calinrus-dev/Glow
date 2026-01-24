/// Space DTO
class SpaceDto {
  const SpaceDto({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
  });

  factory SpaceDto.fromJson(Map<String, dynamic> json) => SpaceDto(
        id: json['id'] as String,
        name: json['name'] as String,
        slug: json['slug'] as String,
        description: json['description'] as String?,
      );

  final String id;
  final String name;
  final String slug;
  final String? description;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        if (description != null) 'description': description,
      };
}
