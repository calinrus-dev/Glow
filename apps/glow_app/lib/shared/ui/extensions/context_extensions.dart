import 'package:flutter/material.dart';

/// Extension on BuildContext for easier navigation.
extension ContextExtensions on BuildContext {
  /// Returns the theme data.
  ThemeData get theme => Theme.of(this);

  /// Returns the text theme.
  TextTheme get textTheme => theme.textTheme;

  /// Returns the color scheme.
  ColorScheme get colorScheme => theme.colorScheme;

  /// Returns the media query data.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Returns the screen size.
  Size get screenSize => mediaQuery.size;

  /// Returns the screen width.
  double get screenWidth => screenSize.width;

  /// Returns the screen height.
  double get screenHeight => screenSize.height;

  /// Shows a snackbar.
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  /// Shows an error snackbar.
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.error,
      ),
    );
  }
}
