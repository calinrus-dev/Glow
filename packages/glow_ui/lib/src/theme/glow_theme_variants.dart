import 'package:flutter/material.dart';

import 'glow_theme.dart';

/// Glow visual mode - controls the intensity of visual effects
enum GlowVisualMode {
  /// Legacy mode - static UI, no animations, no glow, battery-friendly
  legacy,

  /// Glow mode (default) - soft glow, gentle pulses, glassmorphism, depth
  glow,

  /// Glow Up (premium) - multi-color glow, advanced gradients, animated effects
  glowUp,

  /// HDR mode - professional HDR effects with tone mapping and bloom
  hdr,
}

/// Enhanced theme system with visual mode variants
class GlowThemeVariants {
  const GlowThemeVariants._();

  /// Get theme based on visual mode
  static ThemeData getTheme({
    required GlowVisualMode mode,
    Brightness brightness = Brightness.dark,
  }) {
    final baseTheme =
        brightness == Brightness.dark ? GlowTheme.dark() : GlowTheme.light();

    return baseTheme.copyWith(
      extensions: <ThemeExtension<dynamic>>[
        GlowThemeExtension(
          mode: mode,
          enableAnimations: mode != GlowVisualMode.legacy,
          enableGlow: mode != GlowVisualMode.legacy,
          enableHdr: mode == GlowVisualMode.hdr,
          glowIntensity: _getGlowIntensity(mode),
          bloomIntensity: mode == GlowVisualMode.hdr ? 0.4 : 0.0,
        ),
      ],
    );
  }

  static double _getGlowIntensity(GlowVisualMode mode) {
    switch (mode) {
      case GlowVisualMode.legacy:
        return 0;
      case GlowVisualMode.glow:
        return 0.6;
      case GlowVisualMode.glowUp:
        return 1;
      case GlowVisualMode.hdr:
        return 1.2; // Can exceed 1.0 for HDR
    }
  }

  /// Legacy theme - static, no effects
  static ThemeData legacy({Brightness brightness = Brightness.dark}) =>
      getTheme(mode: GlowVisualMode.legacy, brightness: brightness);

  /// Default Glow theme
  static ThemeData glow({Brightness brightness = Brightness.dark}) =>
      getTheme(mode: GlowVisualMode.glow, brightness: brightness);

  /// Premium Glow Up theme
  static ThemeData glowUp({Brightness brightness = Brightness.dark}) =>
      getTheme(mode: GlowVisualMode.glowUp, brightness: brightness);

  /// HDR theme - professional effects
  static ThemeData hdr({Brightness brightness = Brightness.dark}) =>
      getTheme(mode: GlowVisualMode.hdr, brightness: brightness);
}

/// Theme extension for Glow-specific properties
class GlowThemeExtension extends ThemeExtension<GlowThemeExtension> {
  const GlowThemeExtension({
    required this.mode,
    required this.enableAnimations,
    required this.enableGlow,
    required this.enableHdr,
    required this.glowIntensity,
    required this.bloomIntensity,
  });

  final GlowVisualMode mode;
  final bool enableAnimations;
  final bool enableGlow;
  final bool enableHdr;
  final double glowIntensity;
  final double bloomIntensity;

  @override
  GlowThemeExtension copyWith({
    GlowVisualMode? mode,
    bool? enableAnimations,
    bool? enableGlow,
    bool? enableHdr,
    double? glowIntensity,
    double? bloomIntensity,
  }) {
    return GlowThemeExtension(
      mode: mode ?? this.mode,
      enableAnimations: enableAnimations ?? this.enableAnimations,
      enableGlow: enableGlow ?? this.enableGlow,
      enableHdr: enableHdr ?? this.enableHdr,
      glowIntensity: glowIntensity ?? this.glowIntensity,
      bloomIntensity: bloomIntensity ?? this.bloomIntensity,
    );
  }

  @override
  GlowThemeExtension lerp(
    ThemeExtension<GlowThemeExtension>? other,
    double t,
  ) {
    if (other is! GlowThemeExtension) {
      return this;
    }

    return GlowThemeExtension(
      mode: t < 0.5 ? mode : other.mode,
      enableAnimations: t < 0.5 ? enableAnimations : other.enableAnimations,
      enableGlow: t < 0.5 ? enableGlow : other.enableGlow,
      enableHdr: t < 0.5 ? enableHdr : other.enableHdr,
      glowIntensity: _lerpDouble(glowIntensity, other.glowIntensity, t),
      bloomIntensity: _lerpDouble(bloomIntensity, other.bloomIntensity, t),
    );
  }

  double _lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }
}

/// Extension to easily access Glow theme properties
extension GlowThemeExtensionX on ThemeData {
  GlowThemeExtension? get glowTheme => extension<GlowThemeExtension>();

  GlowVisualMode get glowMode => glowTheme?.mode ?? GlowVisualMode.glow;

  bool get enableGlowEffects => glowTheme?.enableGlow ?? true;

  bool get enableHdrEffects => glowTheme?.enableHdr ?? false;

  double get glowIntensity => glowTheme?.glowIntensity ?? 0.6;

  double get bloomIntensity => glowTheme?.bloomIntensity ?? 0.0;
}
