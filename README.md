# Glow

**Plataforma social para crear y habitar espacios digitales con identidad.**

Glow transforma intereses en lugares. No simples feeds o chats, sino **Entornos** con atmósfera, estructura y personalidad propias donde las comunidades viven, no solo interactúan.

---

## ¿Qué es Glow?

Glow es una plataforma diseñada para que cualquier interés —desde MotoGP hasta cine independiente, desde fotografía hasta desarrollo de software— pueda convertirse en un **espacio social real**, con identidad visual, cultura propia y experiencia inmersiva.

No es una red social tradicional. Es una plataforma para **habitar comunidades**, no solo para consumir contenido.

---

## Conceptos fundamentales

### Entornos (Spaces)
Un **Entorno** es una comunidad dentro de Glow. Cada uno representa un interés, tema o actividad, con:
- Identidad visual única
- Estética configurable
- Estructura interna definida
- Normas y cultura propias

Ejemplos: MotoGP, Cine independiente, Desarrollo de software.

### Canales
Los **Canales** organizan la actividad dentro de un Entorno:
- Feed visual
- Chat
- Galería
- Wiki
- Espacios experimentales

Cada canal tiene propósito claro, reglas y permisos específicos.

### Lienzos
En Glow no existen los "posts" tradicionales. El contenido se crea a través de **Lienzos**: espacios en blanco donde los usuarios construyen libremente, combinando texto, imágenes y elementos visuales sin formato rígido.

Los Lienzos permiten que el contenido:
- Se adapte al tono de cada comunidad
- Evolucione con el tiempo
- Refleje la creatividad sin limitaciones artificiales

### Identidad contextual
Los usuarios tienen una **identidad global** y **identidades adaptables** según el Entorno, permitiendo participar en distintos intereses sin mezclar contextos.

---

## Experiencia y estética

Glow apuesta por una experiencia:
- **Inmersiva y atmosférica**
- **Estética oscura con efectos glow/neón**
- **Animaciones suaves y transiciones cuidadas**
- **Sensación de profundidad y lugar**

La estética no es decoración: define el carácter del producto y refuerza la identidad de cada Entorno.

Entrar en un Entorno debe sentirse como **entrar en otro espacio**, no como abrir una app más.

---

## Stack tecnológico

```yaml
Framework: Flutter 3.19+
State: Riverpod + Freezed
Backend: Supabase (PostgreSQL, Auth, Realtime)
HTTP: Dio
Navigation: GoRouter
Monorepo: Melos
Code generation: Mason, build_runner
```

**Arquitectura:** Clean Architecture con separación estricta de capas.

**Paquetes:**
- `glow_core` - Contratos base, logger, utilidades
- `glow_domain` - Entidades, casos de uso, políticas
- `glow_data` - Repositorios, data sources
- `glow_api` - Cliente HTTP
- `glow_auth` - Gestión de sesiones y autenticación
- `glow_realtime` - Conexiones realtime
- `glow_blocks_engine` - Motor de bloques visuales
- `glow_blocks_flutter` - Widgets de bloques
- `glow_observability` - Logging y monitoreo
- `glow_ui` - Sistema de diseño

---

## Desarrollo

### Requisitos
- Flutter 3.19+
- Dart 3.3+
- Melos CLI: `dart pub global activate melos`
- Mason CLI: `dart pub global activate mason_cli`

### Setup inicial

```bash
# Clonar repositorio
git clone https://github.com/calinrus-dev/Glow.git
cd glow

# Bootstrap de paquetes
melos bootstrap

# Configurar variables de entorno
cp .env.example .env
# Editar .env con credenciales de Supabase
```

### Comandos principales

```bash
# Analizar código
melos run analyze

# Ejecutar tests
melos run test

# Formatear código
melos run format

# Code generation (Riverpod, Freezed)
cd apps/glow_app
dart run build_runner build --delete-conflicting-outputs

# Ejecutar app
cd apps/glow_app
flutter run
```

### Estructura del proyecto

```
glow/
├── apps/
│   └── glow_app/          # Aplicación principal
│       ├── lib/
│       │   ├── bootstrap/ # Inicialización
│       │   ├── config/    # Configuración
│       │   ├── di/        # Dependency injection
│       │   ├── features/  # Features por dominio
│       │   ├── router/    # Navegación
│       │   └── shared/    # Código compartido
│       └── assets/        # Recursos visuales
├── packages/              # Paquetes del monorepo
├── bricks/                # Templates Mason
├── docs/                  # Documentación adicional
└── melos.yaml            # Configuración monorepo
```

---

## Filosofía del proyecto

Glow se desarrolla con principios claros:

- **Experiencia antes que métricas artificiales**
- **Estructura antes que caos**
- **Estética con propósito**
- **Crecimiento sostenible**

No buscamos competir por atención. Creamos lugares donde quedarse.

---

## Estado del proyecto

Glow está en **desarrollo activo**. El enfoque actual:

- ✅ Base técnica sólida con Clean Architecture
- ✅ Monorepo configurado con Melos + Mason
- ✅ Sistema de diseño base
- 🔄 Implementación de Entornos y Canales
- 🔄 Motor de Lienzos
- 🔄 Sistema de identidad contextual

---

## Contribuciones

Glow **no es open source**, pero sí es un proyecto colaborativo.

Aceptamos contribuciones de personas interesadas en desarrollo, diseño, experiencia de usuario y construcción de producto.

Las contribuciones significativas pueden traducirse en participación futura bajo acuerdos definidos cuando el proyecto madure.

Ver [CONTRIBUTING.md](CONTRIBUTING.md) para más detalles.

---

## Licencia

Código propietario. Ver [LICENSE](LICENSE) para términos completos.

**Glow es un producto en desarrollo con fines comerciales.**  
No se permite redistribución ni forks no autorizados.

---

## Objetivo

Crear una plataforma donde cualquier interés pueda convertirse en un espacio social con identidad, donde las personas no solo interactúan, sino **habitan**.

Glow quiere redefinir cómo se construyen y viven las comunidades digitales.

---

**Construyendo el futuro de las comunidades digitales.**
