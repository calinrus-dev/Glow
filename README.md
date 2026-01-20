# Glow — Sistema Operativo Social para Comunidades Soberanas

## Qué es Glow

Glow es un sistema operativo social diseñado para que comunidades creen, gestionen y gobiernen sus propios entornos digitales. No es una red social tradicional: Glow permite construir infraestructuras sociales autosuficientes, donde cada comunidad (Entorno) define su identidad, canales, reglas y lógica interna. El objetivo es dotar a las comunidades de herramientas para la autonomía digital, no competir por atención superficial.

Glow se fundamenta en la modularidad, la gobernanza automatizada y la soberanía de datos. Cada Entorno es una mini-aplicación configurable, con canales internos (feed, chat, wiki, galería), roles, permisos, reputación local y mecanismos de gobernanza propios. El contenido se estructura en Smart Blocks: bloques interactivos y enlazables que permiten lógica, interacción y composición avanzada.

## Principios del sistema

- **Soberanía comunitaria:** Cada Entorno es autónomo, con identidad visual, reglas y gobierno propios.
- **Infraestructura, no red social:** Glow es la base para construir comunidades, no un feed global de posts.
- **Modularidad real:** Todo el contenido y la lógica se compone mediante Smart Blocks.
- **Offline-first:** Funciona sin conexión, con cache local, sincronización silenciosa y cola de acciones.
- **Identidad contextual:** Un usuario tiene un perfil global y máscaras independientes por Entorno.
- **Disciplina arquitectónica:** Clean Architecture estricta, reglas anti-circularidad, separación de concerns.

## Conceptos clave

- **Plano Global:** Espacio de descubrimiento y navegación entre Entornos.
- **Entornos:** Comunidades soberanas, cada una con su propia configuración, canales y gobierno.
- **Canales:** Subespacios dentro de un Entorno (feed, chat, wiki, galería, etc.).
- **Smart Blocks:** Unidades modulares de contenido y lógica, enlazables y con interacción avanzada.

## Arquitectura

- **Monorepo gestionado con Melos**
- **Clean Architecture estricta:** Presentation → Domain → Data
- **Separación por packages:**  
  - `glow_core` — Tipos base, utilidades, contratos
  - `glow_domain` — Entidades, lógica de negocio, políticas
  - `glow_ui` — Componentes visuales, temas, layouts
  - `glow_blocks_engine` — Motor de Smart Blocks
  - `glow_blocks_flutter` — Widgets de Smart Blocks para Flutter
  - `glow_api` — Integración con backend y servicios externos
  - `glow_auth` — Autenticación y gestión de sesión
  - `glow_realtime` — Comunicación en tiempo real
  - `glow_data` — Persistencia local y remota
- **App final:** `apps/glow_app`
- **Backend:** Supabase (auth, datos, realtime)
- **Cache local:** Isar
- **Estado:** Riverpod
- **Reglas anti-circularidad:** Enforced con `verify_arch`

## Stack tecnológico

- Flutter (UI multiplataforma)
- Dart (lógica y dominio)
- Supabase (backend, auth, realtime)
- Isar (cache local, offline-first)
- Riverpod (gestión de estado)
- Melos (gestión de monorepo)
- GitHub Actions (CI/CD)

## Estructura del monorepo

```
glow/
├── apps/
│   └── glow_app/           # App principal Flutter
├── packages/
│   ├── glow_core/
│   ├── glow_domain/
│   ├── glow_ui/
│   ├── glow_blocks_engine/
│   ├── glow_blocks_flutter/
│   ├── glow_api/
│   ├── glow_auth/
│   ├── glow_realtime/
│   └── glow_data/
├── scripts/                # Utilidades y automatización
├── docs/                   # Documentación técnica y de producto
├── .github/workflows/      # CI/CD
├── melos.yaml              # Configuración de monorepo
└── pubspec.yaml            # Configuración raíz
```

## Cómo arrancar el proyecto

1. **Clona el repositorio**
   ```sh
   git clone https://github.com/calinrus-dev/glow.git
   cd glow
   ```

2. **Instala Flutter y Melos**
   - Flutter: https://docs.flutter.dev/get-started/install
   - Melos:  
     ```sh
     flutter pub global activate melos
     ```

3. **Bootstrap del monorepo**
   ```sh
   melos bootstrap
   ```

4. **Arranca la app**
   ```sh
   cd apps/glow_app
   flutter run
   ```

## Scripts disponibles

- `melos bootstrap` — Instala dependencias y enlaza packages locales
- `melos exec -- flutter analyze` — Análisis estático de todo el monorepo
- `melos exec -- flutter test` — Ejecuta todos los tests
- `melos exec -- flutter pub run build_runner build --delete-conflicting-outputs` — Genera código (freezed, json_serializable)
- `scripts/verify_arch.sh` — Verifica reglas anti-circularidad

## Disciplina del proyecto

- **Formato:**  
  `melos exec -- dart format .`
- **Análisis:**  
  `melos exec -- flutter analyze`
- **Tests:**  
  `melos exec -- flutter test`
- **Verificación de arquitectura:**  
  `scripts/verify_arch.sh`
- **Commits:**  
  Mensajes claros, convencionales y atómicos

## Automatización local (pre-commit hooks)

Para asegurar la calidad antes de cada commit, instala los hooks locales:

```sh
pip install pre-commit
pre-commit install
```

Esto ejecutará automáticamente formato, análisis y tests en cada commit.

## Roadmap resumido

- **Fase 1:** MVP funcional (auth, plano global, entornos, canales, feed, chat, Smart Blocks básicos, offline-first)
- **Fase 2:** Gobernanza, reputación, permisos avanzados, moderación, identidad dual
- **Fase 3:** Extensibilidad de Smart Blocks, API pública, automatización de gobernanza, integración avanzada con Supabase

## Estado actual del proyecto

- Arquitectura y estructura de monorepo establecidas
- Paquetes core y app principal en desarrollo activo
- CI/CD, análisis y tests automatizados
- Documentación y guías iniciales disponibles
- El proyecto evoluciona en fases, con enfoque en calidad y escalabilidad

## Filosofía de contribución

Glow es un proyecto con disciplina de ingeniería y visión a largo plazo. Aunque la contribución externa puede estar limitada en fases iniciales, se fomenta la revisión profesional, el feedback técnico y la colaboración responsable. Lee `CONTRIBUTING.md` y respeta el `CODE_OF_CONDUCT.md` antes de proponer cambios.

---

### Sugerencia de documentos adicionales en `/docs`:

- `ARCHITECTURE.md` — Detalle de la arquitectura y reglas internas
- `OFFLINE_FIRST.md` — Estrategias y patrones offline
- `SUPABASE_SCHEMA.md` — Esquema y reglas del backend
- `ROADMAP.md` — Detalle de fases y objetivos
- `DEPENDENCY_RULES.md` — Reglas de dependencias y anti-circularidad
- `CONTRIBUTING.md` — Guía extendida de contribución
- `CONTRIBUTING_TECH.md` — Estándares de código y revisiones

## 🚀 Releases automáticos

Cada vez que se crea un tag con formato `vX.Y.Z` en GitHub, se genera automáticamente un release con changelog generado desde los commits. Utiliza:

```sh
git tag v1.0.0
git push origin v1.0.0
```

El release aparecerá en la pestaña [Releases](https://github.com/<TU_USUARIO>/<TU_REPO>/releases) del repositorio.

![Release](https://img.shields.io/github/v/release/<TU_USUARIO>/<TU_REPO>?label=release)
