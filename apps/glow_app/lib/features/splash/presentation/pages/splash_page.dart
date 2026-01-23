import 'package:flutter/material.dart';
import 'package:glow_ui/glow_ui.dart';

/// Initial splash screen displayed when the app starts.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlowColors.backgroundDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(GlowSpacing.xxl),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  colors: [
                    GlowColors.primaryGlowSubtle,
                    Colors.transparent,
                  ],
                  stops: [0.0, 1.0],
                ),
                border: Border.all(
                  color: GlowColors.primaryGlow,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                size: 72,
                color: GlowColors.primaryGlow,
              ),
            ),
            const SizedBox(height: GlowSpacing.xl),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  GlowColors.primaryGlow,
                  GlowColors.secondaryGlow,
                ],
              ).createShader(bounds),
              child: Text(
                'Glow',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: GlowSpacing.md),
            Text(
              'Loading...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: GlowColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
