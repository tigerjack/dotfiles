## External defined functions
. ~/bin/bash_git_prompt.sh
. ~/bin/bash_gpush_pop.sh
. ~/bin/bash_remote_jupyter.sh
. ~/bin/bash_complete_alias.sh
## To prevent nested ranger instances
ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        PYTHONOPTIMIZE=1 /usr/bin/ranger "$@"
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
