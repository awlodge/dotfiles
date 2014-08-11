#!/bin/bash
# tmpingssh.sh
#
# Repeatedly ping the given host, updating the color of the tmux window with
# the outcome. When a successful ping is completed, ssh onto the host.

hostname=$(echo $1 | cut -d @ -f 2)
tmux rename-window "ping $hostname"

# Do one ping, to check
ping -q -c 1 -w 1 $hostname >/dev/null
if (( $? != 0 ))
then
  while [[ 1 ]]
  do
    ping -q -c 1 -w 1 $hostname
    rc=$?
    if (( $rc == 0 ))
    then
      tmux set-window-option -t ":ping $hostname" window-status-bg green
      read
      tmux set-window-option -t ":ping $hostname" window-status-bg default
      break
    else
      tmux set-window-option -t ":ping $hostname" window-status-bg red
    fi
    sleep 1
  done
fi

tmux rename-window -t ":ping $hostname" "$hostname"
ssh $1
