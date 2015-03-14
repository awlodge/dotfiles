# sshlog.sh - Use script to log SSH sessions.
LOG_DIR=$HOME/typescripts

if [ -z $1 ]
then
  ssh
  exit $?
fi

hostname=$(echo $1 | cut -d @ -f 2)

timestamp=$(date --iso-8601=seconds)
logfile="$LOG_DIR/$hostname-${timestamp}.log"

script -qc "ssh $@" $logfile
