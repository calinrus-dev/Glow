# Glow

**Social platform for creating immersive digital spaces with identity.**

Glow transforms interests into **immersive places**. Not simple feeds or chats, but **Spaces** with atmosphere, structure, and personality where people live, not just interact.

---

## What is Glow?

Glow enables any interest—from MotoGP to independent cinema, from photography to software development—to become a **living digital space** with its own visual identity, culture, and immersive experience.

It's not a traditional social network. It's a platform to **inhabit communities**, not just consume content.

Glow redefines social interaction by centering it around **places**, not profiles. Each Space is a world with its own rules, aesthetics, and ways of being.

---

## Content Architecture

### Global Layer
**Global** is the top-level social feed and entry point to Glow:

- **Global Feed** - Entry feed with multiple views:
  - **For You** - Personalized content recommendations
  - **Popular** - Trending entries across all Spaces
  - **Recent** - Chronological timeline
  - **Featured** - Curated highlights
  
- **Entry Sources**:
  - User entries (individual creators)
  - Space entries (staff from Spaces can publish to Global)
  
- **Global Chats**:
  - **DMs** - Direct messages between users
  - **Groups** - Private group conversations
  
- **Global Profile** - Your main identity across Glow

### Spaces (Communities)
A **Space** is an immersive community within Glow. Each represents an interest, topic, or activity with:

- **Unique visual identity** - Custom gradients, colors, icons, atmosphere
- **Channels** - Composite immersive areas (see below)
- **Space Chats**:
  - **DMs** - Direct messages within the Space
  - **Private Groups** - Group conversations within Space context
- **Space Identity** - Your profile specific to this Space (different from Global)

**Examples:** MotoGP Racing Space, Indie Cinema Space, Open Source Development Space.

Spaces are not groups. They're **digital environments** designed for immersion.

### Channels (Within Spaces)
**Channels** are composite immersive areas that combine multiple content types:

Each Channel contains:
- **Text Chat** - Real-time messaging
- **Voice Chat** - Audio communication
- **Entries** - Block-based content (Notion-like)
- **Channel Masks** - Per-channel identity customization (nicknames, avatars)

Channels are NOT simple chat rooms - they're **immersive composite spaces** that blend real-time communication with persistent content.

### Entries (Content Blocks)
In Glow, traditional "posts" don't exist. Content is created through **Entries**: block-based canvases where users build without rigid templates.

**Entry Contexts:**
- **Global entries** - Appear in Global feed
- **Channel entries** - Belong to specific channels within Spaces
- **User entries** - Created by individual users
- **Space entries** - Created by Space staff, can be promoted to Global

An Entry is a blank space where you can combine:
- Rich text with formatting
- Images and media
- Embeds (videos, links, code)
- Visual elements and layouts

**Entries adapt** to each community's tone and evolve over time. They reflect creativity without artificial limitations.

Think of Entries as **expressive content units**, not constrained posts.

### Identity System (Multi-Layered)
Users have three layers of identity:

1. **Global Profile** - Your core identity across Glow (visible everywhere)
2. **Space Identity** - Different profile per Space (custom name, avatar, bio)
3. **Channel Masks** - Per-channel customization (nicknames, temporary identity)

This allows participation in diverse interests (e.g., professional dev communities and casual gaming Spaces) without context collapse.

Your identity adapts to where you are, not the other way around.

---

## Terminology (Strict - ALWAYS Use)

### Primary Concepts
- **Global** - Top-level feed and social layer
- **Spaces** - Immersive communities with unique visual identity
- **Channels** - Composite immersive areas (chats + entries) within Spaces
- **Entries** - Block-based content pieces (NOT "posts")
- **Masks** - Per-channel identity customization (nicknames, avatars)

### Content Types
- **Entry** - Block-based content (like Notion pages)
- **Chat Message** - Real-time text message
- **Voice Message** - Audio communication

### NEVER Use These Terms
❌ "posts" → Use **Entries**
❌ "groups" (for spaces) → Use **Spaces**
❌ "servers" → Use **Spaces**
❌ "communities" (when referring to Spaces) → Use **Spaces**
❌ "messages" (for entries) → Use **Entries**
❌ "channels" (for DMs) → Use **DMs** or **Group Chats**

