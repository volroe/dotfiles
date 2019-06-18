# some more ls aliases
alias ll='ls -haltr'
alias la='ls -A'
alias l='ls -CF'
alias matlab='/usr/local/MATLAB/R2019a/bin/matlab'

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

alias cd='pushd'
alias back='popd'
alias flip='pushd_builtin'
