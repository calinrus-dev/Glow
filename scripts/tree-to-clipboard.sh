#!/bin/bash

# Script to copy project structure to clipboard as markdown
# Usage: ./scripts/tree-to-clipboard.sh

set -e

OUTPUT_FILE=$(mktemp)

echo "Generating project structure..."

# Function to print directory tree
print_tree() {
    local dir="$1"
    local prefix="$2"
    local ignore_patterns=(
        ".git"
        ".dart_tool"
        "build"
        ".gradle"
        "node_modules"
        ".idea"
        ".vscode"
        "*.iml"
        ".flutter-plugins"
        ".flutter-plugins-dependencies"
        ".packages"
        "pubspec.lock"
        "*.g.dart"
        "*.freezed.dart"
        ".metadata"
        "ephemeral"
        "Generated.xcconfig"
        "flutter_export_environment.sh"
        "Runner.xcworkspace"
        "Pods"
        ".symlinks"
        "GeneratedPluginRegistrant"
    )

    # Get all items in directory
    local items=()
    while IFS= read -r item; do
        local basename=$(basename "$item")
        
        # Check if should ignore
        local should_ignore=false
        for pattern in "${ignore_patterns[@]}"; do
            if [[ "$basename" == $pattern ]] || [[ "$basename" == *"$pattern" ]]; then
                should_ignore=true
                break
            fi
        done
        
        if [ "$should_ignore" = false ]; then
            items+=("$item")
        fi
    done < <(find "$dir" -maxdepth 1 -mindepth 1 2>/dev/null | sort)

    # Print items
    for i in "${!items[@]}"; do
        local item="${items[$i]}"
        local basename=$(basename "$item")
        
        if [ -d "$item" ]; then
            echo "${prefix}${basename}/" >> "$OUTPUT_FILE"
            print_tree "$item" "${prefix}	"
        else
            echo "${prefix}${basename}" >> "$OUTPUT_FILE"
        fi
    done
}

# Start with header
echo '```' > "$OUTPUT_FILE"

# Print root directory name
echo "glow/" >> "$OUTPUT_FILE"

# Print tree starting from current directory
print_tree "." "	"

echo '```' >> "$OUTPUT_FILE"

# Copy to clipboard
if command -v clip.exe &> /dev/null; then
    # Windows (WSL or Git Bash)
    cat "$OUTPUT_FILE" | clip.exe
    echo "✓ Project structure copied to clipboard!"
elif command -v xclip &> /dev/null; then
    # Linux with xclip
    cat "$OUTPUT_FILE" | xclip -selection clipboard
    echo "✓ Project structure copied to clipboard!"
elif command -v pbcopy &> /dev/null; then
    # macOS
    cat "$OUTPUT_FILE" | pbcopy
    echo "✓ Project structure copied to clipboard!"
else
    echo "✗ No clipboard utility found (clip.exe, xclip, or pbcopy)"
    echo "Output saved to: $OUTPUT_FILE"
    cat "$OUTPUT_FILE"
fi

# Clean up
rm -f "$OUTPUT_FILE"
