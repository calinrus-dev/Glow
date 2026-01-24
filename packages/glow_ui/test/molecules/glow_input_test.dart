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
              labelText: 'Email',
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
              hintText: 'Enter your email',
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
              labelText: 'Name',
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
              labelText: 'Email',
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
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
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
              labelText: 'Password',
              suffixIcon: Icon(Icons.visibility),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('should obscure text when obscureText is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: const Scaffold(
            body: GlowInput(
              labelText: 'Password',
              obscureText: true,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, true);
    });

    testWidgets('should use controller when provided', (tester) async {
      final controller = TextEditingController(text: 'Initial value');

      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: Scaffold(
            body: GlowInput(
              labelText: 'Name',
              controller: controller,
            ),
          ),
        ),
      );

      expect(find.text('Initial value'), findsOneWidget);
    });

    testWidgets('should render dense variant', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: GlowTheme.dark(),
          home: const Scaffold(
            body: GlowInput(
              labelText: 'Compact',
              dense: true,
            ),
          ),
        ),
      );

      expect(find.byType(GlowInput), findsOneWidget);
    });
  });
}
