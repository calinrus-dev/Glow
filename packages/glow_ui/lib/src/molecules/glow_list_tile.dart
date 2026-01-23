import 'package:flutter/material.dart';

import '../atoms/glow_surface.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';

/// List tile with Glow styling
class GlowListTile extends StatelessWidget {
  const GlowListTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.dense = false,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlowSurface(
      padding: EdgeInsets.symmetric(
        horizontal: GlowSpacing.md,
        vertical: dense ? GlowSpacing.sm : GlowSpacing.md,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(GlowSpacing.md),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: GlowSpacing.md),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleMedium
                        ?.copyWith(color: GlowColors.textPrimary),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: GlowSpacing.xs),
                    Text(
                      subtitle!,
                      style: textTheme.bodySmall
                          ?.copyWith(color: GlowColors.textSecondary),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: GlowSpacing.md),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
