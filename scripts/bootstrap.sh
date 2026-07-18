#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
    printf '%s\n' 'This bootstrap currently supports macOS only.' >&2
    exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
    printf '%s\n' 'Homebrew is required: https://brew.sh/' >&2
    exit 1
fi

brew_packages=(
    chezmoi
    fastfetch
    fzf
    jq
    lazygit
    lsd
    ripgrep
    tealdeer
    uv
    yazi
    zsh-autosuggestions
)
brew install "${brew_packages[@]}"
brew install --cask ghostty font-maple-mono-nf-cn

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
printf '%s\n' 'Reviewing the chezmoi diff before applying:'
chezmoi --source "$repo_root/chezmoi" diff
chezmoi --source "$repo_root/chezmoi" apply

if [[ "${SHELL:-}" != "/bin/zsh" ]]; then
    printf '%s\n' 'Default shell is not /bin/zsh. Run: chsh -s /bin/zsh'
fi

printf '%s\n' 'Configuration applied. Restart Ghostty, then run: fastfetch'
