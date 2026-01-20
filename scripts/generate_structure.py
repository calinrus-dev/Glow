#!/usr/bin/env python3
"""
Script para generar la estructura completa del proyecto en formato Markdown.
"""

import os
import sys
from pathlib import Path
from typing import List, Set

# Directorios y archivos a ignorar
IGNORE_PATTERNS: Set[str] = {
    '.git',
    '.dart_tool',
    '.flutter-plugins',
    '.flutter-plugins-dependencies',
    'build',
    'ios/Pods',
    'android/.gradle',
    'android/app/build',
    'node_modules',
    '.idea',
    '.vscode',
    '__pycache__',
    '.pytest_cache',
    '*.pyc',
    '.DS_Store',
    'Thumbs.db',
    '*.lock',
    '*.iml',
    '*.swp',
    '*.swo',
    '*.log',
    'coverage',
    '.coverage',
    'dist',
    '*.egg-info',
}


def should_ignore(path: Path, root_path: Path) -> bool:
    """Verifica si un path debe ser ignorado."""
    # Ignorar archivos ocultos que empiezan con punto (excepto algunos importantes)
    if path.name.startswith('.') and path.name not in ['.gitignore', '.env.example']:
        # Pero permitir algunos directorios importantes como .github
        if path.name == '.github':
            return False
        if path.name.startswith('.'):
            return True
    
    # Verificar patrones de ignorar
    relative_path = path.relative_to(root_path)
    path_str = str(relative_path).replace('\\', '/')
    
    for pattern in IGNORE_PATTERNS:
        if pattern in path_str or path.name == pattern or path.name.endswith(pattern.lstrip('*')):
            return True
    
    return False


def get_file_size(path: Path) -> str:
    """Obtiene el tamaño del archivo en formato legible."""
    try:
        size = path.stat().st_size
        if size < 1024:
            return f"{size}B"
        elif size < 1024 * 1024:
            return f"{size / 1024:.1f}KB"
        else:
            return f"{size / (1024 * 1024):.1f}MB"
    except:
        return "?"


