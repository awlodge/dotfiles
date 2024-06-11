# Aliases and functions specific to WSL environments.

# Execute a command in Windows using PowerShell
function run_cmd_exe() {
  powershell.exe -Command "$@"
}

# Run the Windows "start" cmd, e.g. to open a web page in the default browser.
function start() {
  run_cmd_exe "start $@"
}

# Alias for clip.exe, to copy test to clipboard
alias cl="clip.exe"
alias clf="clip.exe <"
