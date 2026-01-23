# Glow

**Social platform for creating and inhabiting digital spaces with identity.**

Glow transforms interests into places. Not simple feeds or chats, but **Entornos** (Spaces) with atmosphere, structure, and personality where communities live, not just interact.

---

## What is Glow?

Glow is a platform designed so any interest—from MotoGP to independent cinema, from photography to software development—can become a **real social space** with visual identity, its own culture, and immersive experience.

It's not a traditional social network. It's a platform to **inhabit communities**, not just consume content.

---

## Core Concepts

### Entornos (Spaces)
An **Entorno** is a community within Glow. Each represents an interest, topic, or activity, with:
- Unique visual identity
- Configurable aesthetics
- Defined internal structure
- Own norms and culture

Examples: MotoGP, Independent cinema, Software development.

### Canales (Channels)
**Canales** organize activity within an Entorno:
- Visual feed
- Chat
- Gallery
- Wiki
- Experimental spaces

Each channel has clear purpose, specific rules and permissions.

### Lienzos (Canvases)
In Glow, traditional "posts" don't exist. Content is created through **Lienzos**: blank spaces where users build freely, combining text, images, and visual elements without rigid format.

Lienzos allow content to:
- Adapt to each community's tone
- Evolve over time
- Reflect creativity without artificial limitations

### Contextual Identity
Users have a **global identity** and **adaptable identities** per Entorno, allowing participation in different interests without mixing contexts.

---

## Experience & Aesthetics

Glow commits to an experience that's:
- **Immersive and atmospheric**
- **Dark aesthetic with glow/neon effects**
- **Smooth animations and polished transitions**
- **Sense of depth and place**

Aesthetics aren't decoration: they define the product's character and reinforce each Entorno's identity.

Entering an Entorno should feel like **entering another space**, not just opening another app.

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
- `glow_blocks_engine` - Visual blocks engine
- `glow_blocks_flutter` - Block widgets
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

Glow is in **active development**. Current focus:

- ✅ Solid technical foundation with Clean Architecture
- ✅ Monorepo configured with Melos + Mason
- ✅ Base design system
- 🔄 Entornos and Canales implementation
- 🔄 Lienzos engine
- 🔄 Contextual identity system

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
