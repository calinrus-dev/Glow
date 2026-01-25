import 'package:flutter/material.dart';

import '../shaders/glow_stroke.dart';
import '../theme/colors.dart';
import '../theme/effects.dart';
import '../theme/spacing.dart';

/// Badge variants
enum GlowBadgeVariant {
  primary,
  secondary,
  accent,
  success,
  warning,
  error,
  info,
  neutral,
}

/// Badge sizes
enum GlowBadgeSize {
  sm,
  md,
  lg,
}

/// Badge with glow effects
class GlowBadge extends StatelessWidget {
  const GlowBadge({
    required this.label,
    this.variant = GlowBadgeVariant.primary,
    this.size = GlowBadgeSize.md,
    this.showGlow = true,
    this.icon,
    this.onTap,
    super.key,
  });

  final String label;
  final GlowBadgeVariant variant;
  final GlowBadgeSize size;
  final bool showGlow;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final palette = BadgePalette.resolve(variant);
    final metrics = BadgeMetrics.resolve(size);

    final content = Row(
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
            letterSpacing: 0.2,
          ),
        ),
      ],
    );

    final badge = Container(
      padding: metrics.padding,
      decoration: BoxDecoration(
        color: palette.background,
        borderRadius: BorderRadius.circular(metrics.borderRadius),
        boxShadow: showGlow
            ? GlowEffects.hdrGlowShadow(
                color: palette.glow,
                blur: 16,
                intensity: 0.8,
              )
            : const [],
      ),
      child: showGlow
          ? GlowStroke(
              radius: metrics.borderRadius,
              strokeWidth: 1,
              color: palette.glow,
              opacity: 0.6,
              animate: false,
              child: content,
            )
          : content,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(metrics.borderRadius),
        child: badge,
      );
    }

    return badge;
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

class BadgePalette {
  BadgePalette({
    required this.background,
    required this.border,
    required this.foreground,
    required this.glow,
  });

  factory BadgePalette.resolve(GlowBadgeVariant variant) {
    switch (variant) {
      case GlowBadgeVariant.primary:
        return BadgePalette(
          background: GlowColors.primaryGlow.withValues(alpha: 0.15),
          border: GlowColors.primaryGlow.withValues(alpha: 0.6),
          foreground: GlowColors.primaryGlowLight,
          glow: GlowColors.primaryGlow,
        );
      case GlowBadgeVariant.secondary:
        return BadgePalette(
          background: GlowColors.secondaryGlow.withValues(alpha: 0.15),
          border: GlowColors.secondaryGlow.withValues(alpha: 0.6),
          foreground: GlowColors.secondaryGlowLight,
          glow: GlowColors.secondaryGlow,
        );
      case GlowBadgeVariant.accent:
        return BadgePalette(
          background: GlowColors.accentGlow.withValues(alpha: 0.15),
          border: GlowColors.accentGlow.withValues(alpha: 0.6),
          foreground: GlowColors.accentGlowLight,
          glow: GlowColors.accentGlow,
        );
      case GlowBadgeVariant.success:
        return BadgePalette(
          background: GlowColors.successSubtle,
          border: GlowColors.success.withValues(alpha: 0.6),
          foreground: GlowColors.success,
          glow: GlowColors.success,
        );
      case GlowBadgeVariant.warning:
        return BadgePalette(
          background: GlowColors.warningSubtle,
          border: GlowColors.warning.withValues(alpha: 0.6),
          foreground: GlowColors.warning,
          glow: GlowColors.warning,
        );
      case GlowBadgeVariant.error:
        return BadgePalette(
          background: GlowColors.errorSubtle,
          border: GlowColors.error.withValues(alpha: 0.6),
          foreground: GlowColors.error,
          glow: GlowColors.error,
        );
      case GlowBadgeVariant.info:
        return BadgePalette(
          background: GlowColors.infoSubtle,
          border: GlowColors.info.withValues(alpha: 0.6),
          foreground: GlowColors.info,
          glow: GlowColors.info,
        );
      case GlowBadgeVariant.neutral:
        return BadgePalette(
          background: GlowColors.backgroundCard,
          border: GlowColors.border,
          foreground: GlowColors.textSecondary,
          glow: GlowColors.textTertiary,
        );
    }
  }

  final Color background;
  final Color border;
  final Color foreground;
  final Color glow;
}

class BadgeMetrics {
  const BadgeMetrics({
    required this.padding,
    required this.fontSize,
    required this.iconSize,
    required this.borderRadius,
  });

  factory BadgeMetrics.resolve(GlowBadgeSize size) {
    switch (size) {
      case GlowBadgeSize.sm:
        return const BadgeMetrics(
          padding: EdgeInsets.symmetric(
            horizontal: GlowSpacing.sm,
            vertical: 2,
          ),
          fontSize: 11,
          iconSize: 12,
          borderRadius: 6,
        );
      case GlowBadgeSize.md:
        return const BadgeMetrics(
          padding: EdgeInsets.symmetric(
            horizontal: GlowSpacing.md,
            vertical: 4,
          ),
          fontSize: 12,
          iconSize: 14,
          borderRadius: 8,
        );
      case GlowBadgeSize.lg:
        return const BadgeMetrics(
          padding: EdgeInsets.symmetric(
            horizontal: GlowSpacing.md,
            vertical: 6,
          ),
          fontSize: 14,
          iconSize: 16,
          borderRadius: 10,
        );
    }
  }

  final EdgeInsets padding;
  final double fontSize;
  final double iconSize;
  final double borderRadius;
}
