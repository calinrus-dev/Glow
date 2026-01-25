import 'package:flutter/material.dart';

import '../shaders/glow_shader.dart';
import '../theme/colors.dart';
import '../theme/effects.dart';
import '../theme/glow_theme_variants.dart';
import '../theme/spacing.dart';

/// Chip variant
enum GlowChipVariant {
  filled,
  outlined,
  elevated,
}

/// Professional chip component with HDR support
class GlowChip extends StatefulWidget {
  const GlowChip({
    required this.label,
    this.variant = GlowChipVariant.filled,
    this.selected = false,
    this.onSelected,
    this.onDeleted,
    this.avatar,
    this.deleteIcon,
    this.icon,
    this.showGlow = true,
    super.key,
  });

  final String label;
  final GlowChipVariant variant;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final VoidCallback? onDeleted;
  final Widget? avatar;
  final IconData? deleteIcon;
  final IconData? icon;
  final bool showGlow;

  @override
  State<GlowChip> createState() => _GlowChipState();
}

class _GlowChipState extends State<GlowChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final glowTheme = theme.glowTheme;
    final enableHdr = glowTheme?.enableHdr ?? false;
    final glowIntensity = theme.glowIntensity;

    final isInteractive = widget.onSelected != null;
    final isActive = widget.selected || _isHovered;

    final palette = _ChipPalette.resolve(
      variant: widget.variant,
      selected: widget.selected,
    );

    Widget content = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: GlowSpacing.sm,
        vertical: GlowSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: palette.background,
        borderRadius: BorderRadius.circular(20),
        border: widget.variant == GlowChipVariant.outlined
            ? Border.all(
                color: palette.border,
                width: 1.2,
              )
            : null,
        boxShadow: widget.variant == GlowChipVariant.elevated
            ? GlowEffects.softShadow(blur: 8, spread: -2)
            : widget.showGlow && (glowTheme?.enableGlow ?? true) && isActive
                ? [
                    ...GlowEffects.glowShadow(
                      color: palette.glow,
                      blur: 12 * glowIntensity,
                    ),
                  ]
                : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.avatar != null) ...[
            widget.avatar!,
            const SizedBox(width: GlowSpacing.xs),
          ],
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
              fontSize: 13,
              fontWeight: widget.selected ? FontWeight.w600 : FontWeight.w500,
              color: palette.foreground,
            ),
          ),
          if (widget.onDeleted != null) ...[
            const SizedBox(width: GlowSpacing.xs),
            GestureDetector(
              onTap: widget.onDeleted,
              child: Icon(
                widget.deleteIcon ?? Icons.close_rounded,
                size: 16,
                color: palette.foreground.withValues(alpha: 0.7),
              ),
            ),
          ],
        ],
      ),
    );

    // Apply HDR effect if enabled
    if (enableHdr && widget.showGlow && isActive) {
      content = ShaderMask(
        shaderCallback: (Rect bounds) => GlowShader.createHdrGlowGradient(
          baseColor: palette.glow,
          accentColor: palette.glow,
          bounds: bounds,
          intensity: glowIntensity * 0.8,
          bloom: 0.3,
        ),
        blendMode: BlendMode.srcATop,
        child: content,
      );
    }

    if (isInteractive) {
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => widget.onSelected?.call(!widget.selected),
            borderRadius: BorderRadius.circular(20),
            child: content,
          ),
        ),
      );
    }

    return content;
  }
}

class _ChipPalette {
  _ChipPalette({
    required this.background,
    required this.border,
    required this.foreground,
    required this.glow,
  });

  factory _ChipPalette.resolve({
    required GlowChipVariant variant,
    required bool selected,
  }) {
    final baseGlow =
        selected ? GlowColors.primaryGlow : GlowColors.textTertiary;

    switch (variant) {
      case GlowChipVariant.filled:
        return _ChipPalette(
          background: selected
              ? GlowColors.primaryGlow.withValues(alpha: 0.2)
              : GlowColors.backgroundCard,
          border: Colors.transparent,
          foreground:
              selected ? GlowColors.primaryGlowLight : GlowColors.textSecondary,
          glow: baseGlow,
        );
      case GlowChipVariant.outlined:
        return _ChipPalette(
          background: Colors.transparent,
          border: selected
              ? GlowColors.primaryGlow.withValues(alpha: 0.8)
              : GlowColors.border,
          foreground:
              selected ? GlowColors.primaryGlowLight : GlowColors.textSecondary,
          glow: baseGlow,
        );
      case GlowChipVariant.elevated:
        return _ChipPalette(
          background: selected
              ? GlowColors.backgroundElevated
              : GlowColors.backgroundCard,
          border: Colors.transparent,
          foreground:
              selected ? GlowColors.primaryGlowLight : GlowColors.textSecondary,
          glow: baseGlow,
        );
    }
  }

  final Color background;
  final Color border;
  final Color foreground;
  final Color glow;
}
