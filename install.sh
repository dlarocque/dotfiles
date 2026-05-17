#!/usr/bin/env bash
# Stow dotfiles for a given environment.
#
# Usage:
#   ./install.sh                  # auto-detect from `uname`
#   ./install.sh macos
#   ./install.sh linux-kinesis
#   ./install.sh --list
#   ./install.sh --dry-run [env]
#
# Add a new environment by appending a case branch in pick_packages().

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

COMMON_PACKAGES=(
  zsh bash git vim nvim tmux fish gh zellij
  ssh bin starship atuin bat ripgrep python go
)

pick_packages() {
  local env="$1"
  case "$env" in
    macos)
      PACKAGES=("${COMMON_PACKAGES[@]}" alacritty-macos ghostty)
      OS_GITCONFIG="$DOTFILES_DIR/git/.gitconfig.macos"
      ;;
    linux-kinesis|linux)
      PACKAGES=("${COMMON_PACKAGES[@]}" alacritty-linux i3 terminator)
      OS_GITCONFIG="$DOTFILES_DIR/git/.gitconfig.linux"
      ;;
    *)
      echo "unknown environment: $env" >&2
      echo "known: macos, linux-kinesis" >&2
      exit 1
      ;;
  esac
}

detect_env() {
  case "$(uname -s)" in
    Darwin) echo macos ;;
    Linux)  echo linux-kinesis ;;
    *)      echo "cannot auto-detect env from $(uname -s)" >&2; exit 1 ;;
  esac
}

list_envs() {
  cat <<EOF
Available environments:
  macos          -> ${COMMON_PACKAGES[*]} alacritty-macos ghostty
  linux-kinesis  -> ${COMMON_PACKAGES[*]} alacritty-linux i3 terminator
EOF
}

main() {
  local dry_run=0
  local env=""

  for arg in "$@"; do
    case "$arg" in
      --list) list_envs; exit 0 ;;
      --dry-run) dry_run=1 ;;
      -h|--help) sed -n '2,11p' "$0"; exit 0 ;;
      *) env="$arg" ;;
    esac
  done

  [ -z "$env" ] && env=$(detect_env)
  pick_packages "$env"

  command -v stow >/dev/null || { echo "stow not found in PATH" >&2; exit 1; }

  local stow_flags=(-t "$HOME" -R -d "$DOTFILES_DIR")
  [ "$dry_run" -eq 1 ] && stow_flags+=(-n -v)

  echo "Environment: $env"
  echo "Packages:    ${PACKAGES[*]}"
  echo

  stow "${stow_flags[@]}" "${PACKAGES[@]}"

  if [ "$dry_run" -eq 0 ]; then
    ln -sfn "$OS_GITCONFIG" "$HOME/.gitconfig.os"
    echo "linked ~/.gitconfig.os -> $OS_GITCONFIG"
  else
    echo "would link ~/.gitconfig.os -> $OS_GITCONFIG"
  fi
}

main "$@"
