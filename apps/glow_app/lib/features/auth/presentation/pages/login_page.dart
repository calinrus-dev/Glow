import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glow_ui/glow_ui.dart';

import '../bloc/auth_bloc.dart';

/// Login page.
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlowScaffold(
      safeArea: false,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const Positioned.fill(
            child: _LoginBackground(),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: GlowSpacing.lg,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: const _LoginView(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginBackground extends StatelessWidget {
  const _LoginBackground();

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.2,
                colors: [
                  Color(0xFF101022),
                  GlowColors.backgroundDark,
                ],
              ),
            ),
          ),
          Positioned(
            top: -80,
            left: -40,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: GlowColors.primaryGlowSubtle,
                boxShadow: GlowEffects.glowShadow(
                  color: GlowColors.primaryGlow,
                  blur: 120,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            right: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: GlowColors.accentGlowSubtle,
                boxShadow: GlowEffects.glowShadow(
                  color: GlowColors.accentGlow,
                  blur: 140,
                ),
              ),
            ),
          ),
        ],
      );
}

class _LoginView extends ConsumerStatefulWidget {
  const _LoginView();

  @override
  ConsumerState<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<_LoginView> {
  bool _rememberMe = true;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final textTheme = Theme.of(context).textTheme;
    final isLoading = authState.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        const SizedBox(height: GlowSpacing.xxl),
        _GlowLogo(),
        const SizedBox(height: GlowSpacing.xs),
        Text(
          'Your Space. Your style. Your identity.',
          style: textTheme.bodySmall?.copyWith(
            color: GlowColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: GlowSpacing.xl),

        // Form
        GlowInput(
          hintText: 'Username or email',
          prefixIcon: const Icon(Icons.person_outline_rounded),
          dense: true,
          onChanged: (_) {},
        ),
        const SizedBox(height: GlowSpacing.md),
        GlowInput(
          hintText: 'Password',
          obscureText: _obscurePassword,
          prefixIcon: const Icon(Icons.lock_outline_rounded),
          dense: true,
          suffixIcon: IconButton(
            onPressed: () => setState(
              () => _obscurePassword = !_obscurePassword,
            ),
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
              size: 20,
              color: GlowColors.textPrimary.withValues(alpha: 0.7),
            ),
          ),
          onChanged: (_) {},
        ),
        const SizedBox(height: GlowSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                    value: _rememberMe,
                    onChanged: (value) => setState(
                      () => _rememberMe = value ?? false,
                    ),
                    activeColor: GlowColors.primaryGlow,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const SizedBox(width: GlowSpacing.xs),
                Text(
                  'Remember me',
                  style: textTheme.bodySmall?.copyWith(
                    color: GlowColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Forgot password?',
                style: textTheme.bodySmall?.copyWith(
                  color: GlowColors.primaryGlowLight,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: GlowSpacing.lg),
        GlowPrimaryButton(
          onPressed: isLoading
              ? null
              : () => ref
                  .read(authNotifierProvider.notifier)
                  .login('', ''),
          label: 'Sign in',
          isLoading: isLoading,
        ),
        if (authState.maybeWhen(
          error: (_) => true,
          orElse: () => false,
        )) ...[
          const SizedBox(height: GlowSpacing.sm),
          authState.maybeWhen(
            error: (message) => Text(
              message,
              style: textTheme.bodySmall
                  ?.copyWith(color: GlowColors.error),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
        const SizedBox(height: GlowSpacing.lg),
        Row(
          children: [
            const Expanded(child: GlowDivider()),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: GlowSpacing.md,
              ),
              child: Text(
                'Or continue with',
                style: textTheme.bodySmall?.copyWith(
                  color: GlowColors.textTertiary,
                  fontSize: 12,
                ),
              ),
            ),
            const Expanded(child: GlowDivider()),
          ],
        ),
        const SizedBox(height: GlowSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialButton(
              svgAsset: 'assets/icons/google_logo.svg',
              onPressed: isLoading ? null : () {},
            ),
            const SizedBox(width: GlowSpacing.md),
            _SocialButton(
              svgAsset: 'assets/icons/apple_logo.svg',
              onPressed: isLoading ? null : () {},
            ),
          ],
        ),
        const SizedBox(height: GlowSpacing.xl),
        GlowActionRow(
          alignment: MainAxisAlignment.center,
          actions: [
            Text(
              "Don't have an account?",
              style: textTheme.bodySmall?.copyWith(
                color: GlowColors.textSecondary,
                fontSize: 13,
              ),
            ),
            GlowButton(
              onPressed: () {},
              label: 'Create one',
              variant: GlowButtonVariant.ghost,
              padding: const EdgeInsets.symmetric(
                horizontal: GlowSpacing.sm,
                vertical: GlowSpacing.xs,
              ),
            ),
          ],
        ),
        const SizedBox(height: GlowSpacing.lg),
      ],
    );
  }
}

/// Logo component with glow effect
class _GlowLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      alignment: Alignment.center,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => GlowShader.createGlowGradient(
            color: GlowColors.primaryGlow,
            opacity: 0.45,
          ).createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: Text(
            'Glow',
            style: textTheme.displaySmall?.copyWith(
              color: GlowColors.textPrimary,
              fontWeight: FontWeight.w700,
              shadows: [
                Shadow(
                  color: GlowColors.primaryGlow.withValues(alpha: 0.5),
                  blurRadius: 18,
                ),
              ],
            ),
          ),
        ),
        Text(
          'Glow',
          style: textTheme.displaySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            shadows: [
              Shadow(
                color: GlowColors.primaryGlow.withValues(alpha: 0.35),
                blurRadius: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Compact social login button
class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.svgAsset,
    required this.onPressed,
  });

  final String svgAsset;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: 64,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: GlowColors.backgroundElevated.withValues(alpha: 0.3),
          side: BorderSide(
            color: GlowColors.border.withValues(alpha: 0.5),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero,
        ),
        child: SvgPicture.asset(
          svgAsset,
          height: 22,
          width: 22,
          colorFilter: svgAsset.contains('apple')
              ? const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                )
              : null,
        ),
      ),
    );
  }
}
