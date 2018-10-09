## External defined functions
. ~/bin/bash_git_prompt.sh

directory_stack=~/.gdir.txt
function gpush() {
    echo $(pwd) >> $directory_stack
    cd $1
}
function gpop() {
    [ ! -s $directory_stack ] && return
    newdir=$(sed -n '$p' $directory_stack)
    sed -i -e '$d' $directory_stack
    cd $newdir
}

## To prevent nested ranger instances
ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}

testregex() {
  [ "$#" -eq 1 ] || return 1
  while IFS= read -r line; do
    printf '%s\n' "$1" | grep -Eoe "$line"
  done
}
