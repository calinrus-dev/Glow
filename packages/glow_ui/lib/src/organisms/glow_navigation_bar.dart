import 'package:flutter/material.dart';

import '../atoms/glow_icon.dart';
import '../layouts/glow_glass_container.dart';
import '../theme/colors.dart';
import '../theme/effects.dart';
import '../theme/spacing.dart';

class GlowNavigationItem {
  const GlowNavigationItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

/// Bottom navigation bar with glow on active items
class GlowNavigationBar extends StatelessWidget {
  const GlowNavigationBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final List<GlowNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) => GlowGlassContainer(
        padding: const EdgeInsets.symmetric(
          horizontal: GlowSpacing.md,
          vertical: GlowSpacing.sm,
        ),
        borderRadius: BorderRadius.circular(GlowSpacing.lg),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (var i = 0; i < items.length; i++)
              _GlowNavItem(
                item: items[i],
                isActive: i == currentIndex,
                onTap: () => onTap(i),
              ),
          ],
        ),
      );
}

class _GlowNavItem extends StatelessWidget {
  const _GlowNavItem({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final GlowNavigationItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: isActive ? GlowColors.textPrimary : GlowColors.textTertiary,
        );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(GlowSpacing.md),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: GlowSpacing.md,
          vertical: GlowSpacing.sm,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(GlowSpacing.md),
          boxShadow: isActive
              ? GlowEffects.glowShadow(color: GlowColors.primaryGlow)
              : const [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GlowIcon(
              icon: item.icon,
              size: 20,
              color:
                  isActive ? GlowColors.primaryGlow : GlowColors.textTertiary,
              glow: isActive,
            ),
            const SizedBox(height: GlowSpacing.xs),
            Text(item.label, style: textStyle),
          ],
        ),
      ),
    );
  }
}
