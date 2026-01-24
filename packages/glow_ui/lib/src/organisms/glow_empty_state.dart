import 'package:flutter/material.dart';

import '../atoms/glow_icon.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';

/// Empty state with calm tone
class GlowEmptyState extends StatelessWidget {
  const GlowEmptyState({
    required this.title,
    this.description,
    this.icon,
    this.action,
    this.padding,
    super.key,
  });

  final String title;
  final String? description;
  final IconData? icon;
  final Widget? action;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: padding ?? const EdgeInsets.all(GlowSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            GlowIcon(
              icon: icon!,
              size: 40,
              color: GlowColors.textTertiary,
              glow: true,
              glowColor: GlowColors.accentGlow,
            ),
            const SizedBox(height: GlowSpacing.md),
          ],
          Text(
            title,
            style:
                textTheme.titleLarge?.copyWith(color: GlowColors.textPrimary),
            textAlign: TextAlign.center,
          ),
          if (description != null) ...[
            const SizedBox(height: GlowSpacing.sm),
            Text(
              description!,
              style: textTheme.bodyMedium
                  ?.copyWith(color: GlowColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
          if (action != null) ...[
            const SizedBox(height: GlowSpacing.lg),
            action!,
          ],
        ],
      ),
    );
  }
}
