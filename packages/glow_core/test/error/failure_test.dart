import 'package:test/test.dart';
import 'package:glow_core/glow_core.dart';

void main() {
  group('Failure', () {
    group('NetworkFailure', () {
      test('should create network failure with message', () {
        const failure = NetworkFailure(message: 'No internet connection');

        expect(failure.message, 'No internet connection');
        expect(failure.code, null);
        expect(failure.stackTrace, null);
      });

      test('should create network failure with code and stack trace', () {
        final stackTrace = StackTrace.current;
        final failure = NetworkFailure(
          message: 'Connection timeout',
          code: 'NET_TIMEOUT',
          stackTrace: stackTrace,
        );

        expect(failure.message, 'Connection timeout');
        expect(failure.code, 'NET_TIMEOUT');
        expect(failure.stackTrace, stackTrace);
      });

      test('should have readable toString', () {
        const failure = NetworkFailure(
          message: 'Failed to connect',
          code: 'NET_001',
        );

        expect(
          failure.toString(),
          'Failure(message: Failed to connect, code: NET_001)',
        );
      });
    });

    group('ServerFailure', () {
      test('should create server failure with status code', () {
        const failure = ServerFailure(
          message: 'Internal server error',
          statusCode: 500,
        );

        expect(failure.message, 'Internal server error');
        expect(failure.statusCode, 500);
      });

      test('should create server failure without status code', () {
        const failure = ServerFailure(message: 'Unknown server error');

        expect(failure.message, 'Unknown server error');
        expect(failure.statusCode, null);
      });
    });

    group('CacheFailure', () {
      test('should create cache failure', () {
        const failure = CacheFailure(message: 'Cache not found');

        expect(failure.message, 'Cache not found');
        expect(failure.code, null);
      });

      test('should create cache failure with code', () {
        const failure = CacheFailure(
          message: 'Cache expired',
          code: 'CACHE_EXPIRED',
        );

        expect(failure.message, 'Cache expired');
        expect(failure.code, 'CACHE_EXPIRED');
      });
    });

    group('ValidationFailure', () {
      test('should create validation failure', () {
        const failure = ValidationFailure(message: 'Invalid email format');

        expect(failure.message, 'Invalid email format');
      });
    });

    group('AuthFailure', () {
      test('should create auth failure', () {
        const failure = AuthFailure(message: 'Invalid credentials');

        expect(failure.message, 'Invalid credentials');
      });
    });

    group('UnknownFailure', () {
      test('should create unknown failure', () {
        const failure = UnknownFailure(message: 'Something went wrong');

        expect(failure.message, 'Something went wrong');
      });
    });
  });
}
