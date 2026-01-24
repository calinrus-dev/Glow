import 'package:freezed_annotation/freezed_annotation.dart';

part 'channel_dto.freezed.dart';
part 'channel_dto.g.dart';

/// Data Transfer Object for Channel
@freezed
class ChannelDTO with _$ChannelDTO {
  const factory ChannelDTO({
    required String id,
    required String spaceId,
    required String name,
    required String slug,
    String? description,
    required String type,
    required int position,
    required String createdAt,
    String? updatedAt,
  }) = _ChannelDTO;

  factory ChannelDTO.fromJson(Map<String, dynamic> json) =>
      _$ChannelDTOFromJson(json);
}
