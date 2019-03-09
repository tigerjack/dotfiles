# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source personal file
# . ~/.global_env
# . ~/.bash_aliases
# . ~/.bash_personal
# . ~/.bash_bindings
# . ~/.bash_functions

shopt -s dotglob
for file in ~/.bash.d/*; do
    if [ -f "$file" ]; then
	. "$file"
    fi
done
unset file
shopt -u dotglob

# To search in the official repository when command is not found (Arch Linux specific config)
. /usr/share/doc/pkgfile/command-not-found.bash
