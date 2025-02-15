#!/bin/bash - 
#===============================================================================
#
#          FILE: sway_window_switch.sh
# 
#         USAGE: ./sway_window_switch.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 08/02/2022 10:29
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
swaymsg -t get_tree |
 jq -r '.nodes[].nodes[] | if .nodes then [recurse(.nodes[])] else [] end + .floating_nodes | .[] | select(.nodes==[]) | ((.id | tostring) + " " + .name)' |
 wofi --show dmenu | {
   read -r id name
   swaymsg "[con_id=$id]" focus
}
