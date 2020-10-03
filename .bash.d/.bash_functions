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

# Function for always using one (and only one) vim server, even when not
# using gvim.
# If you really want a new vim session, simply do not pass any
# argument to this function.
function vims {
  vim_orig=$(which 2>/dev/null vim)
  if [ -z $vim_orig ]; then
    echo "$SHELL: vim: command not found"
    return 127;
  fi
  $vim_orig --serverlist | grep -q VIM
  # If there is already a vimserver, use it
  # unless no args were given
  if [ $? -eq 0 ]; then
    if [ $# -eq 0 ]; then
      $vim_orig
    else
      $vim_orig --remote "$@"
    fi
  else
    $vim_orig --servername vim "$@"
  fi
}
