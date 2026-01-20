# Glow Monorepo

Glow es una super app social construida en Flutter, organizada como monorepo con Melos.

## Estructura
- `apps/` — Aplicaciones principales
- `packages/` — Paquetes compartidos (core, UI, dominio, datos, etc.)
- `scripts/` — Utilidades y automatización
- `docs/` — Documentación

## Desarrollo rápido
```sh
melos bootstrap
melos exec -- flutter analyze
melos exec -- flutter test
```

## CI/CD
- El repositorio ejecuta análisis y tests automáticamente en cada push y PR a main.

## Contribuir
Lee [CONTRIBUTING.md](CONTRIBUTING.md) antes de enviar cambios.

## Código de conducta
Lee [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).
