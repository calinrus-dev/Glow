import 'package:flutter/material.dart';

/// Glow bottom navigation
class GlowBottomNav extends StatelessWidget {
  const GlowBottomNav({
    required this.currentIndex,
    required this.onTap,
    required this.items,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;

  @override
  Widget build(BuildContext context) => NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: items
          .map(
            (item) => NavigationDestination(
              icon: item.icon,
              label: item.label ?? '',
            ),
          )
          .toList(),
    );
}
