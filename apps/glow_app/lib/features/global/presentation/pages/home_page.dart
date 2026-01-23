import 'package:flutter/material.dart';
import 'package:glow_ui/glow_ui.dart';
import 'package:go_router/go_router.dart';
import '../models/mock_space.dart';
import '../widgets/space_card.dart';

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
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton.extended(
              onPressed: () {},
              backgroundColor: GlowColors.primaryGlow,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Create Space'),
            )
          : null,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return _buildSpacesTab();
      default:
        return _buildPlaceholderTab();
    }
  }

  Widget _buildHomeTab() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(GlowSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: GlowColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: GlowSpacing.xs),
                Text(
                  'Explore your spaces and connect',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: GlowColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(GlowSpacing.lg),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 0.8,
              crossAxisSpacing: GlowSpacing.md,
              mainAxisSpacing: GlowSpacing.md,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final space = MockSpace.mockSpaces[index];
                return SpaceCard(
                  space: space,
                  onTap: () => context.push('/space/${space.name}'),
                );
              },
              childCount: MockSpace.mockSpaces.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpacesTab() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(GlowSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All Spaces',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: GlowColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: GlowSpacing.xs),
                Text(
                  'Discover and join communities',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: GlowColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(GlowSpacing.lg),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 350,
              childAspectRatio: 0.75,
              crossAxisSpacing: GlowSpacing.md,
              mainAxisSpacing: GlowSpacing.md,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final space = MockSpace.mockSpaces[index];
                return SpaceCard(
                  space: space,
                  onTap: () => context.push('/space/${space.name}'),
                );
              },
              childCount: MockSpace.mockSpaces.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderTab() {
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
            'This section will be available soon',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: GlowColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}
