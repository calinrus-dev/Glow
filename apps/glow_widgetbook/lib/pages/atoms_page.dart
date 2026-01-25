import 'package:flutter/material.dart';
import 'package:glow_ui/glow_ui.dart';

import '../widgets/component_section.dart';

/// Atoms page - Basic building blocks
class AtomsPage extends StatelessWidget {
  const AtomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildHeader(context),
        const SizedBox(height: 32),
        ComponentSection(
          title: 'Buttons',
          description: 'Interactive buttons with glow effects and HDR support',
          child: _buildButtonsSection(),
        ),
        const SizedBox(height: 32),
        ComponentSection(
          title: 'Inputs',
          description: 'Text inputs with focus states and glow effects',
          child: _buildInputsSection(),
        ),
        const SizedBox(height: 32),
        ComponentSection(
          title: 'Badges',
          description: 'Status indicators and labels with glow',
          child: _buildBadgesSection(),
        ),
        const SizedBox(height: 32),
        ComponentSection(
          title: 'Chips',
          description: 'Selectable tags and filters',
          child: _buildChipsSection(),
        ),
        const SizedBox(height: 32),
        ComponentSection(
          title: 'Avatars',
          description: 'User profile images with optional active states',
          child: _buildAvatarsSection(),
        ),
        const SizedBox(height: 32),
        ComponentSection(
          title: 'Skeletons',
          description: 'Loading placeholders with shimmer effect',
          child: _buildSkeletonsSection(),
        ),
        const SizedBox(height: 32),
        ComponentSection(
          title: 'Tooltips',
          description: 'Contextual help and information',
          child: _buildTooltipsSection(),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Atoms',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: GlowColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Basic building blocks of the design system. Atoms are the smallest, '
          'indivisible components that cannot be broken down further.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: GlowColors.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildButtonsSection() {
    return PlaygroundSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Variants', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              GlowButton(
                onPressed: () {},
                label: 'Primary',
                variant: GlowButtonVariant.primary,
              ),
              GlowButton(
                onPressed: () {},
                label: 'Secondary',
                variant: GlowButtonVariant.secondary,
              ),
              GlowButton(
                onPressed: () {},
                label: 'Ghost',
                variant: GlowButtonVariant.ghost,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Sizes', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              GlowButton(
                onPressed: () {},
                label: 'Small',
                size: GlowButtonSize.sm,
              ),
              GlowButton(
                onPressed: () {},
                label: 'Medium',
                size: GlowButtonSize.md,
              ),
              GlowButton(
                onPressed: () {},
                label: 'Large',
                size: GlowButtonSize.lg,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('States', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              GlowButton(
                onPressed: () {},
                label: 'Loading',
                isLoading: true,
              ),
              const GlowButton(
                onPressed: null,
                label: 'Disabled',
              ),
              GlowButton(
                onPressed: () {},
                label: 'With Icons',
                leadingIcon: Icons.star_rounded,
                trailingIcon: Icons.arrow_forward_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputsSection() {
    return const PlaygroundSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Basic Input', style: TextStyle(fontSize: 18)),
          SizedBox(height: 16),
          SizedBox(
            width: 400,
            child: GlowInput(
              hintText: 'Enter text...',
            ),
          ),
          SizedBox(height: 24),
          Text('With Label', style: TextStyle(fontSize: 18)),
          SizedBox(height: 16),
          SizedBox(
            width: 400,
            child: GlowInput(
              labelText: 'Email',
              hintText: 'your@email.com',
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
          SizedBox(height: 24),
          Text('Error State', style: TextStyle(fontSize: 18)),
          SizedBox(height: 16),
          SizedBox(
            width: 400,
            child: GlowInput(
              hintText: 'Invalid input',
              errorText: 'This field is required',
              prefixIcon: Icon(Icons.error_outline_rounded),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgesSection() {
    return const PlaygroundSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Variants', style: TextStyle(fontSize: 18)),
          SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              GlowBadge(
                label: 'Primary',
                variant: GlowBadgeVariant.primary,
              ),
              GlowBadge(
                label: 'Secondary',
                variant: GlowBadgeVariant.secondary,
              ),
              GlowBadge(
                label: 'Success',
                variant: GlowBadgeVariant.success,
              ),
              GlowBadge(
                label: 'Warning',
                variant: GlowBadgeVariant.warning,
              ),
              GlowBadge(
                label: 'Error',
                variant: GlowBadgeVariant.error,
              ),
              GlowBadge(
                label: 'Info',
                variant: GlowBadgeVariant.info,
              ),
            ],
          ),
          SizedBox(height: 24),
          Text('With Icons', style: TextStyle(fontSize: 18)),
          SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              GlowBadge(
                label: 'New',
                icon: Icons.star_rounded,
                variant: GlowBadgeVariant.primary,
              ),
              GlowBadge(
                label: 'Active',
                icon: Icons.check_circle_rounded,
                variant: GlowBadgeVariant.success,
              ),
            ],
          ),
          SizedBox(height: 24),
          Text('Dot Badge', style: TextStyle(fontSize: 18)),
          SizedBox(height: 16),
          Row(
            children: [
              GlowDotBadge(),
              SizedBox(width: 16),
              GlowDotBadge(
                color: GlowColors.success,
                size: 12,
              ),
              SizedBox(width: 16),
              GlowDotBadge(
                color: GlowColors.error,
                size: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChipsSection() {
    return PlaygroundSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Variants', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          const Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              GlowChip(
                label: 'Filled',
                variant: GlowChipVariant.filled,
              ),
              GlowChip(
                label: 'Outlined',
                variant: GlowChipVariant.outlined,
              ),
              GlowChip(
                label: 'Elevated',
                variant: GlowChipVariant.elevated,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('With Icons', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              GlowChip(
                label: 'Filter',
                icon: Icons.filter_list_rounded,
                deleteIcon: Icons.close_rounded,
                onDeleted: () {},
              ),
              const GlowChip(
                label: 'Selected',
                selected: true,
                icon: Icons.check_circle_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarsSection() {
    return const PlaygroundSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sizes', style: TextStyle(fontSize: 18)),
          SizedBox(height: 16),
          Row(
            children: [
              GlowAvatar(initials: 'AB', size: 32),
              SizedBox(width: 16),
              GlowAvatar(initials: 'CD', size: 48),
              SizedBox(width: 16),
              GlowAvatar(initials: 'EF', size: 64),
              SizedBox(width: 16),
              GlowAvatar(initials: 'GH', size: 80),
            ],
          ),
          SizedBox(height: 24),
          Text('Active State', style: TextStyle(fontSize: 18)),
          SizedBox(height: 16),
          Row(
            children: [
              GlowAvatar(initials: 'PR', size: 64, isActive: true),
              SizedBox(width: 16),
              GlowAvatar(initials: 'SE', size: 64, isActive: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonsSection() {
    return const PlaygroundSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Text Skeleton', style: TextStyle(fontSize: 18)),
          SizedBox(height: 16),
          Column(
            children: [
              GlowSkeletonText(width: 200),
              SizedBox(height: 8),
              GlowSkeletonText(width: 150),
              SizedBox(height: 8),
              GlowSkeletonText(width: 180),
            ],
          ),
          SizedBox(height: 24),
          Text('Avatar Skeleton', style: TextStyle(fontSize: 18)),
          SizedBox(height: 16),
          Row(
            children: [
              GlowSkeletonAvatar(size: 48),
              SizedBox(width: 16),
              GlowSkeletonAvatar(size: 64),
            ],
          ),
          SizedBox(height: 24),
          Text('Card Skeleton', style: TextStyle(fontSize: 18)),
          SizedBox(height: 16),
          GlowSkeletonCard(
            width: 300,
            height: 120,
            padding: EdgeInsets.all(16),
          ),
        ],
      ),
    );
  }

  Widget _buildTooltipsSection() {
    return PlaygroundSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tooltips', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              GlowTooltip(
                message: 'This is a tooltip',
                child: GlowButton(
                  onPressed: () {},
                  label: 'Hover me',
                ),
              ),
              GlowTooltip(
                message: 'Tooltip with longer text that explains more details',
                child: GlowButton(
                  onPressed: () {},
                  label: 'Long tooltip',
                  variant: GlowButtonVariant.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
