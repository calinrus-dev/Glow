#!/bin/bash
# Script de setup para entorno de desarrollo Glow
set -e

# 1. Instalar dependencias globales
if ! command -v melos &> /dev/null; then
  echo "Instalando Melos..."
  dart pub global activate melos
fi

# 2. Instalar dependencias de todos los paquetes
melos bootstrap

# 3. Instalar pre-commit si existe configuración
if [ -f .pre-commit-config.yaml ]; then
  if ! command -v pre-commit &> /dev/null; then
    echo "Instalando pre-commit..."
    pip install pre-commit
  fi
  pre-commit install
fi

# 4. Mensaje final
cat <<EOF

✅ Setup completo. Puedes empezar a trabajar en Glow.
- Usa 'melos run' para scripts comunes.
- Usa 'pre-commit run --all-files' para verificar hooks.
EOF
