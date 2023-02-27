#
# ~/.bash_profile
# Sourced after /etc/profile for interactive login shell
#

# Activate block num at login
#setleds -D +num

# Source global environment variables (shared b/w GUI and cli applications)
. ~/.env_global

# Source bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
