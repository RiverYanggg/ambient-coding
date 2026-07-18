# AGENTS.md

## Project identity

This repository is the unified `ambient-coding` project: a macOS terminal
workspace designed to keep coding focused, efficient, and comfortable. It is
built around Ghostty, zsh, chezmoi, and Ghostty Ambient.

The practical terminal workflow and the Ambient experience are equally supported:
tools, shortcuts, navigation, Git, search, reproducible configuration, and
low-distraction backgrounds all belong to the same product. Prioritize a reliable
coding workflow and readability; Ambient is an enhancement and must never make
the terminal harder to use. Ghostty currently supports macOS only; do not provide
Linux or Windows installation paths.

## Choose the scope first

Classify the user's request before changing files:

- Complete workspace: install or modify Ghostty, zsh, Oh My Zsh, Yazi, lazygit,
  ripgrep, jq, fzf, lsd, uv, tldr, fastfetch, fonts, and chezmoi. Use
  `scripts/bootstrap.sh` only when explicitly requested.
- Ambient-only: install or customize backgrounds, modes, weather, or moods. Use
  `scripts/install-ambient.sh` and preserve the user's existing shell setup.
- Combined workflow: configure both the practical terminal tools and Ambient when
  the user wants a complete focused-coding environment.
- Documentation or agent request: update the relevant README, docs, AGENTS, or
  Skill without applying user configuration unless requested.

Never run the full bootstrap implicitly for an Ambient-only request.

## Required reading

Before changing anything, read:

1. `README.md`
2. `docs/CONFIGURATION.md`
3. `docs/KEYBINDS.md` when the request concerns shortcuts or tools
4. `docs/CHEZMOI.md` when the request concerns migration or chezmoi
5. `chezmoi/dot_local/bin/executable_ghostty-time-background` when the request concerns backgrounds
6. `skills/ghostty-ambient-background/SKILL.md` when the request concerns custom modes, images, weather, or agent automation

## Supported environment

The supported runtime is macOS with:

- Ghostty 1.2.0 or newer, normally installed as `/Applications/Ghostty.app`;
- Bash, zsh, curl, and Homebrew;
- `jq` for automatic weather mode;
- chezmoi for the complete workspace flow.

Confirm the platform first:

```bash
uname -s
uname -m
```

If the result is not `Darwin`, stop and explain that Ghostty Ambient and this
Ghostty workspace are macOS-only.

## Safe workflow

1. Inspect `uname -s`, Ghostty, Homebrew, required commands, current config, and
   `git status`.
2. Show `chezmoi --source "$PWD/chezmoi" diff` before applying managed files.
3. Back up or preserve user configuration before modifying it.
4. Use `scripts/install-ambient.sh` for Ambient-only requests.
5. Use `scripts/bootstrap.sh` for complete workspace requests only.
6. Keep changes narrow: do not overwrite unrelated dotfiles, images, or tools.
7. Never use `chezmoi apply --force`.
8. Explain any new network request, API key, Accessibility permission, or shell
   restart requirement.

The Ambient installer must only change the Ghostty background path, install the
Ambient CLI/assets, and add its marked idempotent zsh hook. The complete bootstrap
may apply the full `chezmoi/` source after showing the diff. In either path,
preserve terminal readability and do not let background changes override practical
tool or shortcut configuration.

## Terminal workspace contract

Preserve these established behaviors unless the user explicitly asks to change
them:

- Ghostty starts `/bin/zsh -l` with Catppuccin Mocha, Menlo, transparency, blur,
  splits, quick terminal, paste protection, and shell integration.
- zsh uses the `clean` Oh My Zsh theme, `git`, `brew`, `macos`, and
  `colored-man-pages` plugins, plus optional autosuggestions.
- `y` opens Yazi and returns to the last visited directory on exit.
- `rg` receives the repository ripgrep config through a local shell function;
  never export `RIPGREP_CONFIG_PATH` globally.
- Do not reintroduce Fish, Oh My Fish, or `fzf-tab`.
- Optional conda, nvm, and OpenClaw integrations must remain existence-checked.

## Ambient mode contract

Ambient is optional but first-class. It should complement, never compete with, the
coding workflow: use low-opacity, low-distraction images, keep text readable, and
avoid adding network or permission requirements when a local rule is sufficient.

The core CLI is:

```text
chezmoi/dot_local/bin/executable_ghostty-time-background
```

Keep these modes stable:

- `time`: morning, afternoon, evening;
- `weather`: auto, clear, cloudy, rain, snow, storm;
- `random`: the managed `time`, `weather`, `mood`, and `random` image
  namespaces, without immediate repetition;
- `mood`: calm, focus, energy, tired, happy, plus documented user additions.

Use this background layout for new assets:

```text
backgrounds/
├── current.jpg
├── time/{morning,afternoon,evening}/
├── weather/{clear,cloudy,rain,snow,storm}/
├── mood/{calm,focus,energy,tired,happy}/
└── random/
```

`current.jpg` is a generated runtime copy used by Ghostty. Do not treat it as a
source asset. The CLI may keep read-only compatibility with older flat
directories such as `backgrounds/focus/`, but new work must use the namespaced
layout and update source records with the new paths.

Weather uses Open-Meteo for non-commercial personal use. Prefer explicit
`GHOSTTY_LATITUDE` and `GHOSTTY_LONGITUDE` when the user does not want IP-based
location. Never invent, commit, print, or store API keys.

For a new mood or mode:

1. Map the request to an existing mode when possible.
2. Otherwise update the CLI validation and selector/help output.
3. Add the matching image directory under the correct mode namespace and preserve image source/license records.
4. Update README and relevant documentation.
5. Add deterministic test commands for boundaries and fallback behavior.
6. Do not claim that adding a directory alone registers a new mode.

User-provided images should be copied, not silently deleted or replaced. Use
`GHOSTTY_BACKGROUND_DIR` for an external library.

## Verification

Run the checks relevant to the requested scope and report actual results:

```bash
bash -n scripts/bootstrap.sh
bash -n scripts/install-ambient.sh
bash -n chezmoi/dot_local/bin/executable_ghostty-time-background
zsh -n chezmoi/dot_zshrc.tmpl
ghostty-time-background --list
ghostty-time-background --mode time --time 09:00 --no-reload
ghostty-time-background --mode weather --weather rain --no-reload
ghostty-time-background --mode mood --mood focus --no-reload
ghostty-time-background --mode random --no-reload
/Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config
```

For a complete workspace, also verify `chezmoi status`, the expected commands,
and `source ~/.zshrc` after applying. Report failed or unavailable checks, files
changed, whether Ghostty must restart, and whether Accessibility access is needed.
