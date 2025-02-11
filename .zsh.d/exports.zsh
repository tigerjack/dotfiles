# export KITTY_SHELL_INTEGRATION="enabled"
# [ -x /usr/bin/lesspipe.sh ] && lesspipe.sh | source /dev/stdin   # (zsh)
# export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zshcompdump-$ZSH_VERSION(#qN.mh+24)"
export ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zshcompdump-$ZSH_VERSION"

# History settings
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE=~/.zsh_eternal_history
