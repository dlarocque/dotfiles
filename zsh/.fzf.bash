# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

export BAT_THEME="gruvbox-dark"

# FZF default options
# Combines your custom theme with the bat previewer command
export FZF_DEFAULT_OPTS='
  --preview-window="border-sharp" --prompt="" --marker=">" --pointer="*"
  --separator="─" --scrollbar="│" --layout="reverse" --info="right"
  --preview="bat --theme=\"$BAT_THEME\" --color=always --style=numbers --line-range :500 {}"
'

# GRUVBOX 
#  --color=fg:#a59986,fg+:#e8dbb6,bg:#272727,bg+:#1b1b1b
#  --color=hl:#548386,hl+:#89a498,info:#afaf87,marker:#739b6e
#  --color=prompt:#bb3629,spinner:#a66584,pointer:#c8899a,header:#87afaf
#  --color=border:#1b1b1b,label:#aeaeae,query:#d9d9d9

# Load fzf keybindings
eval "$(fzf --bash)"
