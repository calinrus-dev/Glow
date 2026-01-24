import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glow_ui/glow_ui.dart';

void main() {
  group('GlowAvatar', () {
    testWidgets('should render with initials', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlowAvatar(
              initials: 'JD',
            ),
          ),
        ),
      );

      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('should render with image URL', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlowAvatar(
              imageUrl: 'https://example.com/avatar.jpg',
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should render with icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlowAvatar(
              icon: Icons.person,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('should have correct size for small variant', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlowAvatar(
              initials: 'JD',
              size: GlowAvatarSize.sm,
            ),
          ),
        ),
      );

      final container = tester.widget<SizedBox>(
        find.ancestor(
          of: find.text('JD'),
          matching: find.byType(SizedBox),
        ).first,
      );

      expect(container.width, 32.0);
      expect(container.height, 32.0);
    });

    testWidgets('should have correct size for medium variant', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlowAvatar(
              initials: 'JD',
              size: GlowAvatarSize.md,
            ),
          ),
        ),
      );

      final container = tester.widget<SizedBox>(
        find.ancestor(
          of: find.text('JD'),
          matching: find.byType(SizedBox),
        ).first,
      );

      expect(container.width, 40.0);
      expect(container.height, 40.0);
    });

    testWidgets('should have correct size for large variant', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlowAvatar(
              initials: 'JD',
              size: GlowAvatarSize.lg,
            ),
          ),
        ),
      );

      final container = tester.widget<SizedBox>(
        find.ancestor(
          of: find.text('JD'),
          matching: find.byType(SizedBox),
        ).first,
      );

      expect(container.width, 48.0);
      expect(container.height, 48.0);
    });

    testWidgets('should prioritize imageUrl over initials', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlowAvatar(
              imageUrl: 'https://example.com/avatar.jpg',
              initials: 'JD',
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.text('JD'), findsNothing);
    });
  });
}
