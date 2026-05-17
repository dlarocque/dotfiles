# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# Prompt is rendered by starship (init at the bottom of this file).
# Leave ZSH_THEME empty so oh-my-zsh doesn't draw its own prompt.
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  vi-mode
  sudo                      # Esc Esc to prepend sudo
  dirhistory                # alt+arrow to navigate dir history
  command-not-found         # suggest brew formula for missing cmds
  safe-paste                # bracketed paste, no accidental run
  extract                   # `x foo.tar.gz` universal archive extractor
  # External, cloned by bootstrap.sh into $ZSH/custom/plugins/:
  fzf-tab                   # Tab opens fzf for the argument
  zsh-syntax-highlighting   # MUST be last — instruments command buffer
)
# Note: zsh-autosuggestions intentionally NOT loaded — the gray inline
# predictions were more distracting than useful. Use Ctrl+R (atuin) for
# history search and Tab (fzf-tab) for completion instead.

# vi-mode: snappy mode switching. Default is 40 (= 400ms after Esc),
# which makes pressing Esc + another key feel laggy.
export KEYTIMEOUT=1

# Cursor shape changes per mode (vi-mode plugin handles this when set).
VI_MODE_SET_CURSOR=true

# ── Shell options ────────────────────────────────────────────────────
setopt AUTO_CD               # type a dir name to cd into it
setopt EXTENDED_GLOB         # ^, ~, # patterns in globs
setopt INTERACTIVE_COMMENTS  # # comments in interactive shell
setopt NO_BEEP               # never beep
setopt NOTIFY                # report bg job state changes immediately
setopt LONG_LIST_JOBS        # long format for `jobs`

# ── History (atuin handles search; these are for raw zsh history) ────
HISTSIZE=50000
SAVEHIST=50000
HISTFILE="$HOME/.zsh_history"
setopt SHARE_HISTORY         # share history across sessions immediately
setopt HIST_IGNORE_ALL_DUPS  # keep only most recent of duplicate cmds
setopt HIST_IGNORE_SPACE     # ' cmd' (leading space) doesn't go to history
setopt HIST_REDUCE_BLANKS    # trim whitespace before writing
setopt HIST_VERIFY           # `!!` expands but waits for Enter to run
setopt INC_APPEND_HISTORY    # append as commands run, not at shell exit

# ── Tab completion ───────────────────────────────────────────────────
# Case-insensitive matching, partial-word completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
# Menu-select with arrow keys
zstyle ':completion:*' menu select
# Colors in completion menu (uses LS_COLORS)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# Group completions by category with headers
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'
# fzf-tab: render the completion menu with fzf, show preview on the right
zstyle ':fzf-tab:complete:*' fzf-preview 'bat --color=always --style=numbers --line-range=:200 $realpath 2>/dev/null || eza --tree --color=always $realpath 2>/dev/null || ls -la $realpath'
zstyle ':fzf-tab:*' fzf-flags --height=40% --layout=reverse --border

[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

case "$OSTYPE" in
  darwin*)
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
    ;;
esac

# ── nvm + auto-`nvm use` on cd into a dir with .nvmrc ──────────────────
export NVM_DIR="$HOME/.nvm"
case "$OSTYPE" in
  darwin*)
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    ;;
  linux*)
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    ;;
esac

if command -v nvm >/dev/null 2>&1; then
  autoload -U add-zsh-hook
  load-nvmrc() {
    local nvmrc_path
    nvmrc_path="$(nvm_find_nvmrc)"
    if [ -n "$nvmrc_path" ]; then
      local nvmrc_version
      nvmrc_version=$(nvm version "$(cat "$nvmrc_path")")
      if [ "$nvmrc_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_version" != "$(nvm version)" ]; then
        nvm use
      fi
    else
      local default_version
      default_version=$(nvm version default)
      if [ "$default_version" != "N/A" ] && [ "$(nvm version)" != "$default_version" ]; then
        nvm use default >/dev/null
      fi
    fi
  }
  add-zsh-hook chpwd load-nvmrc
  load-nvmrc
fi

# ── Tool env vars ──────────────────────────────────────────────────────
export EDITOR=vim
export PYTHONSTARTUP="$HOME/.pythonrc"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
export BAT_THEME="ansi"

# fzf: use ripgrep for file listing; show preview with bat
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:200 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} 2>/dev/null || ls -la {}'"
# Layout / theme — keep your existing FZF_DEFAULT_OPTS in .fzf.zsh-ish style:
export FZF_DEFAULT_OPTS='
  --preview-window="border-sharp" --prompt="" --marker=">" --pointer="*"
  --separator="─" --scrollbar="│" --layout="reverse" --info="right"
'

alias ls="ls --color=always"
alias ll="ls -la --color=always"
alias c="clear"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias vi="nvim"
alias cat="bat --plain --paging=never"
alias f="fd"

alias gs="git status --short"
alias gl="git log"
alias ga="git add"
alias gal="git add ."
alias gc="git commit"
alias gca="git commit -a"
alias gcot="git checkout"
alias gsh="git stash"
alias gd="git diff"
alias gdw="git diff --word-diff"
alias gw="git whatchanged"
alias gpo="git push origin"

# ── Tool init lines — keep at the bottom; some depend on others ──────
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# atuin: Ctrl+R searches history. Up-arrow stays as zsh default.
command -v atuin >/dev/null 2>&1 && eval "$(atuin init zsh --disable-up-arrow)"

# starship prompt (last so it can read everything above)
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

