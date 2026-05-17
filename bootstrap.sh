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
  universal-ctags # gutentags backend (jump-to-definition in vim/nvim)
  btop            # system monitor
  # ── Performance / profiling toolkit ──────────────────────────────
  hwloc           # lstopo: visualize CPU + cache + NUMA topology
  hyperfine       # statistical command-line benchmarking
  samply          # sampling profiler -> Firefox Profiler viewable
  bandwhich       # per-process network bandwidth
)
BREW_CASKS=(
  ghostty
  alacritty
  font-dejavu-sans-mono-nerd-font   # terminal font used by ghostty + alacritty configs
)

log "Installing CLI tools (formulae)"
brew install "${BREW_FORMULAE[@]}" || true

if [[ "$(uname -s)" == "Darwin" ]]; then
  log "Installing GUI apps (casks)"
  brew install --cask "${BREW_CASKS[@]}" || true

  # Xcode Command Line Tools — unlocks Instruments, xctrace, sample,
  # leaks, heap, vmmap, fs_usage, powermetrics. The macOS perf foundation.
  if ! xcode-select -p >/dev/null 2>&1; then
    log "Installing Xcode Command Line Tools (interactive prompt)"
    xcode-select --install || true
  else
    log "Xcode Command Line Tools already installed"
  fi
fi

# ── Sanity check: terminal font installed? ─────────────────────────────
check_font() {
  local family="DejaVuSansM Nerd Font Mono"
  case "$(uname -s)" in
    Darwin)
      if ! ls "$HOME/Library/Fonts" /Library/Fonts 2>/dev/null | grep -qi 'DejaVuSansMNerdFontMono'; then
        log "WARNING: '$family' not found in ~/Library/Fonts or /Library/Fonts"
        log "  Install via:  brew install --cask font-dejavu-sans-mono-nerd-font"
      fi
      ;;
    Linux)
      if command -v fc-list >/dev/null 2>&1 && ! fc-list | grep -qi "DejaVuSansM Nerd Font"; then
        log "WARNING: '$family' not found by fontconfig"
        log "  Install the .ttf into ~/.local/share/fonts/ and run 'fc-cache -fv'"
      fi
      ;;
  esac
}
check_font

# ── fzf key-bindings install (writes ~/.fzf.* files — we stow our own) ──
# Only run if user wants the fzf binary set up in shells we don't control.
# Our zsh integration is stowed via zsh/.fzf.zsh.

# ── vim-plug for vim ──────────────────────────────────────────────────
# nvim's plug.vim is committed in the repo (nvim/.config/nvim/autoload/);
# vim's isn't (vim/.vim/autoload is in .gitignore). Fetch it here.
PLUG_VIM="$HOME/.vim/autoload/plug.vim"
if [ ! -f "$PLUG_VIM" ]; then
  log "Installing vim-plug for vim"
  curl -fLo "$PLUG_VIM" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  log "vim-plug already installed for vim"
fi

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

# ── External zsh plugins (cloned into omz custom dir) ─────────────────
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
for repo in \
    "zsh-users/zsh-autosuggestions" \
    "zsh-users/zsh-syntax-highlighting" \
    "Aloxaf/fzf-tab"; do
  name="$(basename "$repo")"
  dest="$ZSH_CUSTOM/plugins/$name"
  if [ ! -d "$dest" ]; then
    log "Cloning zsh plugin: $name"
    git clone --depth=1 "https://github.com/$repo" "$dest"
  fi
done

# ── VSCode extensions (if `code` CLI on PATH) ──────────────────────────
if command -v code >/dev/null 2>&1 && [ -f "$DOTFILES_DIR/vscode/extensions.txt" ]; then
  log "Installing VSCode extensions"
  grep -vE '^\s*(#|$)' "$DOTFILES_DIR/vscode/extensions.txt" | \
    xargs -I {} code --install-extension {} --force >/dev/null || true
fi

# ── Stow everything ────────────────────────────────────────────────────
log "Running install.sh"
"$DOTFILES_DIR/install.sh" "$@"

log "Done. New shell: open ghostty/alacritty fresh, or run 'exec zsh'."
log "First tmux session: press Ctrl-a + I to install TPM plugins."
