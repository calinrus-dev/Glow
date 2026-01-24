import 'package:test/test.dart';
import 'package:glow_core/glow_core.dart';

void main() {
  group('Result', () {
    group('Success', () {
      test('should create success result with value', () {
        const result = Result<int, Failure>.success(42);

        expect(result.isSuccess, true);
        expect(result.isFailure, false);
        expect(result.valueOrNull, 42);
        expect(result.failureOrNull, null);
      });

      test('should map value correctly', () {
        const result = Result<int, Failure>.success(10);
        final mapped = result.map((value) => value * 2);

        expect(mapped.isSuccess, true);
        expect(mapped.valueOrNull, 20);
      });

      test('should flatMap correctly', () {
        const result = Result<int, Failure>.success(10);
        final flatMapped = result.flatMap(
          (value) => Result<String, Failure>.success('Value: $value'),
        );

        expect(flatMapped.isSuccess, true);
        expect(flatMapped.valueOrNull, 'Value: 10');
      });

      test('should fold to success callback', () {
        const result = Result<int, Failure>.success(42);
        final folded = result.fold(
          onSuccess: (value) => 'Success: $value',
          onFailure: (failure) => 'Failure: ${failure.message}',
        );

        expect(folded, 'Success: 42');
      });
    });

    group('Error', () {
      test('should create failure result', () {
        const failure = NetworkFailure(message: 'Connection lost');
        const result = Result<int, Failure>.failure(failure);

        expect(result.isSuccess, false);
        expect(result.isFailure, true);
        expect(result.valueOrNull, null);
        expect(result.failureOrNull, failure);
      });

      test('should preserve failure when mapping', () {
        const failure = NetworkFailure(message: 'Connection lost');
        const result = Result<int, Failure>.failure(failure);
        final mapped = result.map((value) => value * 2);

        expect(mapped.isFailure, true);
        expect(mapped.failureOrNull, failure);
      });

      test('should preserve failure when flatMapping', () {
        const failure = NetworkFailure(message: 'Connection lost');
        const result = Result<int, Failure>.failure(failure);
        final flatMapped = result.flatMap(
          (value) => Result<String, Failure>.success('Value: $value'),
        );

        expect(flatMapped.isFailure, true);
        expect(flatMapped.failureOrNull, failure);
      });

      test('should fold to failure callback', () {
        const failure = NetworkFailure(message: 'Connection lost');
        const result = Result<int, Failure>.failure(failure);
        final folded = result.fold(
          onSuccess: (value) => 'Success: $value',
          onFailure: (failure) => 'Failure: ${failure.message}',
        );

        expect(folded, 'Failure: Connection lost');
      });
    });

    group('Chaining', () {
      test('should chain multiple operations on success', () {
        const result = Result<int, Failure>.success(5);

        final chained = result
            .map((value) => value * 2)
            .flatMap(
                (value) => Result<String, Failure>.success('Result: $value'))
            .map((value) => value.toUpperCase());

        expect(chained.isSuccess, true);
        expect(chained.valueOrNull, 'RESULT: 10');
      });

      test('should stop chaining on first failure', () {
        const failure = NetworkFailure(message: 'Network error');
        const result = Result<int, Failure>.failure(failure);

        final chained = result
            .map((value) => value * 2)
            .flatMap(
                (value) => Result<String, Failure>.success('Result: $value'))
            .map((value) => value.toUpperCase());

        expect(chained.isFailure, true);
        expect(chained.failureOrNull, failure);
      });
    });
  });
}