def generate_structure(root_path: Path, output_file: str = None, max_depth: int = None) -> str:
    """
    Genera la estructura del proyecto en formato Markdown.
    
    Args:
        root_path: Ruta raíz del proyecto
        output_file: Archivo de salida (opcional)
        max_depth: Profundidad máxima a mostrar (opcional)
    
    Returns:
        String con la estructura en Markdown
    """
    root_path = Path(root_path).resolve()
    
    lines: List[str] = []
    lines.append(f"# Estructura del Proyecto: {root_path.name}\n")
    lines.append(f"```\n")
    
    def add_directory(dir_path: Path, prefix: str = "", is_last: bool = True, depth: int = 0):
        """Añade un directorio y su contenido al árbol."""
        if max_depth is not None and depth >= max_depth:
            return
        
        if should_ignore(dir_path, root_path):
            return
        
        # Ícono y nombre del directorio
        connector = "└── " if is_last else "├── "
        lines.append(f"{prefix}{connector}{dir_path.name}/")
        
        # Nuevo prefijo para los hijos
        extension = "    " if is_last else "│   "
        new_prefix = prefix + extension
        
        try:
            # Obtener todos los elementos (directorios y archivos)
            items = sorted(dir_path.iterdir(), key=lambda x: (x.is_file(), x.name.lower()))
            
            # Separar directorios y archivos
            dirs = [item for item in items if item.is_dir() and not should_ignore(item, root_path)]
            files = [item for item in items if item.is_file() and not should_ignore(item, root_path)]
            
            # Procesar directorios primero
            for i, item in enumerate(dirs):
                is_last_dir = (i == len(dirs) - 1) and len(files) == 0
                add_directory(item, new_prefix, is_last_dir, depth + 1)
            
            # Procesar archivos después
            for i, item in enumerate(files):
                is_last_file = i == len(files) - 1
                connector = "└── " if is_last_file else "├── "
                size = get_file_size(item)
                lines.append(f"{new_prefix}{connector}{item.name} ({size})")
        
        except PermissionError:
            lines.append(f"{new_prefix}    [Permiso denegado]")
        except Exception as e:
            lines.append(f"{new_prefix}    [Error: {str(e)}]")
    
    # Empezar desde el directorio raíz
    lines.append(f"{root_path.name}/")
    
    try:
        items = sorted(root_path.iterdir(), key=lambda x: (x.is_file(), x.name.lower()))
        
        dirs = [item for item in items if item.is_dir() and not should_ignore(item, root_path)]
        files = [item for item in items if item.is_file() and not should_ignore(item, root_path)]
        
        # Procesar directorios
        for i, item in enumerate(dirs):
            is_last_dir = (i == len(dirs) - 1) and len(files) == 0
            add_directory(item, "", is_last_dir, 0)
        
        # Procesar archivos en la raíz
        for i, item in enumerate(files):
            is_last_file = i == len(files) - 1
            connector = "└── " if is_last_file else "├── "
            size = get_file_size(item)
            lines.append(f"{connector}{item.name} ({size})")
    
    except Exception as e:
        lines.append(f"[Error al leer el directorio: {str(e)}]")
    
    lines.append(f"```\n")
    
    # Añadir estadísticas
    lines.append("\n## Estadísticas\n\n")
    
    total_files = 0
    total_dirs = 0
    total_size = 0
    
    def count_items(path: Path):
        nonlocal total_files, total_dirs, total_size
        if should_ignore(path, root_path):
            return
        
        if path.is_file():
            total_files += 1
            try:
                total_size += path.stat().st_size
            except:
                pass
        elif path.is_dir():
            total_dirs += 1
            try:
                for item in path.iterdir():
                    count_items(item)
            except:
                pass
    
    for item in root_path.iterdir():
        count_items(item)
    
    lines.append(f"- **Total de archivos:** {total_files}\n")
    lines.append(f"- **Total de directorios:** {total_dirs}\n")
    
    size_mb = total_size / (1024 * 1024)
    if size_mb < 1:
        lines.append(f"- **Tamaño total:** {total_size / 1024:.2f} KB\n")
    else:
        lines.append(f"- **Tamaño total:** {size_mb:.2f} MB\n")
    
    result = "\n".join(lines)
    
    # Guardar en archivo si se especifica
    if output_file:
        output_path = Path(output_file)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(result)
        print(f"✅ Estructura guardada en: {output_path}")
    
    return result


def main():
    """Función principal."""
    import argparse
    
    parser = argparse.ArgumentParser(
        description='Genera la estructura completa del proyecto en formato Markdown'
    )
    parser.add_argument(
        '--root',
        type=str,
        default='.',
        help='Directorio raíz del proyecto (por defecto: directorio actual)'
    )
    parser.add_argument(
        '--output',
        type=str,
        default='PROJECT_STRUCTURE.md',
        help='Archivo de salida (por defecto: PROJECT_STRUCTURE.md)'
    )
    parser.add_argument(
        '--max-depth',
        type=int,
        default=None,
        help='Profundidad máxima a mostrar (por defecto: sin límite)'
    )
    parser.add_argument(
        '--print',
        action='store_true',
        help='Imprimir la estructura en la consola además de guardarla'
    )
    
    args = parser.parse_args()
    
    root_path = Path(args.root).resolve()
    
    if not root_path.exists():
        print(f"❌ Error: El directorio '{root_path}' no existe.")
        sys.exit(1)
    
    if not root_path.is_dir():
        print(f"❌ Error: '{root_path}' no es un directorio.")
        sys.exit(1)
    
    print(f"📁 Generando estructura de: {root_path}")
    print(f"💾 Guardando en: {args.output}")
    
    if args.max_depth:
        print(f"📏 Profundidad máxima: {args.max_depth}")
    
    structure = generate_structure(root_path, args.output, args.max_depth)
    
    if args.print:
        print("\n" + "="*80)
        print(structure)
        print("="*80)
    
    print("✅ ¡Completado!")


if __name__ == "__main__":
    main()
