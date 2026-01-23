import 'package:freezed_annotation/freezed_annotation.dart';

part 'entry_entity.freezed.dart';
part 'entry_entity.g.dart';

/// Entry entity (content created in canvases)
@freezed
class EntryEntity with _$EntryEntity {
  const EntryEntity._();

  const factory EntryEntity({
    required String id,
    required String channelId,
    required String authorId,
    required String content,
    @Default([]) List<String> attachments,
    String? replyToId,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? editedAt,
  }) = _EntryEntity;

  /// Check if entry was edited
  bool get isEdited => editedAt != null;

  /// Check if entry is a reply
  bool get isReply => replyToId != null;

  factory EntryEntity.fromJson(Map<String, dynamic> json) =>
      _$EntryEntityFromJson(json);
}
