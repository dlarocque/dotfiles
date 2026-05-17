export NVM_DIR="$HOME/.nvm"

case "$OSTYPE" in
  darwin*)
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    export PATH="$PATH:/opt/homebrew/bin"
    ;;
  linux*)
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    ;;
esac

bind '"\e[^[[D": backward-word'  # Ctrl+Left Arrow
bind '"\e[C": forward-word'   # Ctrl+Right Arrow

function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
}

# export PS1="\n\t \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
export PS1="\n\[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
# export PS1="\n\w\\[\033[00m\] $ "
# export LS_COLORS=$LS_COLORS:'di=0;36:'
alias ls="ls --color=always"
alias ll="ls -la --color=always"
alias c="clear"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

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
