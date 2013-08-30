#!/bin/bash

# Change default shell to zsh.
if [[ $SHELL != "/bin/zsh" ]]; then
  chsh -s /bin/zsh
fi

function backup_if_exist() {
  local f="$1"
  if [[ -e "$f" ]]; then
    rm "$f.backup"
    mv "$f" "$f.backup"
  fi
}

# Install zsh configuration.
backup_if_exist ~/.zshrc && ln -s dotfiles/zshrc ~/.zshrc
backup_if_exist ~/.zsh && ln -s dotfiles/zsh ~/.zsh

# Install vim configuration.
backup_if_exist ~/.vimrc && ln -s dotfiles/vimrc ~/.vimrc
backup_if_exist ~/.vim && ln -s dotfiles/vim ~/.vim

# Install dir_colors.
backup_if_exist ~/.dir_colors && \
  ln -s dotfiles/dircolors/dircolors.ansi-dark ~/.dir_colors

# Install tmux configuration.
backup_if_exist ~/.tmux.conf && ln -s dotfiles/tmux.conf ~/.tmux.conf

# Linux specific environment.
if [[ $(uname) == *Linux* ]]; then
  # Fluxbox
  backup_if_exist ~/.fluxbox && ln -s dotfiles/fluxbox ~/.fluxbox

  # Fonts
  backup_if_exist ~/.fonts && ln -s dotfiles/fonts ~/.fonts
  fc-cache -fv

  # Konsole
  backup_if_exist ~/.kde/share/apps/konsole && \
    mkdir -p ~/.kde/share/apps &&
    ln -s dotfiles/konsole ~/.kde/share/apps/konsole
fi
