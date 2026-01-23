import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/effects.dart';
import '../theme/spacing.dart';

/// Glass container with subtle blur and glow
class GlowGlassContainer extends StatelessWidget {
  const GlowGlassContainer({
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.blurSigma = 8,
    this.backgroundOpacity = 0.02,
    this.borderColor,
    this.elevation = 0,
    this.accentedBorder = false,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final double blurSigma;
  final double backgroundOpacity;
  final Color? borderColor;
  final double elevation;
  final bool accentedBorder;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(GlowSpacing.md);

    final base = Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: elevation > 0
            ? GlowEffects.softShadow(blur: 20, spread: -10)
            : const [],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            padding: padding ?? const EdgeInsets.all(GlowSpacing.md),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: radius,
              border: Border.all(
                color: borderColor ??
                    GlowColors.accentPrimary.withValues(alpha: 0.5),
                width: 1.2,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );

    if (!accentedBorder) {
      return Container(margin: margin, child: base);
    }

    return Container(
      margin: margin,
      padding: const EdgeInsets.all(1.2),
      decoration: BoxDecoration(
        borderRadius: radius,
        color: Colors.transparent,
        boxShadow: GlowEffects.glowShadow(
          color: GlowColors.primaryGlow,
          blur: 20,
        ),
      ),
      child: base,
    );
  }
}
