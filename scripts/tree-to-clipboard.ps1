# PowerShell script to copy project structure to clipboard as markdown
# Usage: .\scripts\tree-to-clipboard.ps1

$ErrorActionPreference = "Stop"

Write-Host "Generating project structure..." -ForegroundColor Cyan

$output = @()
$output += '```'

# Patterns to ignore
$ignorePatterns = @(
    '.git',
    '.dart_tool',
    'build',
    '.gradle',
    'node_modules',
    '.idea',
    '.vscode',
    '*.iml',
    '.flutter-plugins',
    '.flutter-plugins-dependencies',
    '.packages',
    'pubspec.lock',
    '*.g.dart',
    '*.freezed.dart',
    '.metadata',
    'ephemeral',
    'Generated.xcconfig',
    'flutter_export_environment.sh',
    'Runner.xcworkspace',
    'Pods',
    '.symlinks',
    'GeneratedPluginRegistrant'
)

function Test-ShouldIgnore {
    param([string]$Name)
    
    foreach ($pattern in $ignorePatterns) {
        if ($pattern.Contains('*')) {
            $regex = $pattern.Replace('.', '\.').Replace('*', '.*')
            if ($Name -match $regex) { return $true }
        } else {
            if ($Name -eq $pattern -or $Name.EndsWith($pattern)) { return $true }
        }
    }
    return $false
}

function Get-DirectoryTree {
    param(
        [string]$Path,
        [string]$Prefix = "`t"
    )
    
    try {
        $items = Get-ChildItem -Path $Path -ErrorAction SilentlyContinue | Sort-Object { $_.PSIsContainer }, Name
        
        foreach ($item in $items) {
            if (Test-ShouldIgnore $item.Name) {
                continue
            }
            
            if ($item.PSIsContainer) {
                $script:output += "$Prefix$($item.Name)/"
                Get-DirectoryTree -Path $item.FullName -Prefix "$Prefix`t"
            } else {
                $script:output += "$Prefix$($item.Name)"
            }
        }
    } catch {
        # Silently skip directories we can't access
    }
}

# Add root
$output += "glow/"

# Generate tree
Get-DirectoryTree -Path "."

$output += '```'

# Join with newlines and copy to clipboard
$fullOutput = $output -join "`n"
$fullOutput | Set-Clipboard

Write-Host "Project structure copied to clipboard!" -ForegroundColor Green
Write-Host ""
Write-Host "Preview (first 20 lines):" -ForegroundColor Yellow
$output | Select-Object -First 20 | ForEach-Object { Write-Host $_ }
if ($output.Count -gt 20) {
    $remainingLines = $output.Count - 20
    Write-Host "... and" $remainingLines "more lines" -ForegroundColor DarkGray
}
