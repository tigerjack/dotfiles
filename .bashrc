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

# To search in the official repository when command is not found (Arch Linux specific config)
# Too slow
# . /usr/share/doc/pkgfile/command-not-found.bash

#if [[ $TERM == xterm-termite ]]; then
#. /etc/profile.d/vte.sh
#__vte_prompt_command
#fi
