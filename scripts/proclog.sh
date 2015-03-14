# proclog.sh - Use script to log process output.
LOG_DIR=$HOME/typescripts

USAGE="$0 [ -n LOGPREFIX ] [ COMMAND ]"

log_head=""

while getopts "n:h" opt
do
  case $opt in
    n)
      log_head=$OPTARG
      ;;
    h)
      echo $USAGE
      exit 0
      ;;
    \?)
      echo $USAGE >&2
      exit -1
      ;;
   esac
done
shift $(($OPTIND - 1))

if [[ -n $1 ]]
then
  script_command="$@"
  if [[ -z $log_head ]]
  then
    log_head=$1
  fi
else
  script_command="bash"
  if [[ -z $log_head ]]
  then
    log_head="typescript"
  fi
fi

timestamp=$(date --iso-8601=seconds)
logfile="$LOG_DIR/$log_head-${timestamp}.log"

script -q -c "$script_command" $logfile
