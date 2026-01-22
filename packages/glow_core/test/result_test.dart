import 'package:glow_core/glow_core.dart';
import 'package:test/test.dart';

void main() {
  group('Result', () {
    test('Success creates success result', () {
      const result = Result<int, Failure>.success(42);

      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
      expect(result.valueOrNull, equals(42));
      expect(result.failureOrNull, isNull);
    });

    test('Error creates failure result', () {
      const failure = UnknownFailure(message: 'Test error');
      const result = Result<int, Failure>.failure(failure);

      expect(result.isSuccess, isFalse);
      expect(result.isFailure, isTrue);
      expect(result.valueOrNull, isNull);
      expect(result.failureOrNull, equals(failure));
    });

    test('map transforms success value', () {
      const result = Result<int, Failure>.success(42);
      final mapped = result.map((value) => value.toString());

      expect(mapped.isSuccess, isTrue);
      expect(mapped.valueOrNull, equals('42'));
    });

    test('map preserves failure', () {
      const failure = UnknownFailure(message: 'Test error');
      const result = Result<int, Failure>.failure(failure);
      final mapped = result.map((value) => value.toString());

      expect(mapped.isFailure, isTrue);
      expect(mapped.failureOrNull, equals(failure));
    });
  });
}
