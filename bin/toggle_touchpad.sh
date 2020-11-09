#!/bin/bash - 
#===============================================================================
#
#          FILE: toggle_touchpad.sh
# 
#         USAGE: ./toggle_touchpad.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 11/08/2020 16:49
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
touchpad_name="1267:12529:ELAN1206:00_04F3:30F1_Touchpad"
status=$(swaymsg -t get_inputs | grep $touchpad_name -A 6 | grep send_events | cut -d ":" -f 2 | cut -d "," -f 1)
echo "$status"
if [[ $status == *"enabled"* ]]; then
    next_status="disabled"
else
    next_status="enabled"
fi
swaymsg input "$touchpad_name" events "$next_status"
