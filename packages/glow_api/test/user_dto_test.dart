import 'package:glow_api/glow_api.dart';
import 'package:test/test.dart';

void main() {
  group('UserDto', () {
    test('fromJson creates valid UserDto', () {
      final json = {
        'id': '123',
        'email': 'test@example.com',
        'username': 'testuser',
      };

      final dto = UserDto.fromJson(json);

      expect(dto.id, equals('123'));
      expect(dto.email, equals('test@example.com'));
      expect(dto.username, equals('testuser'));
    });

    test('toJson creates valid JSON', () {
      const dto = UserDto(
        id: '123',
        email: 'test@example.com',
        username: 'testuser',
      );

      final json = dto.toJson();

      expect(json['id'], equals('123'));
      expect(json['email'], equals('test@example.com'));
      expect(json['username'], equals('testuser'));
    });
  });
}
