#
# ~/.bash_profile
# Sourced after /etc/profile for interactive login shell
#

# Activate block num at login
#setleds -D +num

# Source global environment variables (shared b/w GUI and cli applications)
. ~/.global_env

# Source bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc
