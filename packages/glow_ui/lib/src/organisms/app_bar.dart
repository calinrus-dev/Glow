import 'package:flutter/material.dart';

/// Glow app bar
class GlowAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlowAppBar({
    required this.title,
    this.actions,
    this.leading,
    super.key,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  @override
  Widget build(BuildContext context) => AppBar(
      title: Text(title),
      actions: actions,
      leading: leading,
    );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
