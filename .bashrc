# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source personal file
. ~/.bash_aliases
. ~/.bash_personal
. ~/.bash_bindings
. ~/.bash_functions
. ~/.bash_git_prompt.sh

# To search in the official repository when command is not found
. /usr/share/doc/pkgfile/command-not-found.bash
