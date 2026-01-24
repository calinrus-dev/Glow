import 'package:freezed_annotation/freezed_annotation.dart';

part 'entry_dto.freezed.dart';
part 'entry_dto.g.dart';

/// Data Transfer Object for Entry
@freezed
class EntryDTO with _$EntryDTO {
  const factory EntryDTO({
    required String id,
    required String channelId,
    required String authorId,
    required String content,
    @Default([]) List<String> attachments,
    String? replyToId,
    required String createdAt,
    String? updatedAt,
    String? editedAt,
  }) = _EntryDTO;

  factory EntryDTO.fromJson(Map<String, dynamic> json) =>
      _$EntryDTOFromJson(json);
}
