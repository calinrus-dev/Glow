import 'package:test/test.dart';
import 'package:glow_domain/glow_domain.dart';

void main() {
  group('SpaceEntity', () {
    test('should create space with required fields', () {
      final space = SpaceEntity(
        id: 'space-123',
        name: 'MotoGP Racing',
        slug: 'motogp-racing',
        visibility: SpaceVisibility.public,
        ownerId: 'user-123',
        createdAt: DateTime(2026, 1, 1),
      );

      expect(space.id, 'space-123');
      expect(space.name, 'MotoGP Racing');
      expect(space.slug, 'motogp-racing');
      expect(space.ownerId, 'user-123');
      expect(space.description, null);
      expect(space.iconUrl, null);
      expect(space.coverUrl, null);
      expect(space.visibility, SpaceVisibility.public);
    });

    test('should create space with all fields', () {
      final space = SpaceEntity(
        id: 'space-123',
        name: 'MotoGP Racing',
        slug: 'motogp-racing',
        description: 'Discussion about MotoGP races and riders',
        iconUrl: 'https://example.com/icon.png',
        coverUrl: 'https://example.com/cover.jpg',
        visibility: SpaceVisibility.private,
        ownerId: 'user-123',
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 24),
      );

      expect(space.description, 'Discussion about MotoGP races and riders');
      expect(space.iconUrl, 'https://example.com/icon.png');
      expect(space.coverUrl, 'https://example.com/cover.jpg');
      expect(space.visibility, SpaceVisibility.private);
    });

    test('should support equality', () {
      final space1 = SpaceEntity(
        id: 'space-123',
        name: 'MotoGP Racing',
        slug: 'motogp-racing',
        visibility: SpaceVisibility.public,
        ownerId: 'user-123',
        createdAt: DateTime(2026, 1, 1),
      );

      final space2 = SpaceEntity(
        id: 'space-123',
        name: 'MotoGP Racing',
        slug: 'motogp-racing',
        visibility: SpaceVisibility.public,
        ownerId: 'user-123',
        createdAt: DateTime(2026, 1, 1),
      );

      expect(space1, equals(space2));
    });

    test('should support copyWith', () {
      final space = SpaceEntity(
        id: 'space-123',
        name: 'MotoGP Racing',
        slug: 'motogp-racing',
        visibility: SpaceVisibility.public,
        ownerId: 'user-123',
        createdAt: DateTime(2026, 1, 1),
      );

      final updated = space.copyWith(
        description: 'Updated description',
        visibility: SpaceVisibility.private,
      );

      expect(updated.id, 'space-123');
      expect(updated.description, 'Updated description');
      expect(updated.visibility, SpaceVisibility.private);
      expect(updated.name, 'MotoGP Racing');
    });

    test('should support different visibility types', () {
      final publicSpace = SpaceEntity(
        id: 'space-1',
        name: 'Public Space',
        slug: 'public',
        visibility: SpaceVisibility.public,
        ownerId: 'user-1',
        createdAt: DateTime.now(),
      );

      final privateSpace = SpaceEntity(
        id: 'space-2',
        name: 'Private Space',
        slug: 'private',
        visibility: SpaceVisibility.private,
        ownerId: 'user-2',
        createdAt: DateTime.now(),
      );

      final unlistedSpace = SpaceEntity(
        id: 'space-3',
        name: 'Unlisted Space',
        slug: 'unlisted',
        visibility: SpaceVisibility.unlisted,
        ownerId: 'user-3',
        createdAt: DateTime.now(),
      );

      expect(publicSpace.visibility, SpaceVisibility.public);
      expect(privateSpace.visibility, SpaceVisibility.private);
      expect(unlistedSpace.visibility, SpaceVisibility.unlisted);
    });
  });
}
