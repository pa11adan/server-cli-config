# Luke's config for the Zoomer Shell

# zmodload zsh/zprof
export EDITOR="nvim"
export PATH="$PATH:$HOME/.local/bin"


# history
export SAVEHIST=1000
export HISTFILE=~/.config/zsh/.zsh_history
export HISTSIZE=20
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T]"
export HIST_STAMPS="yyyy-mm-dd"

autoload -U colors && colors
PS1="%B%{$fg[green]%}[%{$fg[blue]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[yellow]%}%~%{$fg[green]%}]%{$fg[blue]%}$%b "
RPROMPT="%B%{$fg[green]%}[%{$fg[blue]%}%D{%Y-%m-%d} %D{%L:%M:%S}%{$fg[green]%}]"

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# Include hidden files in autocomplete:
_comp_options+=(globdots)

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

bindkey -s '^o' 'lfcd\n'  # zsh

autoload edit-command-line
zle -N edit-command-line
bindkey '^x' edit-command-line

#source /home/tom/.config/broot/launcher/bash/br

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# zprof
