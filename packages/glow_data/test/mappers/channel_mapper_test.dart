import 'package:glow_data/glow_data.dart';
import 'package:glow_domain/glow_domain.dart';
import 'package:test/test.dart';

void main() {
  group('ChannelMapper', () {
    group('DTO to Entity', () {
      test('converts ChannelDTO to ChannelEntity correctly', () {
        const dto = ChannelDTO(
          id: 'channel-123',
          spaceId: 'space-456',
          name: 'General Chat',
          slug: 'general-chat',
          description: 'Main discussion channel',
          type: 'text',
          position: 0,
          createdAt: '2026-01-23T10:00:00.000Z',
          updatedAt: '2026-01-23T12:00:00.000Z',
        );

        final entity = dto.toEntity();

        expect(entity.id, 'channel-123');
        expect(entity.spaceId, 'space-456');
        expect(entity.name, 'General Chat');
        expect(entity.slug, 'general-chat');
        expect(entity.description, 'Main discussion channel');
        expect(entity.type, ChannelType.text);
        expect(entity.position, 0);
        expect(entity.createdAt, DateTime.parse('2026-01-23T10:00:00.000Z'));
        expect(entity.updatedAt, DateTime.parse('2026-01-23T12:00:00.000Z'));
      });

      test('handles null optional fields', () {
        const dto = ChannelDTO(
          id: 'channel-123',
          spaceId: 'space-456',
          name: 'Announcements',
          slug: 'announcements',
          type: 'announcement',
          position: 1,
          createdAt: '2026-01-23T10:00:00.000Z',
        );

        final entity = dto.toEntity();

        expect(entity.description, isNull);
        expect(entity.updatedAt, isNull);
      });

      test('parses all channel types correctly', () {
        const baseDto = ChannelDTO(
          id: '1',
          spaceId: 'space-1',
          name: 'Test',
          slug: 'test',
          type: 'text',
          position: 0,
          createdAt: '2026-01-23T10:00:00.000Z',
        );

        expect(baseDto.toEntity().type, ChannelType.text);
        expect(baseDto.copyWith(type: 'voice').toEntity().type, ChannelType.voice);
        expect(baseDto.copyWith(type: 'video').toEntity().type, ChannelType.video);
        expect(baseDto.copyWith(type: 'announcement').toEntity().type, ChannelType.announcement);
        expect(baseDto.copyWith(type: 'unknown').toEntity().type, ChannelType.text); // defaults
      });

      test('handles case-insensitive channel type', () {
        const dto = ChannelDTO(
          id: '1',
          spaceId: 'space-1',
          name: 'Test',
          slug: 'test',
          type: 'VOICE',
          position: 0,
          createdAt: '2026-01-23T10:00:00.000Z',
        );

        expect(dto.toEntity().type, ChannelType.voice);
      });
    });

    group('Entity to DTO', () {
      test('converts ChannelEntity to ChannelDTO correctly', () {
        final entity = ChannelEntity(
          id: 'channel-123',
          spaceId: 'space-456',
          name: 'General Chat',
          slug: 'general-chat',
          description: 'Main discussion channel',
          type: ChannelType.text,
          position: 0,
          createdAt: DateTime.parse('2026-01-23T10:00:00.000Z'),
          updatedAt: DateTime.parse('2026-01-23T12:00:00.000Z'),
        );

        final dto = entity.toDTO();

        expect(dto.id, 'channel-123');
        expect(dto.spaceId, 'space-456');
        expect(dto.name, 'General Chat');
        expect(dto.slug, 'general-chat');
        expect(dto.description, 'Main discussion channel');
        expect(dto.type, 'text');
        expect(dto.position, 0);
        expect(dto.createdAt, '2026-01-23T10:00:00.000Z');
        expect(dto.updatedAt, '2026-01-23T12:00:00.000Z');
      });

      test('converts all channel type enums correctly', () {
        final baseEntity = ChannelEntity(
          id: '1',
          spaceId: 'space-1',
          name: 'Test',
          slug: 'test',
          type: ChannelType.text,
          position: 0,
          createdAt: DateTime.parse('2026-01-23T10:00:00.000Z'),
        );

        expect(baseEntity.toDTO().type, 'text');
        expect(baseEntity.copyWith(type: ChannelType.voice).toDTO().type, 'voice');
        expect(baseEntity.copyWith(type: ChannelType.video).toDTO().type, 'video');
        expect(
          baseEntity.copyWith(type: ChannelType.announcement).toDTO().type,
          'announcement',
        );
      });
    });

    group('Bidirectional conversion', () {
      test('Entity → DTO → Entity preserves all data', () {
        final original = ChannelEntity(
          id: 'channel-123',
          spaceId: 'space-456',
          name: 'General Chat',
          slug: 'general-chat',
          description: 'Main discussion',
          type: ChannelType.video,
          position: 5,
          createdAt: DateTime.parse('2026-01-23T10:00:00.000Z'),
          updatedAt: DateTime.parse('2026-01-23T12:00:00.000Z'),
        );

        final converted = original.toDTO().toEntity();

        expect(converted.id, original.id);
        expect(converted.spaceId, original.spaceId);
        expect(converted.name, original.name);
        expect(converted.slug, original.slug);
        expect(converted.description, original.description);
        expect(converted.type, original.type);
        expect(converted.position, original.position);
        expect(converted.createdAt, original.createdAt);
        expect(converted.updatedAt, original.updatedAt);
      });

      test('DTO → Entity → DTO preserves all data', () {
        const original = ChannelDTO(
          id: 'channel-123',
          spaceId: 'space-456',
          name: 'Voice Chat',
          slug: 'voice-chat',
          description: 'Voice discussions',
          type: 'voice',
          position: 3,
          createdAt: '2026-01-23T10:00:00.000Z',
          updatedAt: '2026-01-23T12:00:00.000Z',
        );

        final converted = original.toEntity().toDTO();

        expect(converted.id, original.id);
        expect(converted.spaceId, original.spaceId);
        expect(converted.name, original.name);
        expect(converted.slug, original.slug);
        expect(converted.description, original.description);
        expect(converted.type, original.type);
        expect(converted.position, original.position);
        expect(converted.createdAt, original.createdAt);
        expect(converted.updatedAt, original.updatedAt);
      });
    });
  });
}
