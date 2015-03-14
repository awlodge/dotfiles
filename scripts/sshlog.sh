# sshlog.sh - Use script to log SSH sessions.
if [ -z $1 ]
then
  ssh
  exit $?
fi

hostname=$(echo $1 | cut -d @ -f 2)
proclog -n $hostname ssh $@
