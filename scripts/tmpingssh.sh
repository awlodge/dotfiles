#!/bin/bash
# tmpingssh.sh
#
# Repeatedly ping the given host, updating the color of the tmux window with
# the outcome. When a successful ping is completed, ssh onto the host.

hostname=$(echo $1 | cut -d @ -f 2)
tmux rename-window "$hostname"

# Do one ping, to check
ping -q -c 1 -w 1 $hostname >/dev/null
pingrc=$?
if (( $pingrc == 2 ))
then
  echo No such host: $hostname
  exit 2
elif (( $pingrc == 1 ))
then
  ~/bin/tmping -b $hostname $hostname
  echo Hit any key to begin ssh session...
  read
  tmux set-window-option -t "$hostname" window-status-bg default
elif (( $pingrc != 0 ))
then
  echo Unexpected error contacting $hostname
  exit $pingrc
fi

which sshlog >/dev/null
if (( $? == 0 ))
then
  sshlog $1
else
  ssh $1
fi
