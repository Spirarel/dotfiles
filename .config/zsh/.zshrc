#!/bin/zsh

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

eval "$(zoxide init --cmd j zsh)"

echo "Remember to use autojump and up!"
