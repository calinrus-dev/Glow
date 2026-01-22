import 'package:glow_auth/glow_auth.dart';
import 'package:test/test.dart';

void main() {
  group('InMemoryTokenStorage', () {
    late InMemoryTokenStorage storage;

    setUp(() {
      storage = InMemoryTokenStorage();
    });

    test('saves and retrieves access token', () async {
      await storage.saveAccessToken('test-token');
      final token = await storage.getAccessToken();

      expect(token, equals('test-token'));
    });

    test('clears all tokens', () async {
      await storage.saveAccessToken('access');
      await storage.saveRefreshToken('refresh');

      await storage.clearTokens();

      expect(await storage.getAccessToken(), isNull);
      expect(await storage.getRefreshToken(), isNull);
    });
  });
}
