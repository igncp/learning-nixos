# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
bindkey "\C-g" vi-forward-blank-word
bindkey "\C-f" vi-backward-blank-word
bindkey "\C-u" kill-region

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>/|'

backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '\C-h' backward-kill-dir

get_jobs_prefix() {
  JOBS=$(jobs | wc -l)
  if [ "$JOBS" -eq "0" ]; then echo ""; else echo "$JOBS "; fi
}

setopt PROMPT_SUBST
PS1_BEGINNING="[NixOS] "
PS1_NEXT="$SSH_PS1_NOTICE%F{magenta}%1d"
PS1_MIDDLE=' $(get_jobs_prefix)'
PS1_END='%F{blue}$(date +"%H:%M") %F{reset_color}'
NEXT_TASK='-'
RPROMPT="[$NEXT_TASK]"

PS1=$'\n'$'\n'"$PS1_BEGINNING$PS1_NEXT$PS1_MIDDLE$PS1_END"
SHELL=/bin/zsh

# cd -[tab] to see options. `dirs -v` to list previous history
setopt AUTO_PUSHD                  # pushes the old directory onto the stack
setopt PUSHD_MINUS                 # exchange the meanings of '+' and '-'
setopt CDABLE_VARS                 # expand the expression (allows 'cd -2/tmp')
autoload -U compinit && compinit   # load + start completion
zstyle ':completion:*:directory-stack' list-colors '=(#b) #([0-9]#)*( *)==95=38;5;12'

export NODE_DISABLE_COLORS=1

_zsh_cli_fg() {
  LAST_JOB="$(jobs | tail -n 1 | grep -o '[0-9]*' | head -n 1)"
  fg "%$LAST_JOB";
}
zle -N _zsh_cli_fg
bindkey '^X' _zsh_cli_fg

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

alias ll='ls -lah'

plugins=(
  git
  ufw
  zsh-syntax-highlighting
  zsh-autopair
  zsh-completions
)

# TODO: There is an issue with the following file
# bindkey "\C-k" edit-command-line
