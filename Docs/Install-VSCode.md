# Using a Zen Markdown theme in VS Code

The CSS is injected into VS Code's **native Markdown preview** via the `markdown.styles` setting.
(Note: `markdown.styles` only affects the native preview — it has no effect on third-party preview
extensions such as Markdown Preview Enhanced.)

## Important: paths must be workspace-relative

VS Code's `markdown.styles` accepts only a **workspace-relative path** (or an `https` URL). Absolute
paths and `file://` URLs are rejected by the preview webview ("Could not load"), so there is no global
"all workspaces" option through this setting. Use one of the approaches below.

## Per project

In the project's `.vscode/settings.json`:

```json
"markdown.styles": [
  "Themes/claude-dark.css"
]
```

The path is resolved relative to the workspace root. If the theme lives outside the workspace, copy it
in (for example to `.vscode/md-theme.css`) and point at that.

## Across several workspaces

Use [../Scripts/apply-md-theme.ps1](../Scripts/apply-md-theme.ps1): it copies the chosen theme into each
target workspace's `.vscode/md-theme.css` and wires up `markdown.styles` for you.

```powershell
.\apply-md-theme.ps1 -Theme "D:\path\to\Themes\claude-dark.css" -Workspace "D:\Projects\A","D:\Projects\B"
```

## Apply & refresh

1. Open any `.md` and press `Ctrl+Shift+V` for the native preview.
2. If a preview was already open, reload the window: `Ctrl+Shift+P` → `Reload Window`.
3. Edits to the CSS refresh on save.

## Switch themes

Change the filename in the setting to another theme under `Themes/` (e.g. `Themes/apple-dark-mono.css`)
and reload the window.

---

> Not sure which theme? See [Choosing-A-Theme.md](Choosing-A-Theme.md), or open
> [../Playground/live-preview.html](../Playground/live-preview.html).
