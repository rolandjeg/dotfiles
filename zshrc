#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
bindkey -v

export EDITOR=vim
export VISUAL=vim
export MPD_HOST=/tmp/mpd.sock
alias ]=rifle
alias t=task

if [[ $TERM == "xterm" ]]; then
    export TERM=xterm-256color
fi

setopt CLOBBER

alias pacnew-finder='find /etc -regextype posix-extended -regex ".+\.pac(new|save|orig)" 2> /dev/null'
