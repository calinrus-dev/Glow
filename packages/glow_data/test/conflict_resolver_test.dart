import 'package:glow_data/glow_data.dart';
import 'package:test/test.dart';

void main() {
  group('ConflictResolver', () {
    late ConflictResolver resolver;

    setUp(() {
      resolver = const ConflictResolver();
    });

    test('remoteWins strategy returns remote data', () async {
      final local = {'id': '1', 'value': 'local'};
      final remote = {'id': '1', 'value': 'remote'};

      final result = await resolver.resolve(
        local: local,
        remote: remote,
        strategy: ConflictStrategy.remoteWins,
      );

      expect(result, equals(remote));
    });

    test('localWins strategy returns local data', () async {
      final local = {'id': '1', 'value': 'local'};
      final remote = {'id': '1', 'value': 'remote'};

      final result = await resolver.resolve(
        local: local,
        remote: remote,
        strategy: ConflictStrategy.localWins,
      );

      expect(result, equals(local));
    });
  });
}
