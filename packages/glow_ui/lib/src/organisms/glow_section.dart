import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/spacing.dart';

/// Section wrapper with header and optional action
class GlowSection extends StatelessWidget {
  const GlowSection({
    required this.title,
    required this.child,
    this.subtitle,
    this.action,
    this.padding,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? action;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: padding ?? const EdgeInsets.all(GlowSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleLarge
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
              if (action != null) action!,
            ],
          ),
          const SizedBox(height: GlowSpacing.md),
          child,
        ],
      ),
    );
  }
}
