import 'package:flutter/material.dart';

/// Block theme
class BlockTheme {
  const BlockTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    this.borderRadius = 8.0,
    this.padding = 12.0,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final double padding;

  /// Default light theme
  static const BlockTheme light = BlockTheme(
    backgroundColor: Color(0xFFFFFFFF),
    borderColor: Color(0xFFE5E5E5),
    textColor: Color(0xFF171717),
  );

  /// Default dark theme
  static const BlockTheme dark = BlockTheme(
    backgroundColor: Color(0xFF262626),
    borderColor: Color(0xFF404040),
    textColor: Color(0xFFFAFAFA),
  );
}
