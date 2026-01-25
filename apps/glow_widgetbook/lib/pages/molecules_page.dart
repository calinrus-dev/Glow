import 'package:flutter/material.dart';
import 'package:glow_ui/glow_ui.dart';

import '../widgets/component_section.dart';

/// Molecules page
class MoleculesPage extends StatelessWidget {
  const MoleculesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(
          'Molecules',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: GlowColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Composed components built from atoms',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: GlowColors.textSecondary,
              ),
        ),
        const SizedBox(height: 32),
        ComponentSection(
          title: 'Cards',
          description: 'Container components with glass effects',
          child: _buildCardsSection(context),
        ),
        const SizedBox(height: 32),
        ComponentSection(
          title: 'Dialogs',
          description: 'Modal dialogs with glow effects',
          child: _buildDialogsSection(context),
        ),
        const SizedBox(height: 32),
        ComponentSection(
          title: 'Bottom Sheets',
          description: 'Slide-up panels',
          child: _buildSheetsSection(context),
        ),
      ],
    );
  }

  Widget _buildCardsSection(BuildContext context) {
    return const PlaygroundSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlowCard(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Basic Card'),
            ),
          ),
          SizedBox(height: 16),
          GlowCard(
            isGlass: false,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Card without glass effect'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogsSection(BuildContext context) {
    return PlaygroundSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlowButton(
            onPressed: () {
              GlowDialog.show(
                context: context,
                title: 'Dialog Title',
                content: const Text('This is a dialog with glow effects'),
                actions: [
                  GlowButton(
                    onPressed: () => Navigator.pop(context),
                    label: 'Close',
                    variant: GlowButtonVariant.ghost,
                  ),
                ],
              );
            },
            label: 'Show Dialog',
          ),
          const SizedBox(height: 16),
          GlowButton(
            onPressed: () {
              GlowConfirmDialog.show(
                context: context,
                title: 'Confirm Action',
                message: 'Are you sure you want to proceed?',
              );
            },
            label: 'Show Confirm Dialog',
            variant: GlowButtonVariant.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildSheetsSection(BuildContext context) {
    return PlaygroundSection(
      child: GlowButton(
        onPressed: () {
          GlowBottomSheet.show(
            context: context,
            title: 'Bottom Sheet',
            child: const Padding(
              padding: EdgeInsets.all(24),
              child: Text('Bottom sheet content'),
            ),
          );
        },
        label: 'Show Bottom Sheet',
      ),
    );
  }
}
