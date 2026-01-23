import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glow_ui/glow_ui.dart';

import 'config/app_config.dart';
import 'router/app_router.dart';

class GlowApp extends ConsumerWidget {
  const GlowApp({
    required this.config,
    super.key,
  });

  final AppConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Glow',
      debugShowCheckedModeBanner: false,
      
      // Theme
      theme: GlowTheme.light(),
      darkTheme: GlowTheme.dark(),
      themeMode: ThemeMode.system,
      
      // Localization
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      
      // Routing
      routerConfig: router,
    );
  }
}
