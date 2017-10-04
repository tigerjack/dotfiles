#
# ~/.bash_profile
# Sourced after /etc/profile for interactive login shell
#

# Activate block num at login
#setleds -D +num

# Set user directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Source bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc
