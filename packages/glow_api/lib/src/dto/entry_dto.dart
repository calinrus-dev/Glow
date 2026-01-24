/// Entry DTO
class EntryDto {
  const EntryDto({
    required this.id,
    required this.channelId,
    required this.authorId,
    required this.content,
    required this.createdAt,
  });

  factory EntryDto.fromJson(Map<String, dynamic> json) => EntryDto(
        id: json['id'] as String,
        channelId: json['channel_id'] as String,
        authorId: json['author_id'] as String,
        content: json['content'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  final String id;
  final String channelId;
  final String authorId;
  final String content;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'channel_id': channelId,
        'author_id': authorId,
        'content': content,
        'created_at': createdAt.toIso8601String(),
      };
}
