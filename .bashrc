#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# Source personal file
. ~/.bash_aliases
. ~/.bash_personal
. ~/.bash_bindings

# To search in the official repository when command is not found
. /usr/share/doc/pkgfile/command-not-found.bash
