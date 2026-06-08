# Using a Zen Markdown theme in Typora

> [Placeholder — steps pending hands-on verification.]

## Idea

A Typora theme is just a CSS file. Drop it into Typora's themes folder and it appears in the
Themes menu.

## Steps (to be verified)

1. Open Typora's theme folder: `Preferences → Appearance → Open Theme Folder`
   (Windows default: `C:/Users/<you>/AppData/Roaming/Typora/themes`).
2. Copy `Themes/apple-dark-mono.css` (or another theme) into it. Typora theme filenames should be
   lowercase-hyphenated, which matches this project's naming.
3. Restart Typora and pick the theme from the `Themes` menu.

## Differences from the VS Code setup (to confirm)

- Typora uses `#write` as its content container; VS Code native preview uses `.markdown-body` / `body`.
  These themes already target all of those selectors, but rendering should be verified in Typora.
- [To confirm] Font loading and code-block highlighting under Typora.

---

> TODO: verify the themes in Typora, record the differences, and complete this guide.
