import 'package:flutter/material.dart';

import '../shaders/glow_stroke.dart';
import '../theme/colors.dart';
import '../theme/effects.dart';
import '../theme/spacing.dart';
import 'badges.dart';

/// Chip variants
enum GlowChipVariant {
  filled,
  outlined,
  elevated,
}

/// Chip with glow effects
class GlowChip extends StatefulWidget {
  const GlowChip({
    required this.label,
    this.variant = GlowChipVariant.filled,
    this.badgeVariant = GlowBadgeVariant.primary,
    this.icon,
    this.trailingIcon,
    this.onTap,
    this.onDelete,
    this.selected = false,
    super.key,
  });

  final String label;
  final GlowChipVariant variant;
  final GlowBadgeVariant badgeVariant;
  final IconData? icon;
  final IconData? trailingIcon;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final bool selected;

  @override
  State<GlowChip> createState() => _GlowChipState();
}

class _GlowChipState extends State<GlowChip> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.selected || _isHovered || _isPressed;
    final palette = _ChipPalette.resolve(
      variant: widget.variant,
      badgeVariant: widget.badgeVariant,
      active: isActive,
    );

    final scale = _isPressed ? 0.97 : (_isHovered ? 1.02 : 1.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOutCubic,
          scale: scale,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(
              horizontal: GlowSpacing.md,
              vertical: GlowSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: palette.background,
              borderRadius: BorderRadius.circular(GlowSpacing.md),
              border: widget.variant == GlowChipVariant.outlined
                  ? Border.all(
                      color: palette.border,
                      width: 1.2,
                    )
                  : null,
              boxShadow: widget.variant == GlowChipVariant.elevated
                  ? GlowEffects.depthShadow(elevation: isActive ? 2 : 1)
                  : isActive
                      ? GlowEffects.hdrGlowShadow(
                          color: palette.glow,
                          blur: 20,
                          intensity: 0.7,
                        )
                      : const [],
            ),
            child: widget.variant == GlowChipVariant.outlined && isActive
                ? GlowStroke(
                    radius: GlowSpacing.md,
                    strokeWidth: 1.2,
                    color: palette.glow,
                    opacity: 0.6,
                    animate: false,
                    child: _buildContent(palette),
                  )
                : _buildContent(palette),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(_ChipPalette palette) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.icon != null) ...[
          Icon(
            widget.icon,
            size: 16,
            color: palette.foreground,
          ),
          const SizedBox(width: GlowSpacing.xs),
        ],
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: palette.foreground,
          ),
        ),
        if (widget.trailingIcon != null) ...[
          const SizedBox(width: GlowSpacing.xs),
          Icon(
            widget.trailingIcon,
            size: 16,
            color: palette.foreground,
          ),
        ],
        if (widget.onDelete != null) ...[
          const SizedBox(width: GlowSpacing.xs),
          GestureDetector(
            onTap: widget.onDelete,
            child: Icon(
              Icons.close_rounded,
              size: 16,
              color: palette.foreground.withValues(alpha: 0.7),
            ),
          ),
        ],
      ],
    );
  }
}

class _ChipPalette {
  _ChipPalette({
    required this.background,
    required this.foreground,
    required this.border,
    required this.glow,
  });

  factory _ChipPalette.resolve({
    required GlowChipVariant variant,
    required GlowBadgeVariant badgeVariant,
    required bool active,
  }) {
    final badgePalette = BadgePalette.resolve(badgeVariant);
    final intensity = active ? 1.0 : 0.7;

    switch (variant) {
      case GlowChipVariant.filled:
        return _ChipPalette(
          background: badgePalette.background,
          foreground: badgePalette.foreground,
          border: Colors.transparent,
          glow: badgePalette.glow,
        );
      case GlowChipVariant.outlined:
        return _ChipPalette(
          background: Colors.transparent,
          foreground: badgePalette.foreground,
          border: badgePalette.glow.withValues(alpha: 0.5 * intensity),
          glow: badgePalette.glow,
        );
      case GlowChipVariant.elevated:
        return _ChipPalette(
          background: GlowColors.backgroundCard,
          foreground: badgePalette.foreground,
          border: Colors.transparent,
          glow: badgePalette.glow,
        );
    }
  }

  final Color background;
  final Color foreground;
  final Color border;
  final Color glow;
}