---

## Experience & Aesthetics

Glow is designed for **immersion**:
- **Dark-first aesthetic** with glow/neon accents
- **Atmospheric UI** - depth, shadows, ambient effects
- **Smooth, intentional animations** - nothing feels abrupt
- **Sense of place** - each Space feels distinct

Aesthetics aren't decoration. They're **foundational** to the experience. Visual identity reinforces each Space's character.

Entering a Space should feel like **stepping into another world**, not just opening another tab.

---

## Tech Stack

```yaml
Framework: Flutter 3.19+
State: Riverpod + Freezed
Backend: Supabase (PostgreSQL, Auth, Realtime)
HTTP: Dio
Navigation: GoRouter
Monorepo: Melos
Code generation: Mason, build_runner
```

**Architecture:** Clean Architecture with strict layer separation.

**Packages:**
- `glow_core` - Base contracts, logger, utilities
- `glow_domain` - Entities, use cases, policies
- `glow_data` - Repositories, data sources
- `glow_api` - HTTP client
- `glow_auth` - Session and authentication management
- `glow_realtime` - Realtime connections
- `glow_blocks_engine` - Entry content engine (core logic)
- `glow_blocks_flutter` - Entry rendering widgets
- `glow_observability` - Logging and monitoring
- `glow_ui` - Design system

---

## Development

### Requirements
- Flutter 3.19+
- Dart 3.3+
- Melos CLI: `dart pub global activate melos`
- Mason CLI: `dart pub global activate mason_cli`

### Initial Setup

```bash
# Clone repository
git clone https://github.com/calinrus-dev/Glow.git
cd glow

# Bootstrap packages
melos bootstrap

# Configure environment variables
cp .env.example .env
# Edit .env with your Supabase credentials
```

### Main Commands

```bash
# Analyze code
melos run analyze

# Run tests
melos run test

# Format code
melos run format

# Code generation (Riverpod, Freezed)
cd apps/glow_app
dart run build_runner build --delete-conflicting-outputs

# Run app
cd apps/glow_app
flutter run
```

### Project Structure

```
glow/
├── apps/
│   └── glow_app/          # Main application
│       ├── lib/
│       │   ├── bootstrap/ # Initialization
│       │   ├── config/    # Configuration
│       │   ├── di/        # Dependency injection
│       │   ├── features/  # Domain features
│       │   ├── router/    # Navigation
│       │   └── shared/    # Shared code
│       └── assets/        # Visual resources
├── packages/              # Monorepo packages
├── bricks/                # Mason templates
├── docs/                  # Additional documentation
└── melos.yaml            # Monorepo configuration
```

---

## Project Philosophy

Glow is developed with clear principles:

- **Experience over artificial metrics**
- **Structure over chaos**
- **Aesthetics with purpose**
- **Sustainable growth**

We don't compete for attention. We create places to stay.

---

## Project Status

Glow is in **active development**. Current progress:

- ✅ Technical foundation with Clean Architecture
- ✅ Monorepo configured (Melos + Mason)
- ✅ Core package structure (11 packages)
- ✅ State management (Riverpod + Freezed)
- ✅ Backend integration (Supabase)
- 🔄 Spaces system implementation
- 🔄 Channels and feeds
- 🔄 Entry content engine
- 🔄 Contextual identity
- 🔄 Design system and theming

---

## Community

Join our Discord server to discuss the project, share ideas, and connect with other contributors:

**[Join Glow Discord](https://discord.gg/Q6F7dw8AZj)**

---

## Contributing

Glow is **not open source**, but it is a collaborative project.

We accept contributions from people interested in development, design, user experience, and product building.

Significant contributions may translate into future participation under defined agreements as the project matures.

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

---

## License

Proprietary code. See [LICENSE](LICENSE) for full terms.

**Glow is a product in development with commercial purposes.**  
Redistribution and unauthorized forks are not permitted.

---

## Goal

Create a platform where any interest can become a social space with identity, where people don't just interact, but **inhabit**.

Glow aims to redefine how digital communities are built and lived.

---

**Building the future of digital communities.**
