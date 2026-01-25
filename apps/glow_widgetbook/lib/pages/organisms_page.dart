import 'package:flutter/material.dart';
import 'package:glow_ui/glow_ui.dart';

/// Organisms page
class OrganismsPage extends StatelessWidget {
  const OrganismsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          'Organisms',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: GlowColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Complex components composed of molecules and atoms',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: GlowColors.textSecondary,
              ),
        ),
        const SizedBox(height: 32),
        const Text('Coming soon...'),
      ],
    );
  }
}
