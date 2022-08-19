# PROMPT='%B%F{green}%n@%m%f:%F{blue}%~%f $%B '
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f $ '
RPROMPT="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

alias gs="git status"
alias ga="git add ."
alias gc="git commit"
alias gd="git diff"
alias gpm="git push origin master"
