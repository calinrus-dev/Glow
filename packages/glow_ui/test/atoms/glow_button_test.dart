import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glow_ui/glow_ui.dart';

void main() {
  group('GlowButton', () {
    testWidgets('should render with label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: Scaffold(
            body: GlowButton(
              label: 'Click Me',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Click Me'), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: Scaffold(
            body: GlowButton(
              label: 'Click Me',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GlowButton));
      await tester.pump();

      expect(tapped, true);
    });

    testWidgets('should not call onPressed when disabled', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: Scaffold(
            body: GlowButton(
              label: 'Click Me',
              onPressed: null,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GlowButton));
      await tester.pump();

      expect(tapped, false);
    });

    testWidgets('should show loading indicator when loading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: Scaffold(
            body: GlowButton(
              label: 'Loading',
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should render leading icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: Scaffold(
            body: GlowButton(
              label: 'Add',
              leadingIcon: Icons.add,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should render trailing icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: Scaffold(
            body: GlowButton(
              label: 'Next',
              trailingIcon: Icons.arrow_forward,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('should expand when expand is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: Scaffold(
            body: SizedBox(
              width: 400,
              child: GlowButton(
                label: 'Expand',
                onPressed: () {},
                expand: true,
              ),
            ),
          ),
        ),
      );

      final buttonFinder = find.byType(GlowButton);
      final buttonWidth = tester.getSize(buttonFinder).width;

      expect(buttonWidth, greaterThan(350));
    });

    group('Variants', () {
      testWidgets('should render primary variant', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: GlowTheme.dark(),
            home: Scaffold(
              body: GlowButton(
                label: 'Primary',
                variant: GlowButtonVariant.primary,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byType(GlowButton), findsOneWidget);
      });

      testWidgets('should render secondary variant', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: GlowTheme.dark(),
            home: Scaffold(
              body: GlowButton(
                label: 'Secondary',
                variant: GlowButtonVariant.secondary,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byType(GlowButton), findsOneWidget);
      });

      testWidgets('should render ghost variant', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: GlowTheme.dark(),
            home: Scaffold(
              body: GlowButton(
                label: 'Ghost',
                variant: GlowButtonVariant.ghost,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byType(GlowButton), findsOneWidget);
      });
    });

    group('Sizes', () {
      testWidgets('should render small size', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: GlowTheme.dark(),
            home: Scaffold(
              body: GlowButton(
                label: 'Small',
                size: GlowButtonSize.sm,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byType(GlowButton), findsOneWidget);
      });

      testWidgets('should render medium size', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: GlowTheme.dark(),
            home: Scaffold(
              body: GlowButton(
                label: 'Medium',
                size: GlowButtonSize.md,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byType(GlowButton), findsOneWidget);
      });

      testWidgets('should render large size', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: GlowTheme.dark(),
            home: Scaffold(
              body: GlowButton(
                label: 'Large',
                size: GlowButtonSize.lg,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byType(GlowButton), findsOneWidget);
      });
    });
  });
}
