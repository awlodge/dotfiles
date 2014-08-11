#!/bin/bash
# tmuxping
#
# Repeatedly ping the given host, updating the color of the tmux window with
# the outcome.

break_on_success=1

# Get options.
OPTIND=1
while getopts "bh" opt
do
  case $opt in
    b)
      break_on_success=0
      ;;
    h)
      echo "$helpstr"
      exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      echo $usage
      exit 1
      ;;
  esac
done
shift $((OPTIND-1))

pingwindowname=$2
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
    tmux set-window-option -t ":$pingwindowname" window-status-bg green
    if (( $break_on_success == 0 ))
    then
      break
    fi
  else
    if (( $currently_up != 1 ))
    then
      echo $(date): ping $1 failed
    fi
    tmux set-window-option -t ":$pingwindowname" window-status-bg red
    currently_up=1
  fi
  sleep 1
done
