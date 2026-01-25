import 'package:glow_domain/glow_domain.dart';
import 'package:test/test.dart';

void main() {
  group('SpaceName', () {
    test('accepts valid space name', () {
      expect(() => SpaceName('MotoGP Racing'), returnsNormally);
      expect(() => SpaceName('Indie Cinema'), returnsNormally);
      expect(() => SpaceName('Dev Space'), returnsNormally);
      expect(() => SpaceName('Gaming'), returnsNormally);
    });

    test('trims whitespace', () {
      final name = SpaceName('  MotoGP Racing  ');
      expect(name.value, 'MotoGP Racing');
    });

    test('rejects empty name', () {
      expect(() => SpaceName(''), throwsArgumentError);
      expect(() => SpaceName('   '), throwsArgumentError);
    });

    test('rejects name too short', () {
      expect(() => SpaceName('A'), throwsArgumentError);
    });

    test('rejects name too long', () {
      final longName = 'A' * 51;
      expect(() => SpaceName(longName), throwsArgumentError);
    });

    test('rejects invalid characters', () {
      expect(() => SpaceName('Test@Space'), throwsArgumentError);
      expect(() => SpaceName('Space#123'), throwsArgumentError);
      expect(() => SpaceName('Test\$Space'), throwsArgumentError);
    });

    test(
        'accepts valid characters (letters, numbers, spaces, hyphens, underscores)',
        () {
      expect(() => SpaceName('Space-123'), returnsNormally);
      expect(() => SpaceName('Space_Name'), returnsNormally);
      expect(() => SpaceName('Space 123'), returnsNormally);
    });

    test('isValid returns true for valid names', () {
      expect(SpaceName.isValid('MotoGP Racing'), true);
      expect(SpaceName.isValid('Gaming'), true);
    });

    test('isValid returns false for invalid names', () {
      expect(SpaceName.isValid(''), false);
      expect(SpaceName.isValid('A'), false);
      expect(SpaceName.isValid('Test@Space'), false);
    });

    test('equality works correctly', () {
      final name1 = SpaceName('MotoGP Racing');
      final name2 = SpaceName('MotoGP Racing');
      final name3 = SpaceName('Indie Cinema');

      expect(name1, equals(name2));
      expect(name1, isNot(equals(name3)));
    });

    test('toString returns the value', () {
      final name = SpaceName('MotoGP Racing');
      expect(name.toString(), 'MotoGP Racing');
    });
  });

  group('SpaceSlug', () {
    test('accepts valid slug', () {
      expect(() => SpaceSlug('motogp-racing'), returnsNormally);
      expect(() => SpaceSlug('indie-cinema'), returnsNormally);
      expect(() => SpaceSlug('gaming'), returnsNormally);
      expect(() => SpaceSlug('dev-123'), returnsNormally);
    });

    test('creates slug from name', () {
      expect(SpaceSlug.fromName('MotoGP Racing').value, 'motogp-racing');
      expect(SpaceSlug.fromName('Indie Cinema').value, 'indie-cinema');
      expect(SpaceSlug.fromName('Gaming!!!').value, 'gaming');
      expect(
        SpaceSlug.fromName('Test   Multiple   Spaces').value,
        'test-multiple-spaces',
      );
    });

    test('rejects empty slug', () {
      expect(() => SpaceSlug(''), throwsArgumentError);
    });

    test('rejects slug too short', () {
      expect(() => SpaceSlug('a'), throwsArgumentError);
    });

    test('rejects slug too long', () {
      final longSlug = 'a' * 51;
      expect(() => SpaceSlug(longSlug), throwsArgumentError);
    });

    test('rejects uppercase letters', () {
      expect(() => SpaceSlug('MotoGP'), throwsArgumentError);
      expect(() => SpaceSlug('Test-Slug'), throwsArgumentError);
    });

    test('rejects invalid characters', () {
      expect(() => SpaceSlug('test_slug'), throwsArgumentError);
      expect(() => SpaceSlug('test slug'), throwsArgumentError);
      expect(() => SpaceSlug('test@slug'), throwsArgumentError);
    });

    test('rejects slugs starting or ending with hyphen', () {
      expect(() => SpaceSlug('-test'), throwsArgumentError);
      expect(() => SpaceSlug('test-'), throwsArgumentError);
      expect(() => SpaceSlug('-test-'), throwsArgumentError);
    });

    test('rejects consecutive hyphens', () {
      expect(() => SpaceSlug('test--slug'), throwsArgumentError);
      expect(() => SpaceSlug('test---slug'), throwsArgumentError);
    });

    test('isValid returns true for valid slugs', () {
      expect(SpaceSlug.isValid('motogp-racing'), true);
      expect(SpaceSlug.isValid('gaming'), true);
    });

    test('isValid returns false for invalid slugs', () {
      expect(SpaceSlug.isValid(''), false);
      expect(SpaceSlug.isValid('Test-Slug'), false);
      expect(SpaceSlug.isValid('test--slug'), false);
      expect(SpaceSlug.isValid('-test'), false);
    });

    test('equality works correctly', () {
      final slug1 = SpaceSlug('motogp-racing');
      final slug2 = SpaceSlug('motogp-racing');
      final slug3 = SpaceSlug('indie-cinema');

      expect(slug1, equals(slug2));
      expect(slug1, isNot(equals(slug3)));
    });

    test('toString returns the value', () {
      final slug = SpaceSlug('motogp-racing');
      expect(slug.toString(), 'motogp-racing');
    });
  });
}
