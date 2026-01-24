import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glow_ui/glow_ui.dart';

void main() {
  group('GlowInput', () {
    testWidgets('should render with label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: const Scaffold(
            body: GlowInput(
              label: 'Email',
            ),
          ),
        ),
      );

      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('should render with hint', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: const Scaffold(
            body: GlowInput(
              hint: 'Enter your email',
            ),
          ),
        ),
      );

      expect(find.text('Enter your email'), findsOneWidget);
    });

    testWidgets('should call onChanged when text changes', (tester) async {
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: Scaffold(
            body: GlowInput(
              label: 'Name',
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'John Doe');

      expect(changedValue, 'John Doe');
    });

    testWidgets('should show error text when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: const Scaffold(
            body: GlowInput(
              label: 'Email',
              errorText: 'Invalid email format',
            ),
          ),
        ),
      );

      expect(find.text('Invalid email format'), findsOneWidget);
    });

    testWidgets('should render prefix icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: const Scaffold(
            body: GlowInput(
              label: 'Search',
              prefixIcon: Icons.search,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('should render suffix icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: const Scaffold(
            body: GlowInput(
              label: 'Password',
              suffixIcon: Icons.visibility,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('should obscure text when isPassword is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: const Scaffold(
            body: GlowInput(
              label: 'Password',
              isPassword: true,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, true);
    });

    testWidgets('should be disabled when enabled is false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: const Scaffold(
            body: GlowInput(
              label: 'Disabled',
              enabled: false,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, false);
    });

    testWidgets('should support max lines', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: const Scaffold(
            body: GlowInput(
              label: 'Description',
              maxLines: 5,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLines, 5);
    });

    testWidgets('should use controller when provided', (tester) async {
      final controller = TextEditingController(text: 'Initial value');

      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: Scaffold(
            body: GlowInput(
              label: 'Name',
              controller: controller,
            ),
          ),
        ),
      );

      expect(find.text('Initial value'), findsOneWidget);
    });
  });
}
