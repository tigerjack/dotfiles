#!/bin/bash - 
#===============================================================================
#
#          FILE: pick_gtk3_settings.sh
# 
#         USAGE: ./pick_gtk3_settings.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 11/04/2020 12:46
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
# usage: import-gsettings <gsettings key>:<settings.ini key> <gsettings key>:<settings.ini key> ...

expressions=""
for pair in "$@"; do
    IFS=:; set -- $pair
    expressions="$expressions -e 's:^$2=(.*)$:gsettings set org.gnome.desktop.interface $1 \1:e'"
done
IFS=
eval exec sed -E $expressions "${XDG_CONFIG_HOME:-$HOME/.config}"/gtk-3.0/settings.ini >/dev/null

