# Path to your oh-my-zsh installation.
#Conditional path based on OS
system_type=$(uname -s)
if [ "$system_type" = "Linux" ]; then
  export ZSH=/home/stephen/.oh-my-zsh
else
  export ZSH=/Users/Stephen/.oh-my-zsh
fi

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"
#ZSH_THEME="fletcherm"
# ZSH_THEME="random"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git python wd autojump)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

trash() {
    mv $1 ~/.trash
    echo "Moved $1 to trash"
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias py="python3"
alias l="ls -A"
alias nv="nvim"
alias lg="ls | grep"
alias mute="sh ~/code/scripts/SpoMutify.sh > /dev/null 2>&1 &"
alias journal="nv ~/Desktop/journal.md"
alias scott="code Documents/thoughts/on\ books/lessons\ from\ Scott\ circa\ 2020.md"
alias ds="docker ps -q | xargs docker stop"
alias bup="
touch ~/temp_dock
defaults export com.apple.dock ~/temp_dock
brew upgrade
defaults import com.apple.dock ~/temp_dock
rm ~/temp_dock
killall Dock"
alias ctl="TEST_LOG=true cargo test | bunyan" # cargo test "logging"

export JULIA_NUM_THREADS="auto"
##Conditional alias based on current OS
#system_type=$(uname -s)
#if ["$system_type" = "Linux" ]; then
#  alias cfg='/usr/bin/git --git-dir
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

#Autojump stuff
#[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
autoload -U compinit && compinit
#
# Needed for virtualenv
# export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
# source /usr/local/bin/virtualenvwrapper.sh
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi

eval "$(pyenv init -)"
alias pluto='julia -e "using Pluto
if length(ARGS) > 0
    notebook = ARGS[1]
    Pluto.run(notebook=joinpath(pwd(), notebook))
else
    Pluto.run()
end"'

# add_fn() {
#   echo $1() { $2 } >> ~/.zshrc
# }

[ -f "/Users/stephen/.ghcup/env" ] && source "/Users/stephen/.ghcup/env" # ghcup-env
