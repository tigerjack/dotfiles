# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source personal file
. ~/.global_env
. ~/.bash_aliases
. ~/.bash_personal
. ~/.bash_bindings
. ~/.bash_functions

# To search in the official repository when command is not found (Arch Linux specific config)
#. /usr/share/doc/pkgfile/command-not-found.bash
