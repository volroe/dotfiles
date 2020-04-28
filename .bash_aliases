# some more ls aliases
alias ll='ls -haltr'
alias la='ls -A'
alias l='ls -CF'

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
