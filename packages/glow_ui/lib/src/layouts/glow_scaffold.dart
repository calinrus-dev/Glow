import 'package:flutter/material.dart';

import '../theme/colors.dart';

/// Base scaffold for Glow screens
class GlowScaffold extends StatelessWidget {
  const GlowScaffold({
    required this.body,
    this.appBar,
    this.navigationBar,
    this.floatingActionButton,
    this.extendBody = false,
    this.safeArea = true,
    this.backgroundDecoration,
    this.resizeToAvoidBottomInset = true,
    super.key,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? navigationBar;
  final Widget? floatingActionButton;
  final bool extendBody;
  final bool safeArea;
  final Decoration? backgroundDecoration;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    final content = safeArea ? SafeArea(child: body) : body;
    final decoration = backgroundDecoration ??
        const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.2,
            colors: [
              GlowColors.gradientAmbientStart,
              GlowColors.gradientAmbientEnd,
            ],
          ),
        );

    return Scaffold(
      backgroundColor: GlowColors.backgroundDark,
      appBar: appBar,
      body: Container(
        decoration: decoration,
        child: content,
      ),
      bottomNavigationBar: navigationBar,
      floatingActionButton: floatingActionButton,
      extendBody: extendBody,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
