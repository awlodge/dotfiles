# Aliases and env vars for common paths.
CODEBASE="$HOME/code/"
WORKSPACE="$HOME/workspace/"

# Always able to CD into directories in here.
export CDPATH=".:$HOME:$CODEBASE:$WORKSPACE"
export PYTHONPATH=$PYTHONPATH:$HOME
export PATH=$PATH:$HOME/.dotnet

alias cdc="cd $CODEBASE"
alias cdw="cd $WORKSPACE"

