# Function for preventing nested ranger instances
function ranger {
    if [[ -z "$RANGER_LEVEL" ]]; then
        PYTHONOPTIMIZE=1 TERM=xterm-kitty /usr/bin/ranger "$@"
    else
        exit
    fi
}

# Emacs wrapper to force truecolor
function emacs {
    if [[ -f "$HOME/.terminfo/x/xterm-direct" || -f "/usr/share/terminfo/x/xterm-direct" ]] && [[ "$COLORTERM" == "truecolor" ]]; then
        TERM=xterm-direct command emacs "$@"
    else
        command emacs "$@"
    fi
}

function emacsclient {
    if [[ -f "$HOME/.terminfo/x/xterm-direct" || -f "/usr/share/terminfo/x/xterm-direct" ]] && [[ "$COLORTERM" == "truecolor" ]]; then
        TERM=xterm-direct command emacsclient "$@"
    else
        command emacsclient "$@"
    fi
}

testregex() {
  [ "$#" -eq 1 ] || return 1
  while IFS= read -r line; do
    printf '%s\n' "$1" | grep -Eoe "$line"
  done
}
# Example 1: Using a regex pattern from input
# echo "hello|world" | testregex "hello world"

# Function for always using one (and only one) vim server, even when not
# using gvim.
# Unfortunately, though, this works using X servers
# If you really want a new vim session, simply do not pass any
# argument to this function.
function vims {
  vim_orig=$(command -v vim)
  if [ -z "$vim_orig" ]; then
    echo "$SHELL: vim: command not found"
    return 127
  fi
  # If there is already a vimserver, use it
  if $vim_orig --serverlist | grep -q VIM; then
    if [ $# -eq 0 ]; then
      # unless no args were given
      $vim_orig
    else
      $vim_orig --remote "$@"
    fi
  else
    $vim_orig --servername vim "$@"
  fi
}
