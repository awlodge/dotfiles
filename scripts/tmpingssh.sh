#!/bin/bash
# tmpingssh.sh
#
# Repeatedly ping the given host, updating the color of the tmux window with
# the outcome. When a successful ping is completed, ssh onto the host.

hostname=$(echo $1 | cut -d @ -f 2)
tmux rename-window "ping $hostname"

while [[ 1 ]]
do
  ping -c 1 $hostname >/dev/null 2>&1
  rc=$?
  if (( $rc == 0 ))
  then
    tmux set-window-option -t ":ping $hostname" window-status-bg green >/dev/null 2>&1
    break
  else
    tmux set-window-option -t ":ping $hostname" window-status-bg red >/dev/null 2>&1
  fi
  sleep 1
done
tmux rename-window $hostname
ssh $1
