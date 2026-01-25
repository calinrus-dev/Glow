import 'package:flutter/material.dart';
import 'package:glow_ui/glow_ui.dart';

/// Theme page
class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          'Theme & Design Tokens',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: GlowColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Colors, typography, spacing, and effects',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: GlowColors.textSecondary,
              ),
        ),
        const SizedBox(height: 32),
        _buildColorSection('Primary Colors', [
          const _ColorItem('primaryGlow', GlowColors.primaryGlow),
          const _ColorItem('secondaryGlow', GlowColors.secondaryGlow),
          const _ColorItem('accentGlow', GlowColors.accentGlow),
        ]),
        const SizedBox(height: 24),
        _buildColorSection('Background Colors', [
          const _ColorItem('backgroundDark', GlowColors.backgroundDark),
          const _ColorItem('backgroundElevated', GlowColors.backgroundElevated),
          const _ColorItem('backgroundCard', GlowColors.backgroundCard),
        ]),
        const SizedBox(height: 24),
        _buildColorSection('Text Colors', [
          const _ColorItem('textPrimary', GlowColors.textPrimary),
          const _ColorItem('textSecondary', GlowColors.textSecondary),
          const _ColorItem('textTertiary', GlowColors.textTertiary),
        ]),
      ],
    );
  }

  Widget _buildColorSection(String title, List<_ColorItem> colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: GlowColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        ...colors.map(
          (color) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 60,
                  decoration: BoxDecoration(
                    color: color.color,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: GlowColors.border),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      color.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: GlowColors.textPrimary,
                      ),
                    ),
                    Text(
                      '#${color.color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: GlowColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ColorItem {
  const _ColorItem(this.name, this.color);
  final String name;
  final Color color;
}
