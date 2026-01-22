import 'package:flutter/material.dart';

/// Glow avatar widget
class GlowAvatar extends StatelessWidget {
  const GlowAvatar({
    this.imageUrl,
    this.initials,
    this.size = 40.0,
    super.key,
  });

  final String? imageUrl;
  final String? initials;
  final double size;

  @override
  Widget build(BuildContext context) => CircleAvatar(
      radius: size / 2,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null && initials != null
          ? Text(
              initials!,
              style: TextStyle(fontSize: size / 2.5),
            )
          : null,
    );
}
