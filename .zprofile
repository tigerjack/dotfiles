# Source global environment variables (shared b/w GUI and cli applications)
. ~/.env_global

source ~/.shell_commons.d/exports
source ~/.zsh.d/exports.zsh

# In zsh, you shouldn't source .zshrc from .zprofile

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
