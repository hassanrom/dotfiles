#!/bin/bash

# Change default shell to zsh.
if [[ ! $SHELL =~ "zsh" ]]; then
  chsh -s `which zsh`
fi

function backup_if_exist() {
  local f="$1"
  if [[ -e "$f" ]]; then
    rm -f -r "$f.backup"
    mv "$f" "$f.backup"
  fi
}

# Install zsh configuration.
backup_if_exist ~/.zshrc && ln -s dotfiles/zshrc ~/.zshrc
backup_if_exist ~/.zshenv && ln -s dotfiles/zshenv ~/.zshenv
backup_if_exist ~/.zsh && ln -s dotfiles/zsh ~/.zsh

# Install vim configuration.
backup_if_exist ~/.vimrc && ln -s dotfiles/vimrc ~/.vimrc
backup_if_exist ~/.vim && ln -s dotfiles/vim ~/.vim

# Install dir_colors.
backup_if_exist ~/.dir_colors && \
  ln -s dotfiles/dircolors/dircolors.ansi-dark ~/.dir_colors

# Install readline inputrc.
backup_if_exist ~/.inputrc && ln -s dotfiles/inputrc ~/.inputrc

# Install tmux configuration.
backup_if_exist ~/.tmux.conf && ln -s dotfiles/tmux/tmux.conf ~/.tmux.conf
rm -f ~/bin/tmux_start.zsh && \
  ln -s dotfiles/tmux/tmux_start.zsh ~/bin/tmux_start.zsh

# Install git configuration.
backup_if_exist ~/.gitconfig && ln -s dotfiles/gitconfig ~/.gitconfig
if [[ ! -e ~/.gitconfig_user ]]; then
  read -p "Edit user section of your gitconfig file?" -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    cp dotfiles/gitconfig_user ~/.gitconfig_user
    vim ~/.gitconfig_user
  fi
fi

# Install config directory. Contains configuration for apps such as sakura &
# htop.
backup_if_exist ~/.config && ln -s dotfiles/config ~/.config

# Linux specific environment when X is installed.
if [[ $(uname) == *Linux* ]]; then
  # X configurations.
  backup_if_exist ~/.xinitrc && ln -s dotfiles/xinitrc ~/.xinitrc
  backup_if_exist ~/.Xmodmap && ln -s dotfiles/Xmodmap ~/.Xmodmap
  backup_if_exist ~/.xsessionrc && ln -s dotfiles/xsessionrc ~/.xsessionrc

  # i3
  if [[ ! -z $(command -v i3) ]]; then
    backup_if_exist ~/.i3 && ln -s dotfiles/i3 ~/.i3
    backup_if_exist ~/.i3status.conf && \
      ln -s dotfiles/i3status.conf ~/.i3status.conf

    # Link i3 scripts needed referenced in i3's config.
    mkdir -p ~/bin
    rm -f ~/bin/i3exit && ln -s ~/dotfiles/i3/i3exit ~/bin/i3exit
    rm -f ~/bin/i3mark && ln -s ~/dotfiles/i3/i3mark ~/bin/i3mark
    rm -f ~/bin/i3goto && ln -s ~/dotfiles/i3/i3goto ~/bin/i3goto
    rm -f ~/bin/i3-sensible-terminal && \
      ln -s ~/dotfiles/i3/i3-sensible-terminal ~/bin/i3-sensible-terminal
  else
    echo "Skipped installing i3 dotfiles."
  fi

  # Fonts
  if [[ ! -z $(command -v fc-cache) ]]; then
    backup_if_exist ~/.fonts && ln -s dotfiles/fonts ~/.fonts
    fc-cache -fv
  else
    echo "Skipped installing fonts."
  fi

  # Gnome apps such as gnome-terminal
  if [[ ! -z $(command -v gnome-terminal) ]]; then
    backup_if_exist ~/.gconf && ln -s dotfiles/gconf ~/.gconf
  else
    echo "Skipped installing gnome apps."
  fi

  # Fluxbox
  if [[ ! -z $(command -v fluxbox) ]]; then
    backup_if_exist ~/.fluxbox && ln -s dotfiles/fluxbox ~/.fluxbox
  else
    echo "Skipped installing fluxbox dotfiles."
  fi
fi
