---
name: ghostty-ambient-background
description: Configure and extend Ghostty Ambient when a user wants time-, weather-, random-, mood-, or other context-aware terminal backgrounds, including installation, custom image libraries, default modes, weather providers, and user-defined modes.
---

# Ghostty Ambient Background

Use this skill when a user asks an agent to install, configure, customize, or extend
the Ghostty Ambient project.

## Workflow

1. Read the repository `README.md`, `AGENTS.md`, and the core CLI.
2. Inspect the host:
   - macOS version and architecture;
   - Ghostty installation and version;
   - `jq`, `curl`, `bash`, and `zsh`;
   - existing `~/.config/ghostty/config`, `~/.zshrc`, and image directory.
3. Show or preserve a diff before modifying existing user configuration.
4. Choose the smallest mode implementation that satisfies the request:
   - `time`: map local time ranges to directories;
   - `weather`: use Open-Meteo for non-commercial personal use, or the user's own provider and API key;
   - `random`: choose from the local image pool with immediate-repeat avoidance;
   - `mood`: map a user label to a local mood directory;
   - a new mode: add an explicit selector and document its inputs.
5. Use `scripts/install-ambient.sh` for installation unless the user explicitly requests
   the complete terminal workspace.
6. Keep secrets out of Git. API keys belong in the user's shell environment, macOS
   Keychain, or another user-managed secret store.
7. Add or copy images into the appropriate category and preserve source/license
   information in `SOURCES.md`.
8. Verify with shell syntax checks, `ghostty +validate-config`, and one deterministic
   command per configured mode.

## Mode Selection

Use persisted defaults when the user wants behavior on every new Ghostty shell:

```bash
ghostty-time-background --set-mode time
ghostty-time-background --set-mode weather --weather auto
ghostty-time-background --set-mode mood --mood focus
ghostty-time-background --set-mode random
```

For one-off tests, use `--mode` without `--set-mode`. Use `--no-reload` when
testing selection only. Use `--time HH:MM` to test time ranges without changing
the operating system clock.

## Weather

The default weather path is:

```text
IP coordinates or GHOSTTY_LATITUDE/GHOSTTY_LONGITUDE
  -> Open-Meteo current weather_code
  -> clear/cloudy/rain/snow/storm
  -> local background directory
```

Open-Meteo does not require a key for non-commercial personal use, but it has
fair-use limits and attribution requirements. For a commercial product, ask the
user to provide their own licensed provider and credentials. Do not silently add
a paid API key or commit secrets.

If the user wants macOS Weather App data, explain that there is no stable public
local API. Prefer CoreLocation plus a weather API, or explicit coordinates.

## Customization

For a new mood such as `deep-work`:

1. Add `backgrounds/deep-work/` with one or more local images.
2. Add `deep-work` to the CLI validation and help text.
3. Update README and `SOURCES.md`.
4. Run the mode with `--no-reload`, then with reload enabled.

For a new time rule:

1. Edit the time selector in the core CLI.
2. Create matching asset directories.
3. Add a simulated-time test for every boundary.
4. Preserve the default `time` behavior unless the user asks to change it.

For an external image library, set:

```bash
export GHOSTTY_BACKGROUND_DIR="$HOME/Pictures/ghostty-backgrounds"
```

Adding a directory alone does not register a new mode. The CLI currently uses
explicit validation lists, so a new mood or mode must also update the CLI,
`--help`/`--list` output, README, source attribution, and deterministic checks.

## Safety

- Never overwrite unrelated dotfiles or run full bootstrap implicitly.
- Never use `chezmoi apply --force`.
- Do not delete user images.
- Explain when Accessibility permission is needed for simulated reload.
- Report anything that could not be verified.
- Ghostty Ambient supports macOS only. Stop before changing files on another OS.
