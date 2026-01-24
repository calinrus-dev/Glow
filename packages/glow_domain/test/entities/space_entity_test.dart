import 'package:flutter_test/flutter_test.dart';
import 'package:glow_domain/glow_domain.dart';

void main() {
  group('SpaceEntity', () {
    test('should create space with required fields', () {
      final space = SpaceEntity(
        id: 'space-123',
        name: 'MotoGP Racing',
        slug: 'motogp-racing',
        ownerId: 'user-123',
        createdAt: DateTime(2026, 1, 1),
      );

      expect(space.id, 'space-123');
      expect(space.name, 'MotoGP Racing');
      expect(space.slug, 'motogp-racing');
      expect(space.ownerId, 'user-123');
      expect(space.description, null);
      expect(space.iconUrl, null);
      expect(space.bannerUrl, null);
      expect(space.isPublic, true);
      expect(space.memberCount, 0);
    });

    test('should create space with all fields', () {
      final space = SpaceEntity(
        id: 'space-123',
        name: 'MotoGP Racing',
        slug: 'motogp-racing',
        description: 'Discussion about MotoGP races and riders',
        iconUrl: 'https://example.com/icon.png',
        bannerUrl: 'https://example.com/banner.jpg',
        isPublic: false,
        memberCount: 1250,
        ownerId: 'user-123',
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 24),
      );

      expect(space.description, 'Discussion about MotoGP races and riders');
      expect(space.iconUrl, 'https://example.com/icon.png');
      expect(space.bannerUrl, 'https://example.com/banner.jpg');
      expect(space.isPublic, false);
      expect(space.memberCount, 1250);
    });

    test('should support equality', () {
      final space1 = SpaceEntity(
        id: 'space-123',
        name: 'MotoGP Racing',
        slug: 'motogp-racing',
        ownerId: 'user-123',
        createdAt: DateTime(2026, 1, 1),
      );

      final space2 = SpaceEntity(
        id: 'space-123',
        name: 'MotoGP Racing',
        slug: 'motogp-racing',
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
        ownerId: 'user-123',
        createdAt: DateTime(2026, 1, 1),
      );

      final updated = space.copyWith(
        description: 'Updated description',
        memberCount: 2000,
      );

      expect(updated.id, 'space-123');
      expect(updated.description, 'Updated description');
      expect(updated.memberCount, 2000);
      expect(updated.name, 'MotoGP Racing');
    });
  });
}
