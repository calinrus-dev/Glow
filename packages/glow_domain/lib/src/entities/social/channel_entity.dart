import 'package:freezed_annotation/freezed_annotation.dart';

part 'channel_entity.freezed.dart';
part 'channel_entity.g.dart';

/// Channel type
enum ChannelType {
  text,
  voice,
  video,
  announcement,
}

/// Channel entity (functional area within a Space)
@freezed
class ChannelEntity with _$ChannelEntity {
  const factory ChannelEntity({
    required String id,
    required String spaceId,
    required String name,
    required String slug,
    String? description,
    required ChannelType type,
    required int position,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _ChannelEntity;

  factory ChannelEntity.fromJson(Map<String, dynamic> json) =>
      _$ChannelEntityFromJson(json);
}
