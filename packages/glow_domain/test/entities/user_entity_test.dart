import 'package:flutter_test/flutter_test.dart';
import 'package:glow_domain/glow_domain.dart';

void main() {
  group('UserEntity', () {
    test('should create user with required fields', () {
      final user = UserEntity(
        id: 'user-123',
        username: 'johndoe',
        email: 'john@example.com',
        createdAt: DateTime(2026, 1, 1),
      );

      expect(user.id, 'user-123');
      expect(user.username, 'johndoe');
      expect(user.email, 'john@example.com');
      expect(user.displayName, null);
      expect(user.avatarUrl, null);
      expect(user.bio, null);
    });

    test('should create user with all fields', () {
      final user = UserEntity(
        id: 'user-123',
        username: 'johndoe',
        email: 'john@example.com',
        displayName: 'John Doe',
        avatarUrl: 'https://example.com/avatar.jpg',
        bio: 'Software developer',
        createdAt: DateTime(2026, 1, 1),
        updatedAt: DateTime(2026, 1, 24),
      );

      expect(user.displayName, 'John Doe');
      expect(user.avatarUrl, 'https://example.com/avatar.jpg');
      expect(user.bio, 'Software developer');
      expect(user.updatedAt, DateTime(2026, 1, 24));
    });

    test('should support equality', () {
      final user1 = UserEntity(
        id: 'user-123',
        username: 'johndoe',
        email: 'john@example.com',
        createdAt: DateTime(2026, 1, 1),
      );

      final user2 = UserEntity(
        id: 'user-123',
        username: 'johndoe',
        email: 'john@example.com',
        createdAt: DateTime(2026, 1, 1),
      );

      expect(user1, equals(user2));
    });

    test('should support copyWith', () {
      final user = UserEntity(
        id: 'user-123',
        username: 'johndoe',
        email: 'john@example.com',
        createdAt: DateTime(2026, 1, 1),
      );

      final updated = user.copyWith(
        displayName: 'John Doe',
        bio: 'Developer',
      );

      expect(updated.id, 'user-123');
      expect(updated.displayName, 'John Doe');
      expect(updated.bio, 'Developer');
      expect(updated.username, 'johndoe');
    });
  });
}
