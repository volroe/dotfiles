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
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'


# some more ls aliases
alias ll='ls -haltr'
alias la='ls -A'
alias l='ls -CF'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

bind '"\e[1;5D" backward-word'
bind '"\e[1;5C" forward-word'

stty werase undef
bind '"\C-H": backward-kill-word'
bind '"\e[3;5~": kill-word'

# enable pdf text search (first page) with fzf
p () {
    dir=${1:-"/home/vroeloffs/umg/papers/"}
    open=${2:-"xdg-open"}   # this will open pdf file withthe default PDF viewer on KDE, xfce, LXDE and perhaps on other desktops.
    
    ag $dir -U -g ".pdf$" \
    | fast-p \
    | fzf --read0 --reverse -e -d $'\t'  \
        --preview-window down:80% --preview '
            v=$(echo {q} | tr " " "|");
            echo -e {1}"\n"{2} | grep -E "^|$v" -i --color=always;
        ' \
            | cut -z -f 1 -d $'\t' | tr -d '\n' | tee >(xargs -r --null $open > /dev/null 2> /dev/null) 
    echo
}

mcd ()
{
    mkdir -p -- "$1" &&
      cd "$1"
}

alias serve="python3 -m http.server > /dev/null 2>&1"

# Usage: extract <file>
# Description: extracts archived files (maybe)
extract () {
    if [ -f $1 ]; then
            case $1 in
            *.tar.bz2)  tar -jxvf $1        ;;
            *.tar.gz)   tar -zxvf $1        ;;
            *.bz2)      bzip2 -d $1         ;;
            *.gz)       gunzip -d $1        ;;
            *.tar)      tar -xvf $1         ;;
            *.tgz)      tar -zxvf $1        ;;
            *.zip)      unzip $1            ;;
            *.Z)        uncompress $1       ;;
            *.rar)      unrar x $1            ;;
            *)          echo "'$1' Error. Please go away" ;;
            esac
            else
            echo "'$1' is not a valid file"
  fi
}
