import 'package:glow_domain/glow_domain.dart';
import 'package:test/test.dart';

void main() {
  group('ChannelName', () {
    test('accepts valid channel name', () {
      expect(() => ChannelName('General Chat'), returnsNormally);
      expect(() => ChannelName('Announcements'), returnsNormally);
      expect(() => ChannelName('Help'), returnsNormally);
      expect(() => ChannelName('Off-Topic'), returnsNormally);
    });

    test('trims whitespace', () {
      final name = ChannelName('  General Chat  ');
      expect(name.value, 'General Chat');
    });

    test('rejects empty name', () {
      expect(() => ChannelName(''), throwsArgumentError);
      expect(() => ChannelName('   '), throwsArgumentError);
    });

    test('rejects name too short', () {
      expect(() => ChannelName('A'), throwsArgumentError);
    });

    test('rejects name too long', () {
      final longName = 'A' * 51;
      expect(() => ChannelName(longName), throwsArgumentError);
    });

    test('rejects invalid characters', () {
      expect(() => ChannelName('Test@Channel'), throwsArgumentError);
      expect(() => ChannelName('Channel#123'), throwsArgumentError);
      expect(() => ChannelName('Test\$Channel'), throwsArgumentError);
    });

    test(
        'accepts valid characters (letters, numbers, spaces, hyphens, underscores)',
        () {
      expect(() => ChannelName('Channel-123'), returnsNormally);
      expect(() => ChannelName('Channel_Name'), returnsNormally);
      expect(() => ChannelName('Channel 123'), returnsNormally);
    });

    test('isValid returns true for valid names', () {
      expect(ChannelName.isValid('General Chat'), true);
      expect(ChannelName.isValid('Help'), true);
    });

    test('isValid returns false for invalid names', () {
      expect(ChannelName.isValid(''), false);
      expect(ChannelName.isValid('A'), false);
      expect(ChannelName.isValid('Test@Channel'), false);
    });

    test('equality works correctly', () {
      final name1 = ChannelName('General Chat');
      final name2 = ChannelName('General Chat');
      final name3 = ChannelName('Announcements');

      expect(name1, equals(name2));
      expect(name1, isNot(equals(name3)));
    });

    test('toString returns the value', () {
      final name = ChannelName('General Chat');
      expect(name.toString(), 'General Chat');
    });
  });

  group('ChannelSlug', () {
    test('accepts valid slug', () {
      expect(() => ChannelSlug('general-chat'), returnsNormally);
      expect(() => ChannelSlug('announcements'), returnsNormally);
      expect(() => ChannelSlug('help'), returnsNormally);
      expect(() => ChannelSlug('off-topic'), returnsNormally);
    });

    test('creates slug from name', () {
      expect(ChannelSlug.fromName('General Chat').value, 'general-chat');
      expect(ChannelSlug.fromName('Announcements').value, 'announcements');
      expect(ChannelSlug.fromName('Help!!!').value, 'help');
      expect(ChannelSlug.fromName('Off   Topic').value, 'off-topic');
    });

    test('rejects empty slug', () {
      expect(() => ChannelSlug(''), throwsArgumentError);
    });

    test('rejects slug too short', () {
      expect(() => ChannelSlug('a'), throwsArgumentError);
    });

    test('rejects slug too long', () {
      final longSlug = 'a' * 51;
      expect(() => ChannelSlug(longSlug), throwsArgumentError);
    });

    test('rejects uppercase letters', () {
      expect(() => ChannelSlug('GeneralChat'), throwsArgumentError);
      expect(() => ChannelSlug('Test-Slug'), throwsArgumentError);
    });

    test('rejects invalid characters', () {
      expect(() => ChannelSlug('test_slug'), throwsArgumentError);
      expect(() => ChannelSlug('test slug'), throwsArgumentError);
      expect(() => ChannelSlug('test@slug'), throwsArgumentError);
    });

    test('rejects slugs starting or ending with hyphen', () {
      expect(() => ChannelSlug('-test'), throwsArgumentError);
      expect(() => ChannelSlug('test-'), throwsArgumentError);
      expect(() => ChannelSlug('-test-'), throwsArgumentError);
    });

    test('rejects consecutive hyphens', () {
      expect(() => ChannelSlug('test--slug'), throwsArgumentError);
      expect(() => ChannelSlug('test---slug'), throwsArgumentError);
    });

    test('isValid returns true for valid slugs', () {
      expect(ChannelSlug.isValid('general-chat'), true);
      expect(ChannelSlug.isValid('help'), true);
    });

    test('isValid returns false for invalid slugs', () {
      expect(ChannelSlug.isValid(''), false);
      expect(ChannelSlug.isValid('Test-Slug'), false);
      expect(ChannelSlug.isValid('test--slug'), false);
      expect(ChannelSlug.isValid('-test'), false);
    });

    test('equality works correctly', () {
      final slug1 = ChannelSlug('general-chat');
      final slug2 = ChannelSlug('general-chat');
      final slug3 = ChannelSlug('announcements');

      expect(slug1, equals(slug2));
      expect(slug1, isNot(equals(slug3)));
    });

    test('toString returns the value', () {
      final slug = ChannelSlug('general-chat');
      expect(slug.toString(), 'general-chat');
    });
  });
}
