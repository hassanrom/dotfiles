##############################################################
# Start tmux if we came from ssh.
#
# Shamelessly copied from
# http://william.shallum.net/random-notes/automatically-start-tmux-on-ssh-login
##############################################################

if [[ $PS1 != "" && ${STARTED_TMUX:-x} = x && ${SSH_TTY:-x} != x ]]; then
  export STARTED_TMUX=1
  sleep 1
  ((tmux has-session && tmux attach-session) || \
    (tmux new-session -s remote)) && exit 0
fi
