# If not running interactively, return
[[ -o interactive ]] || return

file=".bash.d/bash_aliases"
[[ -f "$file" ]] && source "$file"

# Load all scripts from ~/.zsh.d/
for file in ~/.zsh.d/*; do
    [[ -f "$file" ]] && source "$file"
done
unset file
for file in ~/.shell_commons.d/*; do
    [[ -f "$file" ]] && source "$file"
done
unset file

## Load all completion scripts
# for file in ~/.bash_completion.d/*; do
#     [[ -f "$file" ]] && source "$file"
# done
# unset file

# Enable command auto-completion
autoload -Uz compinit && compinit

# Kitty shell integration
[[ -n "$KITTY_INSTALLATION_DIR" && -f "$KITTY_INSTALLATION_DIR/shell-integration/zsh/kitty.zsh" ]] && source "$KITTY_INSTALLATION_DIR/shell-integration/zsh/kitty.zsh"



autoload -U compinit && compinit

