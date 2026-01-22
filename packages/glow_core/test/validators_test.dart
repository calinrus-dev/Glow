import 'package:glow_core/glow_core.dart';
import 'package:test/test.dart';

void main() {
  group('Validators', () {
    group('isValidEmail', () {
      test('returns true for valid email', () {
        expect(Validators.isValidEmail('test@example.com'), isTrue);
        expect(Validators.isValidEmail('user.name@domain.co.uk'), isTrue);
      });

      test('returns false for invalid email', () {
        expect(Validators.isValidEmail('invalid'), isFalse);
        expect(Validators.isValidEmail('invalid@'), isFalse);
        expect(Validators.isValidEmail('@domain.com'), isFalse);
      });
    });

    group('hasMinLength', () {
      test('returns true when length meets minimum', () {
        expect(Validators.hasMinLength('hello', 5), isTrue);
        expect(Validators.hasMinLength('hello', 3), isTrue);
      });

      test('returns false when length below minimum', () {
        expect(Validators.hasMinLength('hi', 5), isFalse);
      });
    });

    group('isEmpty', () {
      test('returns true for empty or whitespace strings', () {
        expect(Validators.isEmpty(''), isTrue);
        expect(Validators.isEmpty('   '), isTrue);
      });

      test('returns false for non-empty strings', () {
        expect(Validators.isEmpty('hello'), isFalse);
        expect(Validators.isEmpty(' hello '), isFalse);
      });
    });
  });
}
