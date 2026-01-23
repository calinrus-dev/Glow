# glow_ui

UI component library for Glow Social Operating System.

## Overview

Glow's design system following **Atomic Design** principles with immersive, dark-first aesthetics.

## Architecture

### Atomic Design Hierarchy

```
Organisms (Complex, composed)
    ↑ composed of
Molecules (Multi-element, reusable)
    ↑ composed of
Atoms (Single-element, basic)
```

### Components

#### **Atoms** (`src/atoms/`)
Single-responsibility, indivisible UI elements:
- `buttons.dart` - GlowButton, GlowIconButton, GlowTextButton
- `inputs.dart` - GlowTextField, GlowPasswordField, GlowSearchField
- `icons.dart` - GlowIcon with glow effects
- `avatars.dart` - GlowAvatar (circle, square, with borders)
- `badges.dart` - Notification badges, status indicators

**Rules**:
- ✅ No business logic
- ✅ Accept callbacks only
- ✅ Stateless OR simple animation state
- ❌ NO data fetching
- ❌ NO providers

#### **Molecules** (`src/molecules/`)
Composed of multiple atoms, reusable patterns:
- `cards.dart` - GlowCard, GlowHoverCard, SpaceCard
- `list_items.dart` - GlowListTile, GlowChannelItem
- `dialogs.dart` - GlowDialog, GlowBottomSheet
- `navigation_items.dart` - NavItem, TabBar items

**Rules**:
- ✅ Combine atoms
- ✅ Handle internal UI state (hover, expansion)
- ✅ Accept data models via props
- ❌ NO providers (except theme)
- ❌ NO navigation logic

#### **Organisms** (`src/organisms/`)
Complex components with business logic:
- `navigation.dart` - AppShell, BottomNav, NavigationRail
- `app_bar.dart` - GlowAppBar, GlowSliverAppBar
- `feed.dart` - Entry feed components

**Rules**:
- ✅ Can use Riverpod providers
- ✅ Can trigger navigation
- ✅ Can fetch data
- ✅ Compose molecules and atoms

#### **Layouts** (`src/layouts/`)
Page-level structure, responsive behavior:
- `app_shell.dart` - Main app navigation shell
- `responsive.dart` - Breakpoint helpers
- `scaffold.dart` - Custom scaffold variants

### Theme System

#### **Visual Identity**
- **Mood**: Dark, atmospheric, immersive, mysterious yet welcoming
- **Colors**: Deep blacks, subtle grays, vibrant glow accents
- **Effects**: Subtle glow on interactive elements, smooth animations

#### **Color Palette** (`src/theme/colors.dart`)
```dart
// Backgrounds
backgroundDark: #0A0A0F
backgroundElevated: #121218

// Glow colors (brand)
primaryGlow: #7C3AED (Purple)
secondaryGlow: #EC4899 (Pink)
accentGlow: #06B6D4 (Cyan)

// Text
textPrimary: #FFFFFF
textSecondary: #B3B3B3
textTertiary: #666666
```

#### **Typography** (`src/theme/typography.dart`)
- Font Family: Inter (system fallback)
- Weights: 400 (regular), 500 (medium), 600 (semibold), 700 (bold)

#### **Spacing** (`src/theme/spacing.dart`)
```dart
xxs: 2.0
xs: 4.0
sm: 8.0
md: 16.0
lg: 24.0
xl: 32.0
xxl: 48.0
```

### Animation Principles
- Duration: 200-300ms for micro-interactions
- Easing: `Curves.easeInOut` for most, `Curves.elasticOut` for emphasis
- Hover states: Subtle scale (1.02x), glow increase, border color change

## Usage

```dart
import 'package:glow_ui/glow_ui.dart';

// Use atoms
GlowButton(
  label: 'Join Space',
  onPressed: () {},
)

// Use molecules
GlowCard(
  child: Text('Content'),
  onTap: () {},
)

// Use organisms
AppShell(
  currentIndex: 0,
  destinations: [...],
  child: HomePage(),
)
```
