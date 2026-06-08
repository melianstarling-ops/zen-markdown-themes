<#
.SYNOPSIS
  Distribute one CSS theme to multiple workspaces' VS Code native Markdown preview.

.DESCRIPTION
  VS Code's markdown.styles only accepts a workspace-relative path (no absolute / file://;
  see memory: vscode-markdown-styles-no-absolute-path). For each target workspace this script:
    1) copies the theme CSS into <workspace>\.vscode\md-theme.css
    2) writes/updates <workspace>\.vscode\settings.json "markdown.styles" to point at it
  Reload Window in each workspace to apply. VS Code only (Typora is a global theme, no per-workspace concept).

  NOTE: kept ASCII-only on purpose. PowerShell 5.1 reads .ps1 as ANSI; a UTF-8 (no BOM) file with
  CJK chars breaks parsing. Keep this script ASCII, or save as UTF-8 with BOM.

.PARAMETER Theme
  Full path to the theme CSS, e.g. D:\Projects\Project_apple-md\Themes\claude-dark.css

.PARAMETER Workspace
  One or more target workspace root directories.

.EXAMPLE
  .\apply-md-theme.ps1 -Theme "D:\Projects\Project_apple-md\Themes\claude-dark.css" -Workspace "D:\Projects\Project_A","D:\Projects\Project_B"

.NOTES
  If settings.json contains // comments (jsonc), JSON parse fails -> the script backs up to
  settings.json.bak, skips that workspace and warns. It never corrupts the original.
#>
param(
  [Parameter(Mandatory = $true)][string]$Theme,
  [Parameter(Mandatory = $true)][string[]]$Workspace
)

if (-not (Test-Path -LiteralPath $Theme)) {
  Write-Error "Theme file not found: $Theme"; exit 1
}
$themeFull = (Resolve-Path -LiteralPath $Theme).Path

foreach ($ws in $Workspace) {
  if (-not (Test-Path -LiteralPath $ws)) {
    Write-Warning "Skip (workspace not found): $ws"; continue
  }
  $vscodeDir = Join-Path $ws ".vscode"
  if (-not (Test-Path -LiteralPath $vscodeDir)) {
    New-Item -ItemType Directory -Path $vscodeDir | Out-Null
  }

  # 1) copy theme into <workspace>\.vscode\md-theme.css
  Copy-Item -LiteralPath $themeFull -Destination (Join-Path $vscodeDir "md-theme.css") -Force

  # 2) update settings.json markdown.styles
  $settingsPath = Join-Path $vscodeDir "settings.json"
  $json = $null
  if (Test-Path -LiteralPath $settingsPath) {
    Copy-Item -LiteralPath $settingsPath -Destination "$settingsPath.bak" -Force   # backup first
    try {
      $raw = Get-Content -LiteralPath $settingsPath -Raw -Encoding UTF8
      $json = $raw | ConvertFrom-Json -ErrorAction Stop
    } catch {
      Write-Warning "Skip (settings.json parse failed, maybe jsonc comments): $ws -- set markdown.styles manually to [.vscode/md-theme.css]; backup at settings.json.bak"
      continue
    }
  } else {
    $json = [PSCustomObject]@{}
  }

  $json | Add-Member -NotePropertyName "markdown.styles" -NotePropertyValue @(".vscode/md-theme.css") -Force
  $json | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath $settingsPath -Encoding UTF8

  Write-Host "OK   $ws  ->  .vscode\md-theme.css + settings.json[markdown.styles]"
}

Write-Host ""
Write-Host "Done. Reload Window in each affected workspace (Ctrl+Shift+P -> Reload Window)."
