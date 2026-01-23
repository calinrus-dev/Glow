import 'package:flutter/material.dart';
import 'package:glow_ui/glow_ui.dart';

/// Main home page of the application.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  static const _destinations = [
    GlowNavDestination(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
      label: 'Home',
    ),
    GlowNavDestination(
      icon: Icons.explore_outlined,
      selectedIcon: Icons.explore_rounded,
      label: 'Spaces',
    ),
    GlowNavDestination(
      icon: Icons.chat_bubble_outline_rounded,
      selectedIcon: Icons.chat_bubble_rounded,
      label: 'Messages',
    ),
    GlowNavDestination(
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppShell(
      currentIndex: _currentIndex,
      onDestinationSelected: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      destinations: _destinations,
      title: 'Glow',
      actions: [
        IconButton(
          icon: const Icon(Icons.search_rounded),
          onPressed: () {},
          color: GlowColors.textSecondary,
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
          color: GlowColors.textSecondary,
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: GlowColors.primaryGlow,
        child: const Icon(Icons.add_rounded),
      ),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(GlowSpacing.xl),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  GlowColors.primaryGlowSubtle,
                  GlowColors.secondaryGlowSubtle,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(GlowSpacing.xl),
              border: Border.all(
                color: GlowColors.borderGlow,
                width: 1,
              ),
            ),
            child: Icon(
              _destinations[_currentIndex].selectedIcon,
              size: 64,
              color: GlowColors.primaryGlow,
            ),
          ),
          const SizedBox(height: GlowSpacing.xl),
          Text(
            _destinations[_currentIndex].label,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: GlowColors.textPrimary,
                ),
          ),
          const SizedBox(height: GlowSpacing.md),
          Text(
            'Esta sección estará disponible pronto',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: GlowColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}
