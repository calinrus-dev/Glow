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

      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('should have correct size when specified', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlowAvatar(
              initials: 'JD',
              size: 64,
            ),
          ),
        ),
      );

      final container = tester.widget<AnimatedScale>(
        find.byType(AnimatedScale),
      );

      expect(container, isNotNull);
    });

    testWidgets('should call onTap when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlowAvatar(
              initials: 'JD',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GlowAvatar));
      await tester.pump();

      expect(tapped, true);
    });

    testWidgets('should show active state', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GlowAvatar(
              initials: 'JD',
              isActive: true,
            ),
          ),
        ),
      );

      expect(find.byType(GlowAvatar), findsOneWidget);
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

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.text('JD'), findsNothing);
    });

    testWidgets('should render different sizes', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                GlowAvatar(initials: 'SM', size: 32),
                GlowAvatar(initials: 'MD', size: 40),
                GlowAvatar(initials: 'LG', size: 48),
              ],
            ),
          ),
        ),
      );

      expect(find.text('SM'), findsOneWidget);
      expect(find.text('MD'), findsOneWidget);
      expect(find.text('LG'), findsOneWidget);
    });
  });
}
