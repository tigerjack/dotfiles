#
# ~/.bash_profile
# Sourced after /etc/profile for interactive login shell
#

# Activate block num at login
#setleds -D +num

# Source global environment variables (shared b/w GUI and cli applications)
source ~/.env_global
source ~/.shell_commons.d/exports
source ~/.bash.d/bash_exports

# Source bashrc
# [[ -f ~/.bashrc ]] && . ~/.bashrc

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
