import 'package:glow_realtime/glow_realtime.dart';
import 'package:test/test.dart';

void main() {
  group('RealtimeChannel', () {
    test('creates channel with name', () {
      const channel = RealtimeChannel(name: 'test-channel');
      expect(channel.name, equals('test-channel'));
    });
  });
}
