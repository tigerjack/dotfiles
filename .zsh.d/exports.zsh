# export KITTY_SHELL_INTEGRATION="enabled"
# [ -x /usr/bin/lesspipe.sh ] && lesspipe.sh | source /dev/stdin   # (zsh)
# export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zshcompdump-$ZSH_VERSION(#qN.mh+24)"
export ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zshcompdump-$ZSH_VERSION"

# History settings
HISTSIZE=10000000
SAVEHIST=10000000
export HISTFILE=~/.zsh_eternal_history
# export WORDCHARS=${WORDCHARS//-}
