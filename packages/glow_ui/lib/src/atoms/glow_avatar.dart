import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/effects.dart';
import '../theme/spacing.dart';

/// Glow avatar with subtle border and optional active glow
class GlowAvatar extends StatelessWidget {
  const GlowAvatar({
    this.imageUrl,
    this.initials,
    this.size = 40,
    this.isActive = false,
    this.onTap,
    super.key,
  });

  final String? imageUrl;
  final String? initials;
  final double size;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(size / 2);

    return InkWell(
      onTap: onTap,
      borderRadius: radius,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(color: GlowColors.borderLight),
          boxShadow: isActive
              ? GlowEffects.glowShadow(color: GlowColors.primaryGlow, blur: 18)
              : GlowEffects.softShadow(blur: 12, spread: -6),
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: imageUrl != null
              ? Image.network(imageUrl!, fit: BoxFit.cover)
              : Container(
                  color: GlowColors.backgroundCard,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(GlowSpacing.xs),
                  child: Text(
                    (initials ?? '').toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: GlowColors.textPrimary),
                  ),
                ),
        ),
      ),
    );
  }
}
