import 'package:flutter/material.dart';
import 'package:glow_ui/glow_ui.dart';

/// Home page with overview
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildHero(context),
        const SizedBox(height: 48),
        _buildQuickLinks(context),
        const SizedBox(height: 48),
        _buildFeatures(context),
      ],
    );
  }

  Widget _buildHero(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Glow UI Design System',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: GlowColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          'A comprehensive design system for building immersive, '
          'living interfaces with HDR effects and offline-first architecture.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: GlowColors.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: GlowColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            GlowCard(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle_outlined),
                    SizedBox(width: 8),
                    Text('Atoms'),
                  ],
                ),
              ),
            ),
            GlowCard(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.widgets_outlined),
                    SizedBox(width: 8),
                    Text('Molecules'),
                  ],
                ),
              ),
            ),
            GlowCard(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.view_module_outlined),
                    SizedBox(width: 8),
                    Text('Organisms'),
                  ],
                ),
              ),
            ),
            GlowCard(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.palette_outlined),
                    SizedBox(width: 8),
                    Text('Theme'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatures(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Features',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: GlowColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildFeatureCard(
              icon: Icons.auto_awesome_rounded,
              title: 'HDR Effects',
              description: 'High dynamic range shaders for enhanced visuals',
            ),
            _buildFeatureCard(
              icon: Icons.blur_on_rounded,
              title: 'Glow System',
              description: 'Living UI with animated glow effects',
            ),
            _buildFeatureCard(
              icon: Icons.dark_mode_rounded,
              title: 'Dark First',
              description: 'Optimized for dark themes with glassmorphism',
            ),
            _buildFeatureCard(
              icon: Icons.phone_android_rounded,
              title: 'Responsive',
              description: 'Works seamlessly across all screen sizes',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return GlowCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 32,
              color: GlowColors.primaryGlow,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: GlowColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: GlowColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
