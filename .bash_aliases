# some more ls aliases
alias ll='ls -haltr'
alias la='ls -A'
alias l='ls -CF'

# Some tmux-related shell aliases
# Attaches tmux to the last session; creates a new session if none exists.
alias t='tmux attach || tmux new-session'
# Attaches tmux to a session (example: ta portal)
alias ta='tmux attach -t'
# Creates a new session
alias tn='tmux new-session'
# Lists all ongoing sessions
alias tl='tmux list-sessions'

pushd()
{
if [ $# -eq 0 ]; then
    DIR="${HOME}"
else
    DIR="$1"
fi

builtin pushd "${DIR}" > /dev/null
echo -n "DIRSTACK: "
dirs
}

pushd_builtin()
{
builtin pushd > /dev/null
echo -n "DIRSTACK: "
dirs
}

popd()
{
builtin popd > /dev/null
echo -n "DIRSTACK: "
dirs
}

alias cd='pushd > /dev/null'
alias back='popd > /dev/null'
alias flip='pushd_builtin'
