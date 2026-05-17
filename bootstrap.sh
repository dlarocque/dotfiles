#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }

# Homebrew
if ! command -v brew >/dev/null 2>&1; then
  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ -d /opt/homebrew/bin ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -d /home/linuxbrew/.linuxbrew/bin ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

BREW_FORMULAE=(
  stow
  git
  gh
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
  python
  go
  shellcheck
  universal-ctags
  btop
  hwloc
  hyperfine
  samply
  bandwhich
)
BREW_CASKS=(
  ghostty
  alacritty
  font-dejavu-sans-mono-nerd-font
)

log "Installing CLI tools"
brew install "${BREW_FORMULAE[@]}" || true

if [[ "$(uname -s)" == "Darwin" ]]; then
  log "Installing GUI apps"
  brew install --cask "${BREW_CASKS[@]}" || true

  if ! xcode-select -p >/dev/null 2>&1; then
    log "Installing Xcode Command Line Tools"
    xcode-select --install || true
  fi
fi

check_font() {
  local family="DejaVuSansM Nerd Font Mono"
  case "$(uname -s)" in
    Darwin)
      if ! ls "$HOME/Library/Fonts" /Library/Fonts 2>/dev/null | grep -qi 'DejaVuSansMNerdFontMono'; then
        log "WARNING: '$family' not found in ~/Library/Fonts or /Library/Fonts"
      fi
      ;;
    Linux)
      if command -v fc-list >/dev/null 2>&1 && ! fc-list | grep -qi "DejaVuSansM Nerd Font"; then
        log "WARNING: '$family' not found by fontconfig"
      fi
      ;;
  esac
}
check_font

PLUG_VIM="$HOME/.vim/autoload/plug.vim"
if [ ! -f "$PLUG_VIM" ]; then
  log "Installing vim-plug"
  curl -fLo "$PLUG_VIM" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  log "Cloning TPM"
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

if [ ! -d "$HOME/.ssh/control" ]; then
  mkdir -p "$HOME/.ssh/control"
  chmod 700 "$HOME/.ssh/control"
fi

if [ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
  if [ -L "$HOME/.oh-my-zsh" ]; then
    rm "$HOME/.oh-my-zsh"
  elif [ -d "$HOME/.oh-my-zsh" ]; then
    rmdir "$HOME/.oh-my-zsh" 2>/dev/null || true
  fi

  if [ ! -e "$HOME/.oh-my-zsh" ]; then
    log "Installing Oh My Zsh"
    RUNZSH=no KEEP_ZSHRC=yes sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
for repo in \
    "zsh-users/zsh-syntax-highlighting" \
    "Aloxaf/fzf-tab"; do
  name="$(basename "$repo")"
  dest="$ZSH_CUSTOM/plugins/$name"
  if [ ! -d "$dest" ]; then
    log "Cloning zsh plugin: $name"
    git clone --depth=1 "https://github.com/$repo" "$dest"
  fi
done

if command -v code >/dev/null 2>&1 && [ -f "$DOTFILES_DIR/vscode/extensions.txt" ]; then
  log "Installing VSCode extensions"
  grep -vE '^\s*(#|$)' "$DOTFILES_DIR/vscode/extensions.txt" | \
    xargs -I {} code --install-extension {} --force >/dev/null || true
fi

log "Running install.sh"
"$DOTFILES_DIR/install.sh" "$@"
