# Set the GPG TTY
export GPG_TTY=$(tty)

# Run gpg-agent to cache GPG credentials
if [ -x "$(pgrep gpg-agent)" ]; then
  echo "Starting gpg-agent"
  eval $(gpg-agent --daemon)
fi
