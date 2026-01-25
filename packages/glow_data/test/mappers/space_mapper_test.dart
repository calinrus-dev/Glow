import 'package:glow_data/glow_data.dart';
import 'package:glow_domain/glow_domain.dart';
import 'package:test/test.dart';

void main() {
  group('SpaceMapper', () {
    group('DTO to Entity', () {
      test('converts SpaceDTO to SpaceEntity correctly', () {
        const dto = SpaceDTO(
          id: 'space-123',
          name: 'MotoGP Racing',
          slug: 'motogp-racing',
          description: 'Discuss races and riders',
          iconUrl: 'https://example.com/icon.png',
          coverUrl: 'https://example.com/cover.png',
          visibility: 'public',
          ownerId: 'user-456',
          createdAt: '2026-01-23T10:00:00.000Z',
          updatedAt: '2026-01-23T12:00:00.000Z',
        );

        final entity = dto.toEntity();

        expect(entity.id, 'space-123');
        expect(entity.name, 'MotoGP Racing');
        expect(entity.slug, 'motogp-racing');
        expect(entity.description, 'Discuss races and riders');
        expect(entity.iconUrl, 'https://example.com/icon.png');
        expect(entity.coverUrl, 'https://example.com/cover.png');
        expect(entity.visibility, SpaceVisibility.public);
        expect(entity.ownerId, 'user-456');
        expect(entity.createdAt, DateTime.parse('2026-01-23T10:00:00.000Z'));
        expect(entity.updatedAt, DateTime.parse('2026-01-23T12:00:00.000Z'));
      });

      test('handles null optional fields', () {
        const dto = SpaceDTO(
          id: 'space-123',
          name: 'Gaming',
          slug: 'gaming',
          visibility: 'private',
          ownerId: 'user-456',
          createdAt: '2026-01-23T10:00:00.000Z',
        );

        final entity = dto.toEntity();

        expect(entity.description, isNull);
        expect(entity.iconUrl, isNull);
        expect(entity.coverUrl, isNull);
        expect(entity.updatedAt, isNull);
      });

      test('parses all visibility values correctly', () {
        const publicDto = SpaceDTO(
          id: '1',
          name: 'Test',
          slug: 'test',
          visibility: 'public',
          ownerId: 'user-1',
          createdAt: '2026-01-23T10:00:00.000Z',
        );

        final privateDto = publicDto.copyWith(visibility: 'private');
        final unlistedDto = publicDto.copyWith(visibility: 'unlisted');
        final unknownDto = publicDto.copyWith(visibility: 'unknown');

        expect(publicDto.toEntity().visibility, SpaceVisibility.public);
        expect(privateDto.toEntity().visibility, SpaceVisibility.private);
        expect(unlistedDto.toEntity().visibility, SpaceVisibility.unlisted);
        expect(
          unknownDto.toEntity().visibility,
          SpaceVisibility.public,
        ); // defaults to public
      });

      test('handles case-insensitive visibility', () {
        const dto = SpaceDTO(
          id: '1',
          name: 'Test',
          slug: 'test',
          visibility: 'PUBLIC',
          ownerId: 'user-1',
          createdAt: '2026-01-23T10:00:00.000Z',
        );

        expect(dto.toEntity().visibility, SpaceVisibility.public);
      });
    });

    group('Entity to DTO', () {
      test('converts SpaceEntity to SpaceDTO correctly', () {
        final entity = SpaceEntity(
          id: 'space-123',
          name: 'MotoGP Racing',
          slug: 'motogp-racing',
          description: 'Discuss races and riders',
          iconUrl: 'https://example.com/icon.png',
          coverUrl: 'https://example.com/cover.png',
          visibility: SpaceVisibility.public,
          ownerId: 'user-456',
          createdAt: DateTime.parse('2026-01-23T10:00:00.000Z'),
          updatedAt: DateTime.parse('2026-01-23T12:00:00.000Z'),
        );

        final dto = entity.toDTO();

        expect(dto.id, 'space-123');
        expect(dto.name, 'MotoGP Racing');
        expect(dto.slug, 'motogp-racing');
        expect(dto.description, 'Discuss races and riders');
        expect(dto.iconUrl, 'https://example.com/icon.png');
        expect(dto.coverUrl, 'https://example.com/cover.png');
        expect(dto.visibility, 'public');
        expect(dto.ownerId, 'user-456');
        expect(dto.createdAt, '2026-01-23T10:00:00.000Z');
        expect(dto.updatedAt, '2026-01-23T12:00:00.000Z');
      });

      test('handles null optional fields', () {
        final entity = SpaceEntity(
          id: 'space-123',
          name: 'Gaming',
          slug: 'gaming',
          visibility: SpaceVisibility.private,
          ownerId: 'user-456',
          createdAt: DateTime.parse('2026-01-23T10:00:00.000Z'),
        );

        final dto = entity.toDTO();

        expect(dto.description, isNull);
        expect(dto.iconUrl, isNull);
        expect(dto.coverUrl, isNull);
        expect(dto.updatedAt, isNull);
      });

      test('converts all visibility enums correctly', () {
        final baseEntity = SpaceEntity(
          id: '1',
          name: 'Test',
          slug: 'test',
          visibility: SpaceVisibility.public,
          ownerId: 'user-1',
          createdAt: DateTime.parse('2026-01-23T10:00:00.000Z'),
        );

        expect(baseEntity.toDTO().visibility, 'public');
        expect(
          baseEntity
              .copyWith(visibility: SpaceVisibility.private)
              .toDTO()
              .visibility,
          'private',
        );
        expect(
          baseEntity
              .copyWith(visibility: SpaceVisibility.unlisted)
              .toDTO()
              .visibility,
          'unlisted',
        );
      });
    });

    group('Bidirectional conversion', () {
      test('Entity → DTO → Entity preserves all data', () {
        final original = SpaceEntity(
          id: 'space-123',
          name: 'MotoGP Racing',
          slug: 'motogp-racing',
          description: 'Discuss races and riders',
          iconUrl: 'https://example.com/icon.png',
          coverUrl: 'https://example.com/cover.png',
          visibility: SpaceVisibility.private,
          ownerId: 'user-456',
          createdAt: DateTime.parse('2026-01-23T10:00:00.000Z'),
          updatedAt: DateTime.parse('2026-01-23T12:00:00.000Z'),
        );

        final converted = original.toDTO().toEntity();

        expect(converted.id, original.id);
        expect(converted.name, original.name);
        expect(converted.slug, original.slug);
        expect(converted.description, original.description);
        expect(converted.iconUrl, original.iconUrl);
        expect(converted.coverUrl, original.coverUrl);
        expect(converted.visibility, original.visibility);
        expect(converted.ownerId, original.ownerId);
        expect(converted.createdAt, original.createdAt);
        expect(converted.updatedAt, original.updatedAt);
      });

      test('DTO → Entity → DTO preserves all data', () {
        const original = SpaceDTO(
          id: 'space-123',
          name: 'MotoGP Racing',
          slug: 'motogp-racing',
          description: 'Discuss races and riders',
          iconUrl: 'https://example.com/icon.png',
          coverUrl: 'https://example.com/cover.png',
          visibility: 'unlisted',
          ownerId: 'user-456',
          createdAt: '2026-01-23T10:00:00.000Z',
          updatedAt: '2026-01-23T12:00:00.000Z',
        );

        final converted = original.toEntity().toDTO();

        expect(converted.id, original.id);
        expect(converted.name, original.name);
        expect(converted.slug, original.slug);
        expect(converted.description, original.description);
        expect(converted.iconUrl, original.iconUrl);
        expect(converted.coverUrl, original.coverUrl);
        expect(converted.visibility, original.visibility);
        expect(converted.ownerId, original.ownerId);
        expect(converted.createdAt, original.createdAt);
        expect(converted.updatedAt, original.updatedAt);
      });
    });
  });
}
