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

function add(){ $HOME/code/scripts/add $@ ;}

# Source zstyles you might use with antidote.
[[ -e ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

# Antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

eval "$(zoxide init --cmd j zsh)"

export PATH="$HOME/fvm/versions/stable/bin:$PATH"

# SDKMAN!
export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"
