#!/bin/zsh

# zmodload zsh/zprof


# ---------------------------------------------------------
zpath=${ZDOTDIR:-~}
# Define the plugin list and the compiled static file
zplugins=$zpath/.zsh_plugins.txt
zstatic=$zpath/.zsh_plugins.zsh

# Only run the heavy 'antidote load' logic if the static file is missing 
# or if you updated your .zsh_plugins.txt
if [[ ! -f "$zstatic" || "$zplugins" -nt "$zstatic" ]]; then
  source $zpath/.antidote/antidote.zsh
  antidote bundle < "$zplugins" > "$zstatic"
fi
source "$zstatic"

# ---------------------------------------------------------
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# ---------------------------------------------------------
export PATH="$HOME/fvm/versions/stable/bin:$PATH"
zsh-defer eval "$(zoxide init --cmd j zsh)"

# ---------------------------------------------------------
trash() {
  mv "$1" ~/.trash
  echo "Moved $1 to trash"
}

function add(){ $HOME/code/scripts/add "$@" ;}

# ---------------------------------------------------------
export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
if [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]]; then
  zsh-defer source "${SDKMAN_DIR}/bin/sdkman-init.sh"
fi

# Source zstyles
[[ -e $zpath/.zstyles ]] && source $zpath/.zstyles

# zprof
