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

