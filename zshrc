########################
# Enviroment variables
########################

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export HISTCONTROL=ignoredups
export SAVEHIST=10000

export EDITOR=vim
export LSCOLORS=exFxcxdxAxexbxHxGxcxBx

########################
# Prompt
########################

# Vim Mode Prompt.
source ~/.zsh/prompt.zsh

########################
# History
########################

# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history

########################
# Aliases
########################

alias ls='ls -AFGph'
alias vimrc='$EDITOR ~/.vimrc'
alias zshrc='$EDITOR ~/.zshrc && source ~/.zshrc'
