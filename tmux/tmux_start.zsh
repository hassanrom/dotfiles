#!/usr/bin/zsh

# Shamelessly copied from
# http://www.huyng.com/posts/productivity-boost-with-tmux-iterm2-workspaces/

# abort if we're already inside a TMUX session
[[ "$TMUX" == "" ]] || exit 0

# startup a "default" session if none currently exists
tmux has-session -t _default || tmux new-session -s _default -d

# present menu for user to choose which workspace to open
PS3="Please choose your session: "
session_options=($(tmux list-sessions -F "#S") "NEW SESSION" "SHELL")
echo "Available sessions"
echo "------------------"
echo " "
select opt in "${session_options[@]}"
do
  case $opt in
    "NEW SESSION")
      read "SESSION_NAME?Enter new session name: "
      tmux new -s "$SESSION_NAME"
      break
      ;;
    "SHELL")
      zsh --login
      break;;
    *)
      tmux attach-session -t $opt
      break
      ;;
  esac
done
