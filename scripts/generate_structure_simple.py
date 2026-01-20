#!/usr/bin/env python3
"""
Script simplificado para generar la estructura del proyecto en Markdown.
Ejecuta directamente sin argumentos.
"""

import os
from pathlib import Path

# Directorios a ignorar
IGNORE = {
    '.git', '.dart_tool', 'build', 'ios/Pods', 'android/.gradle',
    'node_modules', '.idea', '__pycache__', '.pytest_cache',
    'dist', 'coverage', '.coverage'
}


def should_ignore(path: Path) -> bool:
    """Verifica si un path debe ser ignorado."""
    if path.name.startswith('.') and path.name not in ['.gitignore', '.github']:
        return True
    return any(pattern in str(path) for pattern in IGNORE)


def tree_to_markdown(root: Path, prefix: str = "", is_last: bool = True, depth: int = 0, max_depth: int = 10):
    """Genera el árbol en formato Markdown."""
    if depth > max_depth or should_ignore(root):
        return ""
    
    lines = []
    connector = "└── " if is_last else "├── "
    lines.append(f"{prefix}{connector}{root.name}/" if root.is_dir() else f"{prefix}{connector}{root.name}")
    
    if root.is_dir():
        try:
            items = sorted(root.iterdir(), key=lambda x: (x.is_file(), x.name.lower()))
            items = [item for item in items if not should_ignore(item)]
            
            for i, item in enumerate(items):
                is_last_item = i == len(items) - 1
                extension = "    " if is_last else "│   "
                lines.extend(tree_to_markdown(item, prefix + extension, is_last_item, depth + 1, max_depth))
        except PermissionError:
            pass
    
    return lines


def main():
    """Función principal."""
    root = Path('.').resolve()
    output_file = 'PROJECT_STRUCTURE.md'
    
    print(f"📁 Generando estructura de: {root.name}")
    
    lines = [f"# Estructura del Proyecto: {root.name}\n", "```"]
    lines.append(f"{root.name}/")
    
    try:
        items = sorted(root.iterdir(), key=lambda x: (x.is_file(), x.name.lower()))
        items = [item for item in items if not should_ignore(item)]
        
        for i, item in enumerate(items):
            is_last = i == len(items) - 1
            lines.extend(tree_to_markdown(item, "", is_last, 0))
    except Exception as e:
        lines.append(f"[Error: {str(e)}]")
    
    lines.append("```")
    
    content = "\n".join(lines)
    
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"✅ Estructura guardada en: {output_file}")
    print(f"\n{content}")


if __name__ == "__main__":
    main()
