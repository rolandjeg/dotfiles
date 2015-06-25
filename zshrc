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
export SDL_SOUNDFONTS=/usr/share/soundfonts/SGM-V2.01.sf2
alias ]=rifle
alias t=task
alias wine32="WINEPREFIX=~/.wine32 WINEARCH='win32' wine"

if [[ $TERM == "xterm" ]]; then
    export TERM=xterm-256color
fi

setopt CLOBBER

pacman-size()
{
    CMD="pacman -Si"
    SEP=": "
    TOTAL_SIZE=0
    
    RESULT=$(eval "${CMD} $@ 2>/dev/null" | awk -F "$SEP" -v filter="Size" -v pkg="^Name" \
      '$0 ~ pkg {pkgname=$2} $0 ~ filter {gsub(/\..*/,"") ; printf("%6s KiB %s\n", $2, pkgname)}' | sort -u -k3)
    
    echo "$RESULT"
    
    ## Print total size.
    echo "$RESULT" | awk '{TOTAL=$1+TOTAL} END {printf("Total : %d KiB\n",TOTAL)}'
}

alias pacnew-finder='find /etc -regextype posix-extended -regex ".+\.pac(new|save|orig)" 2> /dev/null'
