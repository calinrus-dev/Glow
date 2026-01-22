import 'package:glow_domain/glow_domain.dart';
import 'package:test/test.dart';

void main() {
  group('UserEntity', () {
    test('creates user entity correctly', () {
      final user = UserEntity(
        id: '123',
        email: 'test@example.com',
        username: 'testuser',
        createdAt: DateTime(2024),
      );

      expect(user.id, equals('123'));
      expect(user.email, equals('test@example.com'));
      expect(user.username, equals('testuser'));
    });

    test('equality works based on id', () {
      final user1 = UserEntity(
        id: '123',
        email: 'test@example.com',
        createdAt: DateTime(2024),
      );

      final user2 = UserEntity(
        id: '123',
        email: 'different@example.com',
        createdAt: DateTime(2024),
      );

      expect(user1, equals(user2));
    });
  });
}
