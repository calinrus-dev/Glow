import 'package:glow_observability/glow_observability.dart';
import 'package:test/test.dart';

void main() {
  group('LogFormatter', () {
    late LogFormatter formatter;

    setUp(() {
      formatter = const LogFormatter();
    });

    test('formatAsText returns formatted string', () {
      final result = formatter.formatAsText(
        level: 'INFO',
        message: 'Test message',
      );

      expect(result, contains('INFO'));
      expect(result, contains('Test message'));
    });

    test('formatAsText includes metadata', () {
      final result = formatter.formatAsText(
        level: 'INFO',
        message: 'Test',
        metadata: {'key': 'value'},
      );

      expect(result, contains('key'));
    });
  });
}
