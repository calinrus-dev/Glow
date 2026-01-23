import 'package:flutter/material.dart';
import 'package:glow_ui/glow_ui.dart';

/// Authentication page for login and signup.
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlowColors.backgroundDark,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(GlowSpacing.xl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(GlowSpacing.lg),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [
                          GlowColors.primaryGlowSubtle,
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      size: 64,
                      color: GlowColors.primaryGlow,
                    ),
                  ),
                  const SizedBox(height: GlowSpacing.xl),
                  Text(
                    'Welcome to Glow',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: GlowColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: GlowSpacing.md),
                  Text(
                    'Create immersive Spaces with identity',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: GlowColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: GlowSpacing.xxl),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(GlowSpacing.sm),
                      child: Text('Sign in'),
                    ),
                  ),
                  const SizedBox(height: GlowSpacing.md),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(GlowSpacing.sm),
                      child: Text('Create account'),
                    ),
                  ),
                  const SizedBox(height: GlowSpacing.xxl),
                  Text(
                    'Authentication coming soon',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: GlowColors.textTertiary,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
