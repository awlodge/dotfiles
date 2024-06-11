# Some common aliases

# useful ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# git aliases.
alias gti='git'
alias g="git"

# Generic function to allow setting terminal titles
function title()
{
    if [[ $# == 0 ]]; then
      title_string="`whoami`"
    else
      title_string="$*"
    fi
    # change the title of the current window or tab
    echo -ne "\033]0;$title_string\007"
    # if running in tmux set the tmux window name
    if [ -n "$TMUX" ]; then
      if [[ $# == 0 ]]; then
        tmux set-window-option automatic-rename "on" 1>/dev/null
      else
        tmux rename-window "$*"
      fi
    fi
}

# Wrap ssh calls to set terminal title as we go, and reset it on the way back
function ssh()
{
    if ! [[ $# == 0 || -z $TMUX ]]; then
      title ${@: -1}
    fi
    /usr/bin/ssh $@
    # revert the window title after the ssh command
    title
}

# Wrap vim calls to set terminal title as we go, and reset it on the way back
function vim()
{
  if ! [[ $# == 0 || -z $TMUX ]]; then
    title "vim $(basename ${@: -1})"
  fi
  /usr/bin/vim $@
  title
}
