import 'package:glow_core/glow_core.dart';
import 'package:test/test.dart';

void main() {
  group('Validators', () {
    group('isValidEmail', () {
      test('should return true for valid emails', () {
        expect(Validators.isValidEmail('user@example.com'), true);
        expect(Validators.isValidEmail('john.doe@company.co.uk'), true);
        expect(Validators.isValidEmail('test+tag@domain.com'), true);
        expect(Validators.isValidEmail('user_123@test-domain.org'), true);
      });

      test('should return false for invalid emails', () {
        expect(Validators.isValidEmail(''), false);
        expect(Validators.isValidEmail('notanemail'), false);
        expect(Validators.isValidEmail('@example.com'), false);
        expect(Validators.isValidEmail('user@'), false);
        expect(Validators.isValidEmail('user @example.com'), false);
        expect(Validators.isValidEmail('user@example'), false);
      });
    });

    group('hasMinLength', () {
      test('should return true when length meets minimum', () {
        expect(Validators.hasMinLength('hello', 5), true);
        expect(Validators.hasMinLength('hello world', 5), true);
      });

      test('should return false when length is less than minimum', () {
        expect(Validators.hasMinLength('hi', 5), false);
        expect(Validators.hasMinLength('', 1), false);
      });
    });

    group('hasMaxLength', () {
      test('should return true when length is within maximum', () {
        expect(Validators.hasMaxLength('hello', 10), true);
        expect(Validators.hasMaxLength('hi', 5), true);
      });

      test('should return false when length exceeds maximum', () {
        expect(Validators.hasMaxLength('hello world', 5), false);
        expect(Validators.hasMaxLength('test', 3), false);
      });
    });

    group('isEmpty', () {
      test('should return true for empty or whitespace strings', () {
        expect(Validators.isEmpty(''), true);
        expect(Validators.isEmpty('   '), true);
        expect(Validators.isEmpty('\t\n'), true);
      });

      test('should return false for non-empty strings', () {
        expect(Validators.isEmpty('hello'), false);
        expect(Validators.isEmpty('  text  '), false);
      });
    });

    group('isValidUrl', () {
      test('should return true for valid URLs', () {
        expect(Validators.isValidUrl('https://example.com'), true);
        expect(Validators.isValidUrl('http://test.org'), true);
        expect(Validators.isValidUrl('https://sub.domain.com/path'), true);
        expect(
          Validators.isValidUrl('https://example.com/path?query=value'),
          true,
        );
      });

      test('should return false for invalid URLs', () {
        expect(Validators.isValidUrl(''), false);
        expect(Validators.isValidUrl('not a url'), false);
        expect(Validators.isValidUrl('ftp://example.com'), false);
        expect(Validators.isValidUrl('example.com'), false);
      });
    });

    group('isValidPhone', () {
      test('should return true for valid phone numbers', () {
        expect(Validators.isValidPhone('+1234567890'), true);
        expect(Validators.isValidPhone('123-456-7890'), true);
        expect(Validators.isValidPhone('(123) 456-7890'), true);
        expect(Validators.isValidPhone('+44 20 1234 5678'), true);
      });

      test('should return false for invalid phone numbers', () {
        expect(Validators.isValidPhone(''), false);
        expect(Validators.isValidPhone('123'), false);
        expect(Validators.isValidPhone('abc'), false);
      });
    });
  });
}
