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
      resizeToAvoidBottomInset: true,
      body: _LoginBackground(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: GlowSpacing.lg,
              vertical: GlowSpacing.lg,
            ),
            child: Center(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: const _LoginView(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginBackground extends StatelessWidget {
  const _LoginBackground({required this.child});

  final Widget child;

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
          child,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
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
        ),
        const SizedBox(height: GlowSpacing.xs),
        Text(
          'Tu espacio. Tu estilo. Tu identidad.',
          style: textTheme.bodySmall?.copyWith(
            color: GlowColors.textSecondary,
          ),
        ),
        const SizedBox(height: GlowSpacing.lg),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: GlowGlassContainer(
              backgroundOpacity: 0.04,
              blurSigma: 10,
              child: Form(
                child: Column(
                  children: [
                    GlowSocialButton(
                      label: 'Continuar con Google',
                      icon: SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          'assets/icons/google_logo.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                      onPressed: isLoading ? null : () {},
                    ),
                    const SizedBox(height: GlowSpacing.sm),
                    GlowSocialButton(
                      label: 'Continuar con Apple',
                      icon: SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          'assets/icons/apple_logo.svg',
                          fit: BoxFit.contain,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      onPressed: isLoading ? null : () {},
                    ),
                    const SizedBox(height: GlowSpacing.sm),
                    GlowSocialButton(
                      label: 'Continuar con Facebook',
                      icon: SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          'assets/icons/facebook_logo.svg',
                          fit: BoxFit.contain,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF1877F2),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      onPressed: isLoading ? null : () {},
                    ),
                    const SizedBox(height: GlowSpacing.md),
                    const GlowDivider(),
                    const SizedBox(height: GlowSpacing.md),
                    GlowInput(
                      labelText: 'Usuario o correo',
                      hintText: 'nombre@glow.app',
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                      dense: true,
                      onChanged: (_) {},
                    ),
                    const SizedBox(height: GlowSpacing.md),
                    GlowInput(
                      labelText: 'Contraseña',
                      hintText: '••••••••',
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
                        ),
                      ),
                      onChanged: (_) {},
                    ),
                    const SizedBox(height: GlowSpacing.xs),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: GlowSpacing.xs,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) => setState(
                                () => _rememberMe = value ?? false,
                              ),
                              activeColor: GlowColors.primaryGlow,
                            ),
                            Text(
                              'Recordarme',
                              style: textTheme.bodySmall
                                  ?.copyWith(color: GlowColors.textSecondary),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Olvidé la contraseña',
                            style: textTheme.bodySmall
                                ?.copyWith(color: GlowColors.primaryGlowLight),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: GlowSpacing.sm),
                    GlowPrimaryButton(
                      onPressed: isLoading
                          ? null
                          : () => ref
                              .read(authNotifierProvider.notifier)
                              .login('', ''),
                      label: 'Iniciar sesión',
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
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: GlowSpacing.md),
        GlowActionRow(
          alignment: MainAxisAlignment.center,
          actions: [
            Text(
              '¿No tienes cuenta?',
              style: textTheme.bodySmall
                  ?.copyWith(color: GlowColors.textSecondary),
            ),
            GlowButton(
              onPressed: () {},
              label: 'Crear cuenta',
              variant: GlowButtonVariant.ghost,
              padding: const EdgeInsets.symmetric(
                horizontal: GlowSpacing.sm,
                vertical: GlowSpacing.xs,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
