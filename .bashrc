# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s dotglob
for file in ~/.bash.d/*; do
    if [ -f "$file" ]; then
	source "$file"
    fi
done
unset file
for file in ~/.bash_completion.d/*; do
    if [ -f "$file" ]; then
	source "$file"
    fi
done
unset file
shopt -u dotglob
# to make complete all aliases
complete -F _complete_alias "${!BASH_ALIASES[@]}"
# To source kitty completion
source <(kitty + complete setup bash)

# To search in the official repository when command is not found (Arch Linux specific config)
# Too slow
# . /usr/share/doc/pkgfile/command-not-found.bash

#if [[ $TERM == xterm-termite ]]; then
#. /etc/profile.d/vte.sh
#__vte_prompt_command
#fi


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
