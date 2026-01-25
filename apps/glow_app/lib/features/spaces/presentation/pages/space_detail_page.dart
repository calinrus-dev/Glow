import 'package:flutter/material.dart';
import 'package:glow_ui/glow_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../global/presentation/models/mock_space.dart';

/// Space detail page showing a Space's content
class SpaceDetailPage extends StatelessWidget {
  const SpaceDetailPage({
    required this.spaceName,
    super.key,
  });

  final String spaceName;

  @override
  Widget build(BuildContext context) {
    final space = MockSpace.mockSpaces.firstWhere(
      (s) => s.name == spaceName,
      orElse: () => MockSpace.mockSpaces.first,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, space),
          SliverToBoxAdapter(
            child: _buildContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, MockSpace space) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () => context.pop(),
        color: Colors.white,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert_rounded),
          onPressed: () {},
          color: Colors.white,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          space.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: space.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha((0.7 * 255).round()),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              left: GlowSpacing.lg,
              child: Container(
                padding: const EdgeInsets.all(GlowSpacing.lg),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha((0.1 * 255).round()),
                  borderRadius: BorderRadius.circular(GlowSpacing.md),
                  border: Border.all(
                    color: Colors.white.withAlpha((0.2 * 255).round()),
                  ),
                ),
                child: Icon(
                  space.icon,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(GlowSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: GlowSpacing.md),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Join Space'),
                ),
              ),
              const SizedBox(width: GlowSpacing.md),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share_rounded),
                label: const Text('Share'),
              ),
            ],
          ),
          const SizedBox(height: GlowSpacing.xxl),
          Text(
            'About',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: GlowColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: GlowSpacing.md),
          Text(
            MockSpace.mockSpaces
                .firstWhere((s) => s.name == spaceName)
                .description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: GlowColors.textSecondary,
                ),
          ),
          const SizedBox(height: GlowSpacing.xxl),
          Text(
            'Channels',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: GlowColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: GlowSpacing.md),
          _buildChannelsPlaceholder(context),
        ],
      ),
    );
  }

  Widget _buildChannelsPlaceholder(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(GlowSpacing.xxl),
      decoration: BoxDecoration(
        color: GlowColors.backgroundElevated,
        borderRadius: BorderRadius.circular(GlowSpacing.md),
        border: Border.all(
          color: GlowColors.border,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(GlowSpacing.lg),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: [
                  GlowColors.primaryGlowSubtle,
                  Colors.transparent,
                ],
              ),
            ),
            child: const Icon(
              Icons.tag_rounded,
              size: 64,
              color: GlowColors.primaryGlow,
            ),
          ),
          const SizedBox(height: GlowSpacing.lg),
          Text(
            'Channels coming soon',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: GlowColors.textPrimary,
                ),
          ),
          const SizedBox(height: GlowSpacing.sm),
          Text(
            'Create and organize channels to connect\nwith members',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: GlowColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}
