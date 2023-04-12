#!/bin/zsh

# setopt SHARE_HISTORY

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Functions
trash() {
    mv $1 ~/.trash
    echo "Moved $1 to trash"
}

# Source zstyles you might use with antidote.
[[ -e ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

# Antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

# Autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
