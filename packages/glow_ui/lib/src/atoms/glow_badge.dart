import 'package:flutter/material.dart';

import '../shaders/glow_shader.dart';
import '../theme/colors.dart';
import '../theme/effects.dart';
import '../theme/glow_theme_variants.dart';
import '../theme/spacing.dart';
import 'badges.dart';

/// Professional badge component with HDR support
class GlowBadge extends StatelessWidget {
  const GlowBadge({
    required this.label,
    this.variant = GlowBadgeVariant.primary,
    this.size = GlowBadgeSize.md,
    this.icon,
    this.onTap,
    this.showGlow = true,
    super.key,
  });

  final String label;
  final GlowBadgeVariant variant;
  final GlowBadgeSize size;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool showGlow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final glowTheme = theme.glowTheme;
    final enableHdr = glowTheme?.enableHdr ?? false;
    final glowIntensity = theme.glowIntensity;

    final palette = BadgePalette.resolve(variant);
    final metrics = BadgeMetrics.resolve(size);

    Widget content = Container(
      padding: metrics.padding,
      decoration: BoxDecoration(
        color: palette.background,
        borderRadius: BorderRadius.circular(metrics.borderRadius),
        border: Border.all(
          color: palette.border,
          width: 1.2,
        ),
        boxShadow: showGlow && (glowTheme?.enableGlow ?? true)
            ? [
                ...GlowEffects.glowShadow(
                  color: palette.glow,
                  blur: 16 * glowIntensity,
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: metrics.iconSize,
              color: palette.foreground,
            ),
            const SizedBox(width: GlowSpacing.xs),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: metrics.fontSize,
              fontWeight: FontWeight.w500,
              color: palette.foreground,
            ),
          ),
        ],
      ),
    );

    // Apply HDR effect if enabled
    if (enableHdr && showGlow) {
      content = ShaderMask(
        shaderCallback: (Rect bounds) => GlowShader.createHdrGlowGradient(
          baseColor: palette.glow,
          accentColor: palette.glow,
          bounds: bounds,
          intensity: glowIntensity,
          bloom: 0.3,
        ),
        blendMode: BlendMode.srcATop,
        child: content,
      );
    }

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(metrics.borderRadius),
          child: content,
        ),
      );
    }

    return content;
  }
}

/// Dot badge indicator
class GlowDotBadge extends StatelessWidget {
  const GlowDotBadge({
    this.color,
    this.size = 8,
    this.showGlow = true,
    super.key,
  });

  final Color? color;
  final double size;
  final bool showGlow;

  @override
  Widget build(BuildContext context) {
    final dotColor = color ?? GlowColors.primaryGlow;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: dotColor,
        boxShadow: showGlow
            ? GlowEffects.hdrGlowShadow(
                color: dotColor,
                blur: size * 2,
                intensity: 0.9,
              )
            : const [],
      ),
    );
  }
}
