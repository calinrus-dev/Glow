import 'package:flutter/material.dart';

extension ColorWithValues on Color {
  /// Returns a copy of this color with the given alpha (0.0-1.0) or int (0-255).
  Color withValues({double? alpha, int? alphaInt}) {
    if (alpha != null) {
      return withAlpha((alpha.clamp(0.0, 1.0) * 255).round());
    } else if (alphaInt != null) {
      return withAlpha(alphaInt.clamp(0, 255));
    }
    return this;
  }
}
