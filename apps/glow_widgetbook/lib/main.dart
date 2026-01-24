import 'package:flutter/material.dart';
import 'package:glow_ui/glow_ui.dart';

void main() {
  runApp(const GlowWidgetbook());
}

class GlowWidgetbook extends StatelessWidget {
  const GlowWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glow UI Playground',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: GlowColors.backgroundDark,
        textTheme: GlowTypography.textTheme,
      ),
      home: const PlaygroundHome(),
    );
  }
}

class MyApp extends GlowWidgetbook {
  const MyApp({super.key});
}

enum PreviewMode { auto, mobile, desktop }

class PlaygroundHome extends StatefulWidget {
  const PlaygroundHome({super.key});

  @override
  State<PlaygroundHome> createState() => _PlaygroundHomeState();
}

class _PlaygroundHomeState extends State<PlaygroundHome> {
  int _selectedIndex = 0;
  PreviewMode _previewMode = PreviewMode.auto;
  double _previewScale = 1;

  final List<Widget> _pages = [
    const ButtonsPlayground(),
    const InputsPlayground(),
    const AvatarsPlayground(),
    const ColorsPlayground(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 900;
        final content = _wrapPreview(_pages[_selectedIndex]);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Glow UI Playground'),
            backgroundColor: GlowColors.backgroundElevated,
            elevation: 0,
          ),
          bottomNavigationBar: isCompact
              ? NavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() => _selectedIndex = index);
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.smart_button_outlined),
                      label: 'Buttons',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.input_outlined),
                      label: 'Inputs',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.account_circle_outlined),
                      label: 'Avatars',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.palette_outlined),
                      label: 'Colors',
                    ),
                  ],
                )
              : null,
          body: isCompact
              ? Column(
                  children: [
                    _PreviewToolbar(
                      previewMode: _previewMode,
                      previewScale: _previewScale,
                      onPreviewModeChanged: (mode) {
                        setState(() => _previewMode = mode);
                      },
                      onPreviewScaleChanged: (value) {
                        setState(() => _previewScale = value);
                      },
                    ),
                    const Divider(height: 1),
                    Expanded(child: content),
                  ],
                )
              : Row(
                  children: [
                    NavigationRail(
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (index) {
                        setState(() => _selectedIndex = index);
                      },
                      backgroundColor: GlowColors.backgroundElevated,
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.smart_button_outlined),
                          label: Text('Buttons'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.input_outlined),
                          label: Text('Inputs'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.account_circle_outlined),
                          label: Text('Avatars'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.palette_outlined),
                          label: Text('Colors'),
                        ),
                      ],
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    Expanded(
                      child: Column(
                        children: [
                          _PreviewToolbar(
                            previewMode: _previewMode,
                            previewScale: _previewScale,
                            onPreviewModeChanged: (mode) {
                              setState(() => _previewMode = mode);
                            },
                            onPreviewScaleChanged: (value) {
                              setState(() => _previewScale = value);
                            },
                          ),
                          const Divider(height: 1),
                          Expanded(child: content),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _wrapPreview(Widget child) {
    final isMobile = _previewMode == PreviewMode.mobile;

    if (_previewMode == PreviewMode.auto) {
      return child;
    }

    final maxWidth = isMobile ? 420.0 : 1100.0;
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
            boxShadow: GlowEffects.softShadow(blur: 20, spread: -8),
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

class _PreviewToolbar extends StatelessWidget {
  const _PreviewToolbar({
    required this.previewMode,
    required this.previewScale,
    required this.onPreviewModeChanged,
    required this.onPreviewScaleChanged,
  });

  final PreviewMode previewMode;
  final double previewScale;
  final ValueChanged<PreviewMode> onPreviewModeChanged;
  final ValueChanged<double> onPreviewScaleChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlowColors.backgroundElevated,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 8,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.devices_outlined, size: 18),
              const SizedBox(width: 8),
              DropdownButton<PreviewMode>(
                value: previewMode,
                onChanged: (value) {
                  if (value != null) {
                    onPreviewModeChanged(value);
                  }
                },
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
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.zoom_out_map, size: 18),
              const SizedBox(width: 8),
              SizedBox(
                width: 160,
                child: Slider(
                  value: previewScale,
                  min: 0.8,
                  max: 1.2,
                  divisions: 8,
                  label: previewScale.toStringAsFixed(2),
                  onChanged: onPreviewScaleChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ButtonsPlayground extends StatefulWidget {
  const ButtonsPlayground({super.key});

  @override
  State<ButtonsPlayground> createState() => _ButtonsPlaygroundState();
}

class _ButtonsPlaygroundState extends State<ButtonsPlayground> {
  GlowButtonVariant _variant = GlowButtonVariant.primary;
  GlowButtonSize _size = GlowButtonSize.md;
  bool _loading = false;
  bool _expand = false;
  bool _glass = true;
  bool _leading = false;
  bool _trailing = false;
  double _glowBoost = 1;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text(
          'Physics Sandbox',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Tap, hold, and drag to feel the real button physics.',
          style: TextStyle(fontSize: 14, color: GlowColors.textSecondary),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            DropdownButton<GlowButtonVariant>(
              value: _variant,
              onChanged: (value) {
                if (value != null) {
                  setState(() => _variant = value);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: GlowButtonVariant.primary,
                  child: Text('Primary'),
                ),
                DropdownMenuItem(
                  value: GlowButtonVariant.secondary,
                  child: Text('Secondary'),
                ),
                DropdownMenuItem(
                  value: GlowButtonVariant.ghost,
                  child: Text('Ghost'),
                ),
              ],
            ),
            DropdownButton<GlowButtonSize>(
              value: _size,
              onChanged: (value) {
                if (value != null) {
                  setState(() => _size = value);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: GlowButtonSize.sm,
                  child: Text('Small'),
                ),
                DropdownMenuItem(
                  value: GlowButtonSize.md,
                  child: Text('Medium'),
                ),
                DropdownMenuItem(
                  value: GlowButtonSize.lg,
                  child: Text('Large'),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Loading'),
                Switch(
                  value: _loading,
                  onChanged: (value) => setState(() => _loading = value),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Expand'),
                Switch(
                  value: _expand,
                  onChanged: (value) => setState(() => _expand = value),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Glass'),
                Switch(
                  value: _glass,
                  onChanged: (value) => setState(() => _glass = value),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Leading'),
                Switch(
                  value: _leading,
                  onChanged: (value) => setState(() => _leading = value),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Trailing'),
                Switch(
                  value: _trailing,
                  onChanged: (value) => setState(() => _trailing = value),
                ),
              ],
            ),
            SizedBox(
              width: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Glow Boost: ${_glowBoost.toStringAsFixed(2)}'),
                  Slider(
                    value: _glowBoost,
                    min: 0.8,
                    max: 1.6,
                    divisions: 8,
                    onChanged: (value) => setState(() => _glowBoost = value),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: GlowButton(
            onPressed: () {},
            label: 'Interact Me',
            variant: _variant,
            size: _size,
            isLoading: _loading,
            expand: _expand,
            glass: _glass,
            glowBoost: _glowBoost,
            leadingIcon: _leading ? Icons.star_rounded : null,
            trailingIcon: _trailing ? Icons.arrow_forward_rounded : null,
          ),
        ),
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 24),
        const Text(
          'GlowButton',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        const Text('Primary Variant', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        GlowButton(
          onPressed: () {},
          label: 'Primary Button',
          variant: GlowButtonVariant.primary,
        ),
        const SizedBox(height: 16),
        GlowButton(
          onPressed: () {},
          label: 'With Leading Icon',
          leadingIcon: Icons.star_rounded,
          variant: GlowButtonVariant.primary,
        ),
        const SizedBox(height: 16),
        GlowButton(
          onPressed: () {},
          label: 'With Trailing Icon',
          trailingIcon: Icons.arrow_forward_rounded,
          variant: GlowButtonVariant.primary,
        ),
        const SizedBox(height: 24),
        const Text('Secondary Variant', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        GlowButton(
          onPressed: () {},
          label: 'Secondary Button',
          variant: GlowButtonVariant.secondary,
        ),
        const SizedBox(height: 24),
        const Text('Ghost Variant', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        GlowButton(
          onPressed: () {},
          label: 'Ghost Button',
          variant: GlowButtonVariant.ghost,
        ),
        const SizedBox(height: 24),
        const Text('Disabled State', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        const GlowButton(
          onPressed: null,
          label: 'Disabled Button',
          variant: GlowButtonVariant.primary,
        ),
        const SizedBox(height: 24),
        const Text('Loading State', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        GlowButton(
          onPressed: () {},
          label: 'Loading...',
          isLoading: true,
          variant: GlowButtonVariant.primary,
        ),
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 24),
        const Text(
          'GlowPrimaryButton',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GlowPrimaryButton(
          onPressed: () {},
          label: 'Primary Action',
        ),
        const SizedBox(height: 16),
        GlowPrimaryButton(
          onPressed: () {},
          label: 'Loading Primary',
          isLoading: true,
        ),
      ],
    );
  }
}

class InputsPlayground extends StatefulWidget {
  const InputsPlayground({super.key});

  @override
  State<InputsPlayground> createState() => _InputsPlaygroundState();
}

class _InputsPlaygroundState extends State<InputsPlayground> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text(
          'GlowInput',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        const Text('Basic Input', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: const GlowInput(
            hintText: 'Enter text...',
          ),
        ),
        const SizedBox(height: 24),
        const Text('With Label', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: const GlowInput(
            labelText: 'Username',
            hintText: 'Enter username',
          ),
        ),
        const SizedBox(height: 24),
        const Text('With Prefix Icon', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: const GlowInput(
            hintText: 'Email',
            prefixIcon: Icon(Icons.email_outlined),
            dense: true,
          ),
        ),
        const SizedBox(height: 24),
        const Text('Password Field', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: GlowInput(
            hintText: 'Password',
            obscureText: _obscurePassword,
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            suffixIcon: IconButton(
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                size: 20,
                color: GlowColors.textPrimary.withValues(alpha: 0.7),
              ),
            ),
            dense: true,
          ),
        ),
        const SizedBox(height: 24),
        const Text('With Error', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: const GlowInput(
            hintText: 'Email',
            errorText: 'Invalid email address',
            prefixIcon: Icon(Icons.error_outline_rounded),
            dense: true,
          ),
        ),
        const SizedBox(height: 24),
        const Text('With Helper Text', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: const GlowInput(
            hintText: 'Username',
            helperText: 'Must be at least 3 characters',
            prefixIcon: Icon(Icons.person_outline_rounded),
            dense: true,
          ),
        ),
      ],
    );
  }
}

class AvatarsPlayground extends StatelessWidget {
  const AvatarsPlayground({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: const [
        Text(
          'GlowAvatar',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 24),
        Text('Sizes', style: TextStyle(fontSize: 18)),
        SizedBox(height: 16),
        Row(
          children: [
            GlowAvatar(
              size: 32,
              initials: 'AB',
            ),
            SizedBox(width: 16),
            GlowAvatar(
              size: 48,
              initials: 'CD',
            ),
            SizedBox(width: 16),
            GlowAvatar(
              size: 64,
              initials: 'EF',
            ),
            SizedBox(width: 16),
            GlowAvatar(
              size: 80,
              initials: 'GH',
            ),
          ],
        ),
        SizedBox(height: 24),
        Text('With Custom Border', style: TextStyle(fontSize: 18)),
        SizedBox(height: 16),
        Row(
          children: [
            GlowAvatar(
              size: 64,
              initials: 'PR',
              isActive: true,
            ),
            SizedBox(width: 16),
            GlowAvatar(
              size: 64,
              initials: 'SE',
              isActive: true,
            ),
            SizedBox(width: 16),
            GlowAvatar(
              size: 64,
              initials: 'AC',
              isActive: true,
            ),
          ],
        ),
      ],
    );
  }
}

class ColorsPlayground extends StatelessWidget {
  const ColorsPlayground({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text(
          'Color Palette',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        _buildColorSection('Background Colors', [
          const _ColorItem('backgroundDark', GlowColors.backgroundDark),
          const _ColorItem('backgroundElevated', GlowColors.backgroundElevated),
        ]),
        const SizedBox(height: 24),
        _buildColorSection('Glow Colors', [
          const _ColorItem('primaryGlow', GlowColors.primaryGlow),
          const _ColorItem('secondaryGlow', GlowColors.secondaryGlow),
          const _ColorItem('accentGlow', GlowColors.accentGlow),
        ]),
        const SizedBox(height: 24),
        _buildColorSection('Text Colors', [
          const _ColorItem('textPrimary', GlowColors.textPrimary),
          const _ColorItem('textSecondary', GlowColors.textSecondary),
          const _ColorItem('textTertiary', GlowColors.textTertiary),
        ]),
        const SizedBox(height: 24),
        _buildColorSection('Border Colors', [
          const _ColorItem('border', GlowColors.border),
          const _ColorItem('borderGlow', GlowColors.borderGlow),
        ]),
      ],
    );
  }

  Widget _buildColorSection(String title, List<_ColorItem> colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        ...colors.map(
          (color) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 60,
                  decoration: BoxDecoration(
                    color: color.color,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: GlowColors.border),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      color.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '#${color.color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: GlowColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ColorItem {
  const _ColorItem(this.name, this.color);
  final String name;
  final Color color;
}
