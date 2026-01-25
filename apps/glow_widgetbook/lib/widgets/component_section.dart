import 'package:flutter/material.dart';
import 'package:glow_ui/glow_ui.dart';

/// Section wrapper for component documentation
class ComponentSection extends StatelessWidget {
  const ComponentSection({
    required this.title,
    required this.description,
    required this.child,
    super.key,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: GlowColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: GlowColors.textSecondary,
              ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}

/// Playground section with background
class PlaygroundSection extends StatelessWidget {
  const PlaygroundSection({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(GlowSpacing.lg),
      decoration: BoxDecoration(
        color: GlowColors.backgroundCard,
        borderRadius: BorderRadius.circular(GlowSpacing.md),
        border: Border.all(color: GlowColors.border),
      ),
      child: child,
    );
  }
}
