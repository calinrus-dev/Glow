import 'package:flutter/material.dart';
import 'package:glow_ui/glow_ui.dart';

import 'pages/atoms_page.dart';
import 'pages/home_page.dart';
import 'pages/molecules_page.dart';
import 'pages/organisms_page.dart';
import 'pages/theme_page.dart';

/// Professional widgetbook app for Glow UI
class GlowWidgetbookApp extends StatelessWidget {
  const GlowWidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glow UI Design System',
      debugShowCheckedModeBanner: false,
      theme: GlowTheme.dark(),
      home: const WidgetbookHome(),
    );
  }
}

/// Main widgetbook home with navigation
class WidgetbookHome extends StatefulWidget {
  const WidgetbookHome({super.key});

  @override
  State<WidgetbookHome> createState() => _WidgetbookHomeState();
}

class _WidgetbookHomeState extends State<WidgetbookHome> {
  int _selectedIndex = 0;
  PreviewMode _previewMode = PreviewMode.auto;
  double _previewScale = 1;

  final List<_Category> _categories = [
    const _Category(
      title: 'Home',
      icon: Icons.home_rounded,
      page: HomePage(),
    ),
    const _Category(
      title: 'Atoms',
      icon: Icons.circle_outlined,
      page: AtomsPage(),
      description: 'Basic building blocks',
    ),
    const _Category(
      title: 'Molecules',
      icon: Icons.widgets_outlined,
      page: MoleculesPage(),
      description: 'Composed components',
    ),
    const _Category(
      title: 'Organisms',
      icon: Icons.view_module_outlined,
      page: OrganismsPage(),
      description: 'Complex components',
    ),
    const _Category(
      title: 'Theme',
      icon: Icons.palette_outlined,
      page: ThemePage(),
      description: 'Design tokens & styles',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 900;
        final currentPage = _categories[_selectedIndex].page;

        return Scaffold(
          appBar: _buildAppBar(),
          body: isCompact
              ? Column(
                  children: [
                    _buildPreviewToolbar(),
                    const Divider(height: 1),
                    Expanded(
                      child: _wrapPreview(currentPage),
                    ),
                  ],
                )
              : Row(
                  children: [
                    _buildNavigationRail(),
                    const VerticalDivider(thickness: 1, width: 1),
                    Expanded(
                      child: Column(
                        children: [
                          _buildPreviewToolbar(),
                          const Divider(height: 1),
                          Expanded(
                            child: _wrapPreview(currentPage),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          bottomNavigationBar: isCompact ? _buildBottomNav() : null,
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  GlowColors.primaryGlow,
                  GlowColors.accentGlow,
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: GlowEffects.hdrGlowShadow(
                color: GlowColors.primaryGlow,
                blur: 16,
              ),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              size: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          const Text('Glow UI Design System'),
        ],
      ),
      backgroundColor: GlowColors.backgroundElevated,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.search_rounded),
          tooltip: 'Search components',
          onPressed: () {
            // TODO: Implement search
          },
        ),
        IconButton(
          icon: const Icon(Icons.code_rounded),
          tooltip: 'View code',
          onPressed: () {
            // TODO: Show code view
          },
        ),
      ],
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() => _selectedIndex = index);
      },
      backgroundColor: GlowColors.backgroundElevated,
      labelType: NavigationRailLabelType.all,
      extended: false,
      destinations: _categories.map((category) {
        return NavigationRailDestination(
          icon: Icon(category.icon),
          selectedIcon: Icon(category.icon),
          label: Text(category.title),
        );
      }).toList(),
    );
  }

  Widget _buildBottomNav() {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() => _selectedIndex = index);
      },
      destinations: _categories.map((category) {
        return NavigationDestination(
          icon: Icon(category.icon),
          label: category.title,
        );
      }).toList(),
    );
  }

  Widget _buildPreviewToolbar() {
    return Container(
      color: GlowColors.backgroundElevated,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.devices_rounded, size: 18),
          const SizedBox(width: 8),
          DropdownButton<PreviewMode>(
            value: _previewMode,
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(
                value: PreviewMode.auto,
                child: Text('Auto'),
              ),
              DropdownMenuItem(
                value: PreviewMode.mobile,
                child: Text('Mobile'),
              ),
              DropdownMenuItem(
                value: PreviewMode.desktop,
                child: Text('Desktop'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _previewMode = value);
              }
            },
          ),
          const SizedBox(width: 24),
          const Icon(Icons.zoom_in_rounded, size: 18),
          const SizedBox(width: 8),
          SizedBox(
            width: 160,
            child: Slider(
              value: _previewScale,
              min: 0.5,
              max: 1.5,
              divisions: 20,
              label: _previewScale.toStringAsFixed(2),
              onChanged: (value) {
                setState(() => _previewScale = value);
              },
            ),
          ),
          const Spacer(),
          Text(
            _categories[_selectedIndex].description ?? '',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: GlowColors.textTertiary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _wrapPreview(Widget child) {
    if (_previewMode == PreviewMode.auto) {
      return child;
    }

    final isMobile = _previewMode == PreviewMode.mobile;
    final maxWidth = isMobile ? 420.0 : 1200.0;
    final radius = isMobile ? 26.0 : 16.0;

    return Center(
      child: Transform.scale(
        scale: _previewScale,
        alignment: Alignment.topCenter,
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          decoration: BoxDecoration(
            color: GlowColors.backgroundElevated,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: GlowColors.border),
            boxShadow: GlowEffects.hdrGlowShadow(
              color: GlowColors.primaryGlow,
              blur: 24,
              intensity: 0.3,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: child,
          ),
        ),
      ),
    );
  }
}

enum PreviewMode { auto, mobile, desktop }

class _Category {
  const _Category({
    required this.title,
    required this.icon,
    required this.page,
    this.description,
  });

  final String title;
  final IconData icon;
  final Widget page;
  final String? description;
}
