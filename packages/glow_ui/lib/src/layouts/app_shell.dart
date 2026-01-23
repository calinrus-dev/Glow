import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';

/// Navigation destination for the app shell
class GlowNavDestination {
  const GlowNavDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

/// App shell providing the base structure for all main screens
class AppShell extends StatelessWidget {
  const AppShell({
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.destinations,
    required this.child,
    this.title,
    this.actions,
    this.floatingActionButton,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<GlowNavDestination> destinations;
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useRail = constraints.maxWidth >= 768;

        return Scaffold(
          appBar: _buildAppBar(context, useRail),
          body: useRail
              ? Row(
                  children: [
                    _buildNavigationRail(),
                    Expanded(child: child),
                  ],
                )
              : child,
          bottomNavigationBar: useRail ? null : _buildBottomNav(),
          floatingActionButton: floatingActionButton,
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, bool useRail) {
    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: GlowColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
            )
          : null,
      actions: actions,
      leading: useRail
          ? null
          : IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: () {},
              color: GlowColors.textSecondary,
            ),
    );
  }

  Widget _buildNavigationRail() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: GlowColors.border,
            width: 1,
          ),
        ),
      ),
      child: NavigationRail(
        selectedIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        labelType: NavigationRailLabelType.all,
        destinations: destinations.map((dest) {
          return NavigationRailDestination(
            icon: Icon(dest.icon),
            selectedIcon: Icon(dest.selectedIcon),
            label: Text(dest.label),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: GlowColors.border,
            width: 1,
          ),
        ),
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        backgroundColor: GlowColors.backgroundElevated,
        indicatorColor: GlowColors.primaryGlowSubtle,
        height: 72,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: destinations.map((dest) {
          return NavigationDestination(
            icon: Icon(dest.icon),
            selectedIcon: Container(
              padding: const EdgeInsets.all(GlowSpacing.xs),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(GlowSpacing.md),
                boxShadow: const [
                  BoxShadow(
                    color: GlowColors.primaryGlowSubtle,
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(dest.selectedIcon),
            ),
            label: dest.label,
          );
        }).toList(),
      ),
    );
  }
}
