#!/bin/bash
# tmuxping
#
# Repeatedly ping the given host, updating the color of the tmux window with
# the outcome.

pingwindowname="ping $1"
currently_up=-1

while [[ 1 ]]
do
  ping -q -c 1 -w 1 $1 >/dev/null 2>&1
  rc=$?
  if (( $rc == 0 ))
  then
    if (( $currently_up != 0 ))
    then
      echo $(date): ping $1 succeeded
    fi
    currently_up=0
    tmux set-window-option -t ":$pingwindowname" window-status-bg green >/dev/null 2>&1
  else
    if (( $currently_up != 1 ))
    then
      echo $(date): ping $1 failed
    fi
    tmux set-window-option -t ":$pingwindowname" window-status-bg red >/dev/null 2>&1
    currently_up=1
  fi
  sleep 1
done
