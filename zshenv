# To install with homebrew: brew install zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

##############################################################
# Work specific
##############################################################
if [ -e ~/workdotfiles/zshenv ]; then
  source ~/workdotfiles/zshenv
fi
