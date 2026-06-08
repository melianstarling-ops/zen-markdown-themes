# Zen Markdown Themes

> Calm, flow-state Markdown reading. Carefully crafted dark themes whose typographic
> parameters trace back to world-class design systems — for VS Code native preview, Typora, and the web.

## What this is

A small library of polished Markdown CSS themes built around one idea: reading should be
quiet and effortless — generous whitespace, low visual noise, and type that gets out of the way.
Every key typographic value (size, line height, tracking) is sourced, where possible, from an
authoritative design system and noted in the CSS comments.

Two theme families so far, with more to come as the project studies more great design:

| Theme | Family | Look |
|-------|--------|------|
| `apple-dark-mono.css` | Apple | Pure neutral grayscale, Apple HIG type scale, SF/Inter + Noto Sans SC |
| `claude-dark.css` | Claude | claude.ai-calibrated dark, warm `#d97757` accent, Inter + Noto Sans SC |

All fonts used are free and redistributable (Inter, Noto Sans SC, JetBrains Mono).

## Quick start (VS Code native preview)

This repo ships a workspace `.vscode/settings.json` already pointing at a theme, so opening the
repo in VS Code and pressing `Ctrl+Shift+V` on any `.md` shows it immediately.

To use a theme in your own project, add this to that workspace's `.vscode/settings.json`:

```json
"markdown.styles": [
  "Themes/claude-dark.css"
]
```

Note: VS Code's `markdown.styles` only accepts a **workspace-relative path** (or an `https` URL) —
absolute / `file://` paths are rejected by the preview webview, so there is no global "all workspaces"
option through this setting. See [Docs/Install-VSCode.md](Docs/Install-VSCode.md) for per-project setup
and [Docs/Install-Typora.md](Docs/Install-Typora.md) for Typora.

To push one theme into several other workspaces at once, use [Scripts/apply-md-theme.ps1](Scripts/apply-md-theme.ps1).

## Preview & pick

Open [Playground/live-preview.html](Playground/live-preview.html) in a browser to see a theme applied
to a full sample document and live-reload the CSS as you tweak it. See
[Docs/Choosing-A-Theme.md](Docs/Choosing-A-Theme.md) for how the families differ.

## Layout

| Path | Contents |
|------|----------|
| `Themes/` | The CSS themes (lowercase-hyphenated filenames) |
| `Playground/` | Browser live-preview tool |
| `Docs/` | Install & selection guides |
| `Scripts/` | Helper scripts (e.g. distribute a theme across workspaces) |

## License

MIT — see [LICENSE](LICENSE).

---

> Status: early and evolving. Themes and docs are refined in everyday use.
