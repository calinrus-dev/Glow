import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/effects.dart';
import '../theme/spacing.dart';

/// Subtle divider with a light glow
class GlowDivider extends StatelessWidget {
  const GlowDivider({
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
    this.color,
    super.key,
  });

  final double thickness;
  final double indent;
  final double endIndent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dividerColor = color ?? GlowColors.divider;

    return Padding(
      padding: EdgeInsets.only(
        left: indent,
        right: endIndent,
        top: GlowSpacing.xs,
        bottom: GlowSpacing.xs,
      ),
      child: Container(
        height: thickness,
        decoration: BoxDecoration(
          color: dividerColor,
          boxShadow: GlowEffects.glowShadow(
            color: GlowColors.primaryGlow,
            blur: 16,
          ),
        ),
      ),
    );
  }
}
