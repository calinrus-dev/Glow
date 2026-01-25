import 'package:flutter/material.dart';

import 'hdr_shader.dart';

/// Glow shader effects with HDR support
class GlowShader {
  const GlowShader._();

  /// Create standard glow gradient
  static LinearGradient createGlowGradient({
    required Color color,
    double opacity = 0.6,
  }) =>
      LinearGradient(
        colors: [
          color.withValues(alpha: opacity),
          color.withValues(alpha: 0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

  /// Create HDR-enhanced glow gradient
  static Shader createHdrGlowGradient({
    required Color baseColor,
    required Color accentColor,
    required Rect bounds,
    double intensity = 1.0,
    double bloom = 0.3,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) =>
      HdrShader.createHdrGradient(
        baseColor: baseColor,
        accentColor: accentColor,
        bounds: bounds,
        intensity: intensity,
        bloom: bloom,
        begin: begin,
        end: end,
      );

  /// Create radial HDR glow
  static Shader createRadialHdrGlow({
    required Color color,
    required Rect bounds,
    required Offset center,
    double radius = 100.0,
    double intensity = 1.0,
    double bloom = 0.4,
  }) =>
      HdrShader.createRadialHdrGlow(
        color: color,
        bounds: bounds,
        center: center,
        radius: radius,
        intensity: intensity,
        bloom: bloom,
      );
}
