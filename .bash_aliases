shopt -s expand_aliases
#some more ls aliases
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
# to edit sensitive content
alias vimprivate='vim -u NONE -c "setlocal history=0 nobackup nomodeline noshelltemp noswapfile noundofile nowritebackup secure viminfo=\"\""'
# copy using rsync
alias c='rsync -avP'

bartfiles () { names=( "$2"*.hdr ); COMPREPLY=( "${names[@]%.hdr}" ); }
complete -F bartfiles bart
complete -F bartfiles dims
complete -F bartfiles view

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
alias b='popd > /dev/null'
alias flip='pushd_builtin'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'

../..() { cd ../../; }
../../..() { cd ../../../; }

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

recent () {
    awk -F"file://|\" " '/file:\/\// {print $2}' ~/.local/share/recently-used.xbel | sed -e 's/%20/ /g' | fzf -m --tac --no-sort | while read -r item; do printf '%q ' "$item"; done
    echo
}

or () {
    file="$(awk -F"file://|\" " '/file:\/\// {print $2}' ~/.local/share/recently-used.xbel | sed -e 's/%20/ /g' | fzf -m --tac --no-sort 
    )" &&
    echo "$file" | \
    while IFS= read -r line; do
        echo "opening $file" &&
        xdg-open "$line"
    done
}

# enable pdf text search (first page) with fzf
p () {
    dir=${1:-"/home/vroeloffs/neoscan/papers /home/vroeloffs/code/projects /home/vroeloffs/sharepoint/0_General/0_2_Dokumente/JabRefBib /home/vroeloffs/sharepoint/0_General/0_2_Dokumente/MR-Bibliothek"}
    open=${2:-"xdg-open"}   # this will open pdf file withthe default PDF viewer on KDE, xfce, LXDE and perhaps on other desktops.
    find $dir -type f -name "*.pdf" \
    | fast-p \
    | fzf --read0 --reverse -e -d $'\t'  \
        --preview-window down:80% --preview '
            v=$(echo {q} | tr " " "|");
            echo -e {1}"\n"{2} | grep -E "^|$v" -i --color=always;
        ' \
            | cut -z -f 1 -d $'\t' | tr -d '\n' | tee >(xargs -r --null $open > /dev/null 2> /dev/null) 
    echo
}

# enable interactive searching of my meas protocols
# pp () {
#     dir=${1:-"/home/vroeloffs/neoscan/data"}
#     open=${2:-"$EDITOR"}   
#     find $dir -type f -name "prot.md" \
#     | fast-p \
#     | fzf --read0 --reverse -e -d $'\t'  \
#         --preview-window down:80% --preview '
#             v=$(echo {q} | tr " " "|");
#             echo -e {1}"\n"{2} | grep -E "^|$v" -i --color=always;
#         ' \
#             | cut -z -f 1 -d $'\t' | tr -d '\n' | tee >(xargs -r --null $open > /dev/null 2> /dev/null) 
#     echo
# }

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

latest-file-in-directory () {
    find "${@:-.}" -maxdepth 1 -type f -printf '%T@.%p\0' | \
            sort -znr -t. -k1,2 | \
            while IFS= read -r -d '' -r record ; do
                    printf '%s' "$record" | cut -d. -f3-
                    break
            done
}

makescriptfromhistory () {

    scriptname="$1"

    history | fzf -m --tac | cut -c 8- > $scriptname
    chmod u+x $scriptname
    sed -i '1 i\#! /bin/bash' $scriptname
}

v() {
  local files
  files=$(grep '^>' ~/.viminfo | cut -c3- |
          while read line; do
            [ -f "${line/\~/$HOME}" ] && echo "$line"
          done | fzf-tmux -d -m -q "$*" -1) && vim ${files//\~/$HOME}
}

rs() {
    for var in "$@"
    do
        printf "%s" "${var%.*} "
    done
}

rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
                --multi \
				--bind "change:reload:$RG_PREFIX {q}" \
				--bind "F2:toggle-preview" \
				--preview-window="50%:wrap"
	)" &&
    echo "$file" | \
    while IFS= read -r line; do
        echo "opening $file" &&
        xdg-open "$line"
    done
}

rga-fzf-online() {
	RG_PREFIX="rga --files-with-matches"
	local file
    local RELATIVEFILE
    local FULLONLINENAME
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
                --multi \
				--bind "change:reload:$RG_PREFIX {q}" \
				--bind "F2:toggle-preview" \
				--preview-window="50%:wrap"
	)" &&
    echo "$file" | \
    while IFS= read -r line; do
        ABSOLUTEPATH="$(realpath "$line")"
        case $ABSOLUTEPATH/ in
            /home/vroeloffs/sharepoint/*) 
                RELATIVEFILE="$(realpath --relative-to="/home/vroeloffs/sharepoint/" "$line")" &&
                FULLONLINENAME="https://neoscansolutions.sharepoint.com/:t:/r/sites/NeoscanSolutionsGmbH/Freigegebene%20Dokumente/${RELATIVEFILE}?csf=1&web=1&e=W0VqTk" &&
                echo "opening $file online" &&
                /usr/bin/firefox --new-tab "$FULLONLINENAME";;
        esac
    done
}
# open file online with Office365
oo() {
    for file in "$@"; do
        echo "$file" | \
        while IFS= read -r line; do
            ABSOLUTEPATH="$(realpath "$line")"
            case $ABSOLUTEPATH/ in
                /home/vroeloffs/sharepoint/*) 
                    RELATIVEFILE="$(realpath --relative-to="/home/vroeloffs/sharepoint/" "$line")" &&
                    FULLONLINENAME="https://neoscansolutions.sharepoint.com/:t:/r/sites/NeoscanSolutionsGmbH/Freigegebene%20Dokumente/${RELATIVEFILE}?csf=1&web=1&e=W0VqTk" &&
                    echo "opening $file online" &&
                    /usr/bin/firefox --new-tab "$FULLONLINENAME";;
            esac
        done
    done
}

alias plantuml='java -jar /usr/local/bin/plantuml-1.2023.10.jar'
