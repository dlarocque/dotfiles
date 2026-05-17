# fzf shell integration — sourced from .zshrc.
# Note: the fzf installer (`$(brew --prefix fzf)/install`) normally writes
# this file. We commit a hand-maintained version instead so the keybindings
# and PATH munging stay portable across machines.

# Ensure fzf's binary is on PATH (homebrew install location on macOS).
if [[ "$OSTYPE" == darwin* ]] && [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Load fzf's zsh keybindings (Ctrl+T file picker, Ctrl+R history, Alt+C cd).
eval "$(fzf --zsh)"
