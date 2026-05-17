#!/usr/bin/env bash
# Bootstrap a new machine:
#   1. install homebrew if missing
#   2. install all CLI tools the dotfiles assume exist
#   3. clone TPM (tmux plugin manager) and ssh control dir
#   4. run ./install.sh
#
# Safe to re-run — every step is idempotent.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }

# ── Homebrew (macOS / Linux) ───────────────────────────────────────────
if ! command -v brew >/dev/null 2>&1; then
  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH for the rest of this script (next shell session picks
  # it up via the case "$OSTYPE" block in zshrc).
  if [ -d /opt/homebrew/bin ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -d /home/linuxbrew/.linuxbrew/bin ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
else
  log "Homebrew already installed"
fi

# ── CLI tools the dotfiles assume exist ────────────────────────────────
BREW_FORMULAE=(
  stow            # symlink farmer
  git
  gh              # github CLI
  vim
  neovim
  tmux
  fzf
  ripgrep
  fd
  bat
  starship
  zoxide
  atuin
  nvm
  python          # for pythonrc
  go
  shellcheck      # script linting
)
BREW_CASKS=(
  ghostty
  alacritty
)

log "Installing CLI tools (formulae)"
brew install "${BREW_FORMULAE[@]}" || true

if [[ "$(uname -s)" == "Darwin" ]]; then
  log "Installing GUI apps (casks)"
  brew install --cask "${BREW_CASKS[@]}" || true
fi

# ── fzf key-bindings install (writes ~/.fzf.* files — we stow our own) ──
# Only run if user wants the fzf binary set up in shells we don't control.
# Our zsh integration is stowed via zsh/.fzf.zsh.

# ── TPM (Tmux Plugin Manager) ──────────────────────────────────────────
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  log "Cloning TPM"
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  log "TPM already cloned"
fi

# ── SSH ControlPath dir ────────────────────────────────────────────────
if [ ! -d "$HOME/.ssh/control" ]; then
  log "Creating ~/.ssh/control"
  mkdir -p "$HOME/.ssh/control"
  chmod 700 "$HOME/.ssh/control"
fi

# ── Oh My Zsh (optional; zshrc tolerates its absence) ──────────────────
if [ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
  # Clear out anything in the way (dangling symlink, empty placeholder dir).
  if [ -L "$HOME/.oh-my-zsh" ]; then
    log "Removing dangling ~/.oh-my-zsh symlink"
    rm "$HOME/.oh-my-zsh"
  elif [ -d "$HOME/.oh-my-zsh" ]; then
    rmdir "$HOME/.oh-my-zsh" 2>/dev/null || {
      log "~/.oh-my-zsh exists but is not a valid omz install and not empty; skipping"
    }
  fi

  if [ ! -e "$HOME/.oh-my-zsh" ]; then
    log "Installing Oh My Zsh"
    RUNZSH=no KEEP_ZSHRC=yes sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
else
  log "Oh My Zsh already installed"
fi

# ── Stow everything ────────────────────────────────────────────────────
log "Running install.sh"
"$DOTFILES_DIR/install.sh" "$@"

log "Done. New shell: open ghostty/alacritty fresh, or run 'exec zsh'."
log "First tmux session: press Ctrl-a + I to install TPM plugins."
