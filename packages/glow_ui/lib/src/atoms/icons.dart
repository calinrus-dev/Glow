import 'package:flutter/material.dart';

/// Glow icon wrapper
class GlowIcon extends StatelessWidget {
  const GlowIcon({
    required this.icon,
    this.size,
    this.color,
    super.key,
  });

  final IconData icon;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) => Icon(
      icon,
      size: size,
      color: color,
    );
}
