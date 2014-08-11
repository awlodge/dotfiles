#!/bin/bash
# tmuxping
#
# Repeatedly ping the given host, updating the color of the tmux window with
# the outcome.
usage="Usage: $0 [-b] HOSTNAME WINDOWNAME"
read -d '' helpstr <<- EOF

$usage

Repeatedly ping the given host HOSTNAME, updating the color of the tmux window WINDOWNAME with the outcome.

Parameters:
  -b Exit the script after the first successful ping is completed.
  -h Display this help message.

EOF

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
      echo $usage
      exit 1
      ;;
  esac
done
shift $((OPTIND-1))

pingwindowname=$2

do_tmping()
{
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
}

# This is a slight hack to get around a bug where tmux output cannot be
# /dev/nulled.
do_tmping $1 | grep -v "set option: window-status-bg"

