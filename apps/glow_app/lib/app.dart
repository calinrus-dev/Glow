import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:glow_ui/glow_ui.dart';

import 'config/app_config.dart';
import 'router/app_router.dart';

class GlowApp extends StatelessWidget {
  const GlowApp({
    required this.config,
    required this.router,
    super.key,
  });

  final AppConfig config;
  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Glow',
      debugShowCheckedModeBanner: false,
      
      // Theme
      theme: GlowTheme.light(),
      darkTheme: GlowTheme.dark(),
      themeMode: ThemeMode.system,
      
      // Localization
      // TODO: Uncomment after running flutter build or flutter run
      // localizationsDelegates: [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: AppLocalizations.supportedLocales,
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
      routerConfig: router.config,
    );
  }
}
