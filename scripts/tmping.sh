#!/bin/bash
# tmuxping
#
# Repeatedly ping the given host, updating the color of the tmux window with
# the outcome.

pingwindowname="ping $1"

while [[ 1 ]]
do
  ping -c 1 $1
  rc=$?
  if (( $rc == 0 ))
  then
    tmux set-window-option -t ":$pingwindowname" window-status-bg green 
  else
    tmux set-window-option -t ":$pingwindowname" window-status-bg red
  fi
  sleep 1
done
