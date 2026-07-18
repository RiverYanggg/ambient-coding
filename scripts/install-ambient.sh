#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_backgrounds="$repo_root/chezmoi/dot_config/ghostty/backgrounds"
source_script="$repo_root/chezmoi/dot_local/bin/executable_ghostty-time-background"
background_dir="$HOME/.config/ghostty/backgrounds"
config_file="$HOME/.config/ghostty/config"
bin_dir="$HOME/.local/bin"
zshrc="$HOME/.zshrc"
no_deps=false

usage() {
    cat <<'EOF'
Usage: bash scripts/install-ambient.sh [--no-deps]

Install Ghostty Ambient without replacing the user's existing shell setup.

The installer:
- checks or installs Ghostty and jq when Homebrew is available;
- installs the background library and CLI under the user's home directory;
- adds an idempotent Ghostty-only hook to ~/.zshrc;
- updates only the background-image entry in Ghostty's config.
EOF
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --no-deps) no_deps=true; shift ;;
        -h|--help) usage; exit 0 ;;
        *) printf 'unknown option: %s\n' "$1" >&2; usage >&2; exit 2 ;;
    esac
done

if [[ "$(uname -s)" != "Darwin" ]]; then
    printf '%s\n' 'Ghostty Ambient currently supports macOS only.' >&2
    exit 1
fi

if [[ "$no_deps" == false && -x "$(command -v brew 2>/dev/null || true)" ]]; then
    if ! command -v jq >/dev/null 2>&1; then
        brew install jq
    fi
    if [[ ! -d "/Applications/Ghostty.app" ]]; then
        brew install --cask ghostty
    fi
fi

if [[ ! -d "/Applications/Ghostty.app" ]]; then
    printf '%s\n' 'Ghostty.app was not found. Install Ghostty first: https://ghostty.org/download' >&2
    exit 1
fi

mkdir -p "$background_dir" "$bin_dir" "$(dirname "$config_file")"

while IFS= read -r image; do
    relative="${image#"$source_backgrounds"/}"
    destination="$background_dir/$relative"
    mkdir -p "$(dirname "$destination")"
    install -m 644 "$image" "$destination"
done < <(find "$source_backgrounds" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) -print)

if [[ ! -f "$background_dir/current.jpg" ]]; then
    install -m 644 "$background_dir/evening/mountains.jpg" "$background_dir/current.jpg"
fi

install -m 755 "$source_script" "$bin_dir/ghostty-time-background"

image_path="$background_dir/current.jpg"
config_tmp="$(mktemp "${TMPDIR:-/tmp}/ghostty-config.XXXXXX")"
if [[ -f "$config_file" ]]; then
    awk -v image="$image_path" '
        /^[[:space:]]*background-image[[:space:]]*=/ {
            if (!written) {
                print "background-image = " image
                written = 1
            }
            next
        }
        { print }
        END {
            if (!written) print "background-image = " image
        }
    ' "$config_file" > "$config_tmp"
else
    printf '%s\n' \
        'command = /bin/zsh -l' \
        'background-opacity = 0.85' \
        'background-image = '"$image_path" \
        'background-image-opacity = 0.18' \
        'background-image-fit = cover' \
        'keybind = cmd+shift+comma=reload_config' > "$config_tmp"
fi
install -m 644 "$config_tmp" "$config_file"
rm -f "$config_tmp"

hook_start="# >>> ghostty-ambient >>>"
hook_end="# <<< ghostty-ambient <<<"
if [[ ! -f "$zshrc" ]]; then
    : > "$zshrc"
fi
if ! grep -Fq "$hook_start" "$zshrc" && ! grep -Fq 'ghostty-time-background --quiet' "$zshrc"; then
    printf '%s\n' \
        '' \
        "$hook_start" \
        'export PATH="$HOME/.local/bin:$PATH"' \
        'if [[ "$TERM_PROGRAM" == "ghostty" ]] && command -v ghostty-time-background >/dev/null 2>&1; then' \
        '    ghostty-time-background --quiet' \
        'fi' \
        "$hook_end" >> "$zshrc"
fi

printf '%s\n' \
    'Ghostty Ambient installed.' \
    "CLI: $bin_dir/ghostty-time-background" \
    "Backgrounds: $background_dir" \
    'Reload your shell with: source ~/.zshrc' \
    'Then test with: ghostty-time-background --mode random'
