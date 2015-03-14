# tmssh.sh - ssh in new window or pane

if [[ $1 == "-h" || $1 == "-v" ]]
then
  tmlaunch_arg=$1
  shift
else
  tmlaunch_arg=""
fi

tmlaunch $tmlaunch_arg tmpingssh "$@"
