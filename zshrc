##############################################################
# Utility functions
##############################################################

function os() {
  if [[ $(uname) == *Linux* ]]; then
    echo "Linux"
  elif [[ $(uname) == *Darwin* ]]; then
    echo "OSX"
  else
    echo "Unknown"
  fi
}

##############################################################
# Enviroment variables
##############################################################

# Used throughout this script.
export OS=$(os)

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export HISTCONTROL=ignoredups
export SAVEHIST=10000

export EDITOR=vim
export LSCOLORS=exFxcxdxAxexbxHxGxcxBx

# So that vim in terminal mode is beautiful with solarized colorscheme.
export TERM="xterm-256color"

# Prefer locally installed binaries.
export PATH=/usr/local/bin:$PATH

##############################################################
# tmux management
##############################################################
source ~/.zsh/tmux.zsh

##############################################################
# Prompt
##############################################################
source ~/.zsh/prompt.zsh

##############################################################
# History
##############################################################

# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history

##############################################################
# Aliases
##############################################################

if [ "$OS" = "Linux" ]; then
  eval `dircolors ~/.dir_colors`
  alias ls='ls -FGph --color=auto'
elif [ "$OS" = "OSX" ]; then
  which gdircolors &>/dev/null
  if [[ $? -eq 0 ]]; then
    eval `gdircolors ~/.dir_colors`
    alias ls='gls -FGph --color=auto'
  else
    echo "gdircolors not found in path. " \
      "Probably not installed? Try installing with homebrew:" \
      "brew install coreutils"
  fi
fi

alias vimrc='$EDITOR ~/.vimrc'
alias zshrc='$EDITOR ~/.zshrc && source ~/.zshrc'

##############################################################
# Work specific
##############################################################

if [ -e ~/workdotfiles/zshrc ]; then
  source ~/workdotfiles/zshrc
fi
