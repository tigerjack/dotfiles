#!/bin/bash - 
#===============================================================================
#
#          FILE: myclipman.sh
# 
#         USAGE: ./myclipman.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 02/14/2021 11:35
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# run this in sway as:
# exec wl-paste -t text --watch myclipman

app_id=$( swaymsg -t get_tree | jq -r '.. | select(.type?) | select(.focused==true)|.app_id'  )
if [[ $app_id != "org.keepassxc.KeePassXC" ]]; then
    clipman store --no-persist
fi

