# Script de setup para entorno de desarrollo Glow (Windows PowerShell)
$ErrorActionPreference = 'Stop'

# 1. Instalar Melos si no está presente
if (-not (Get-Command melos -ErrorAction SilentlyContinue)) {
    Write-Host "Instalando Melos..."
    dart pub global activate melos
}

# 2. Instalar dependencias de todos los paquetes
melos bootstrap

# 3. Instalar pre-commit si existe configuración
if (Test-Path .pre-commit-config.yaml) {
    if (-not (Get-Command pre-commit -ErrorAction SilentlyContinue)) {
        Write-Host "Instalando pre-commit..."
        pip install pre-commit
    }
    pre-commit install
}

Write-Host "`n✅ Setup completo. Puedes empezar a trabajar en Glow."
Write-Host "- Usa 'melos run' para scripts comunes."
Write-Host "- Usa 'pre-commit run --all-files' para verificar hooks."
