import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'spacing.dart';
import 'typography.dart';

/// Glow theme configuration - Dark-first with subtle glow effects
class GlowTheme {
  const GlowTheme._();

  /// Dark theme (default)
  static ThemeData dark() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: GlowColors.backgroundDark,
        colorScheme: const ColorScheme.dark(
          primary: GlowColors.primaryGlow,
          primaryContainer: GlowColors.primaryGlowDark,
          secondary: GlowColors.secondaryGlow,
          secondaryContainer: GlowColors.secondaryGlowDark,
          tertiary: GlowColors.accentGlow,
          tertiaryContainer: GlowColors.accentGlowDark,
          surface: GlowColors.backgroundElevated,
          surfaceContainerHighest: GlowColors.backgroundCard,
          error: GlowColors.error,
          onPrimary: GlowColors.textOnGlow,
          onSecondary: GlowColors.textOnGlow,
          onSurface: GlowColors.textPrimary,
          onError: GlowColors.textOnGlow,
          outline: GlowColors.border,
          outlineVariant: GlowColors.borderLight,
        ),
        textTheme: GlowTypography.textTheme,
        appBarTheme: const AppBarTheme(
          backgroundColor: GlowColors.backgroundDark,
          elevation: 0,
          centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        cardTheme: CardThemeData(
          color: GlowColors.backgroundCard,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlowSpacing.md),
            side: const BorderSide(
              color: GlowColors.border,
              width: 1,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: GlowColors.primaryGlow,
            foregroundColor: GlowColors.textOnGlow,
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: GlowSpacing.lg,
              vertical: GlowSpacing.md,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(GlowSpacing.md),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: GlowColors.primaryGlow,
            side: const BorderSide(
              color: GlowColors.primaryGlow,
              width: 1.5,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: GlowSpacing.lg,
              vertical: GlowSpacing.md,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(GlowSpacing.md),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: GlowColors.primaryGlow,
            padding: const EdgeInsets.symmetric(
              horizontal: GlowSpacing.lg,
              vertical: GlowSpacing.md,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: GlowColors.backgroundElevated,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(GlowSpacing.md),
            borderSide: const BorderSide(
              color: GlowColors.border,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(GlowSpacing.md),
            borderSide: const BorderSide(
              color: GlowColors.border,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(GlowSpacing.md),
            borderSide: const BorderSide(
              color: GlowColors.primaryGlow,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(GlowSpacing.md),
            borderSide: const BorderSide(
              color: GlowColors.error,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: GlowSpacing.md,
            vertical: GlowSpacing.md,
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: GlowColors.divider,
          thickness: 1,
          space: 1,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: GlowColors.backgroundElevated,
          selectedItemColor: GlowColors.primaryGlow,
          unselectedItemColor: GlowColors.textTertiary,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
        navigationRailTheme: const NavigationRailThemeData(
          backgroundColor: GlowColors.backgroundElevated,
          selectedIconTheme: IconThemeData(
            color: GlowColors.primaryGlow,
          ),
          unselectedIconTheme: IconThemeData(
            color: GlowColors.textTertiary,
          ),
          selectedLabelTextStyle: TextStyle(
            color: GlowColors.primaryGlow,
          ),
          unselectedLabelTextStyle: TextStyle(
            color: GlowColors.textTertiary,
          ),
        ),
      );

  /// Light theme (placeholder for future)
  static ThemeData light() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: GlowColors.primaryGlow,
          brightness: Brightness.light,
        ),
        textTheme: GlowTypography.textTheme,
      );
}
