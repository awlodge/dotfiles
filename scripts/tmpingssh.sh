#!/bin/bash
# tmpingssh.sh
#
# Repeatedly ping the given host, updating the color of the tmux window with
# the outcome. When a successful ping is completed, ssh onto the host.

hostname=$(echo $1 | cut -d @ -f 2)
tmux rename-window "$hostname"

# Do one ping, to check
ping -q -c 1 -w 1 $hostname >/dev/null
if (( $? != 0 ))
then
  ~/bin/tmping -b $hostname $hostname
  read
  tmux set-window-option -t "$hostname" window-status-bg default
fi

ssh $1
