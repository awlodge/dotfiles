# tmlaunch.sh - Shortcut for creating new tmux window or pane.

USAGE="$0 [-v] [-h] [ command ]"
horizontal_split="FALSE"
vertical_split="FALSE"

while getopts "hv" opt
do
  case $opt in
    h)
      horizontal_split="TRUE"
      ;;
    v)
      vertical_split="TRUE"
      ;;
    \?)
      echo $USAGE >&2
      exit -1
      ;;
   esac
done
shift $(($OPTIND - 1))

if [[ $horizontal_split == "TRUE" && $vertical_split == "TRUE" ]]
then
  echo "Can only specify one of -h and -v" >&2
  exit -1
fi

if [[ $horizontal_split == "TRUE" ]]
then
  tm_command="split-window -v"
elif [[ $vertical_split == "TRUE" ]]
then
  tm_command="split-window -h"
else
  tm_command="new-window"
fi

sh_command="$@"
tmux $tm_command "$sh_command"
