# AGENTS.md

## Project scope

This repository packages Ghostty Ambient, a macOS-first tool that selects a local
Ghostty background from time, weather, random, or mood context.

When a user asks to configure or extend the project, treat the Ambient feature as
the primary scope. The full terminal workspace in `scripts/bootstrap.sh` is
optional and must not be installed unless the user explicitly asks for it.

## Required reading

Before changing anything, read:

1. `README.md`
2. `docs/CONFIGURATION.md`
3. `chezmoi/dot_local/bin/executable_ghostty-time-background`
4. `skills/ghostty-ambient-background/SKILL.md` when the request concerns user-defined modes or agent automation.

## Environment prerequisites

The supported runtime is macOS with:

- Ghostty 1.2.0 or newer, installed as `/Applications/Ghostty.app`;
- Bash, zsh, curl;
- jq for automatic weather mode;
- Homebrew is recommended but not mandatory if dependencies are already installed.

Open-Meteo's public endpoint does not require an API key for non-commercial
personal use. If a user chooses a paid or commercial weather provider, the user
must supply the account and API key. Never invent, commit, print, or store a
secret in the repository.

## Safe automation workflow

1. Inspect `uname -s`, Ghostty availability, `command -v jq`,
   `command -v curl`, current Ghostty config, and `git status`.
2. Back up or show a diff for existing user configuration before applying changes.
3. Prefer `bash scripts/install-ambient.sh` for a normal installation. Use
   `--no-deps` when dependencies are managed separately.
4. Do not run the full `scripts/bootstrap.sh` unless the user requests the
   complete macOS terminal workspace.
5. Keep user configuration changes narrow:
   - replace only the `background-image` entry in Ghostty config;
   - add the marked idempotent hook to `~/.zshrc`;
   - install the CLI under `~/.local/bin`;
   - copy assets under `~/.config/ghostty/backgrounds/`.
6. For existing chezmoi-managed machines, run
   `chezmoi --source "$PWD/chezmoi" diff` before `apply`. Do not use
   `chezmoi apply --force` or overwrite unrelated dotfiles.
7. If macOS blocks automatic Ghostty reload, explain the Accessibility permission
   and keep the manual `Cmd+Shift+,` fallback.

## Mode configuration rules

The CLI is:

```text
chezmoi/dot_local/bin/executable_ghostty-time-background
```

Keep the existing mode contract stable:

- `time`: morning, afternoon, evening;
- `weather`: auto, clear, cloudy, rain, snow, storm;
- `random`: all local image directories, without immediate repetition;
- `mood`: calm, focus, energy, tired, happy, plus documented user additions.

For a new mode or mood:

1. Add or update the validation list.
2. Add the matching asset directory under
   `chezmoi/dot_config/ghostty/backgrounds/`.
3. Update the CLI help and README.
4. Add a deterministic manual test command.
5. Run `bash -n` on the CLI and `zsh -n` on any shell template.
6. Validate Ghostty with `ghostty +validate-config` or the full app path.

## User customization

User-provided images should be copied, not silently deleted or replaced. Preserve
the `SOURCES.md` attribution record for downloaded assets. Use
`GHOSTTY_BACKGROUND_DIR` for an external library and
`GHOSTTY_LATITUDE`/`GHOSTTY_LONGITUDE` to avoid IP geolocation.

When the user describes a new context such as "deep work on rainy mornings":

- map it to existing tags if possible;
- otherwise create a small, explicit mode or mood directory;
- do not add an API dependency when a local rule is sufficient;
- explain any new permission, network, or API-key requirement.

## Verification and handoff

Before declaring completion, verify:

```bash
bash -n chezmoi/dot_local/bin/executable_ghostty-time-background
bash -n scripts/install-ambient.sh
zsh -n chezmoi/dot_zshrc.tmpl
ghostty-time-background --list
ghostty-time-background --mode time --time 09:00 --no-reload
ghostty-time-background --mode weather --weather rain --no-reload
ghostty-time-background --mode mood --mood focus --no-reload
ghostty-time-background --mode random --no-reload
/Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config
```

Report actual modified files, commands run, failed or unverified checks, and
whether the user needs to restart Ghostty or grant Accessibility access.
