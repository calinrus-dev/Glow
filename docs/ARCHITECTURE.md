# Arquitectura de Glow

Glow aplica Clean Architecture estricta y reglas de ingeniería avanzadas para garantizar escalabilidad, mantenibilidad y control sobre la complejidad. Este documento detalla la estructura, prácticas y funcionamiento interno del sistema.

## 1. Principios Fundamentales

- **Separación absoluta de capas:** Presentation, Domain y Data nunca se mezclan.
- **Reglas anti-circularidad:** Ningún package puede depender directa o indirectamente de sí mismo. Enforced por scripts y revisiones.
- **Inversión de dependencias:** La lógica de negocio nunca depende de frameworks ni de detalles de infraestructura.
- **Inmutabilidad y pureza:** Entidades y policies son inmutables y puras.
- **Testabilidad:** Todo el dominio y la lógica de negocio son 100% testeables sin dependencias externas.
- **Extensibilidad:** Smart Blocks y canales son modulares y desacoplados.

## 2. Estructura de Capas

- **Presentation:**
  - Flutter UI, widgets, navegación, providers.
  - Sin lógica de negocio, solo orquestación y presentación.
- **Domain:**
  - Entidades, policies, casos de uso, contratos.
  - Sin dependencias de frameworks ni de Data.
- **Data:**
  - Repositorios, fuentes de datos (Supabase, Isar, APIs), DTOs.
  - Implementa interfaces del dominio, nunca al revés.

## 3. Organización de Packages

- `glow_core`: Tipos base, utilidades, contratos globales.
- `glow_domain`: Entidades, lógica de negocio, políticas, casos de uso.
- `glow_ui`: Componentes visuales, layouts, temas.
- `glow_blocks_engine`: Motor de Smart Blocks, lógica de composición y ejecución.
- `glow_blocks_flutter`: Widgets de Smart Blocks para Flutter.
- `glow_api`: Integración con Supabase y servicios externos.
- `glow_auth`: Autenticación, sesión, perfiles.
- `glow_realtime`: Comunicación en tiempo real, eventos, streams.
- `glow_data`: Persistencia local (Isar), sincronización, colas offline.

## 4. Reglas de Dependencias

- Presentation → puede depender de Domain y UI.
- Domain → solo depende de glow_core.
- Data → depende de Domain y glow_core.
- Ningún package puede depender de otro en sentido inverso.
- Los Smart Blocks nunca acceden a infraestructura directamente.
- Las dependencias se revisan con `verify_arch` y scripts de Melos.

## 5. Funcionamiento Interno

- **Smart Blocks:**
  - Cada bloque es una unidad autocontenida de lógica y UI.
  - Se componen dinámicamente en canales y feeds.
  - Permiten lógica, interacción y vínculo entre contenidos.
- **Entornos:**
  - Cada entorno es una mini-app con canales, reglas y gobierno propios.
  - La configuración y permisos se resuelven localmente.
- **Offline-first:**
  - Todas las acciones se encolan y sincronizan cuando hay conexión.
  - Isar gestiona el cache local y la cola de acciones.
- **Gobernanza y permisos:**
  - Policies y reglas se definen en Domain y se aplican en tiempo real.
  - No hay lógica de permisos en Presentation ni Data.
- **Realtime:**
  - glow_realtime abstrae la comunicación y eventos en tiempo real.
  - No hay lógica de negocio en los listeners, solo triggers a casos de uso.

## 6. Prácticas Obligatorias

- **No lógica de negocio en UI ni Data.**
- **No acceso directo a infraestructura desde Domain.**
- **No dependencias circulares.**
- **Tests unitarios obligatorios en Domain y Data.**
- **Cobertura mínima del 80% en lógica de negocio.**
- **Scripts de verificación antes de cada merge.**
- **Revisión de arquitectura en cada PR.**

## 7. Ejemplo de flujo (post con Smart Block)

1. Usuario crea un post en la UI (Presentation).
2. Presentation construye el Smart Block y lo pasa a un caso de uso (Domain).
3. El caso de uso valida, aplica policies y delega en un repositorio (Domain).
4. El repositorio persiste el bloque en Isar (offline) y/o Supabase (online) (Data).
5. La UI se actualiza vía providers y streams.

## 8. Herramientas de verificación

- `scripts/verify_arch.sh`: Verifica dependencias y reglas anti-circularidad.
- `melos exec -- flutter analyze`: Análisis estático de todo el monorepo.
- `melos exec -- flutter test`: Tests unitarios y de integración.

---

Glow no es negociable en disciplina arquitectónica. Cualquier excepción debe ser justificada y revisada por el Lead Engineer.
