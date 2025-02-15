#!/bin/bash - 
#===============================================================================
#
#          FILE: xkbgroup_switch.sh
# 
#         USAGE: ./xkbgroup_switch.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 21/05/2019 21:55
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
xkbgroup set num $(echo "1 + " $(xkbgroup get num) | bc)
x="$(xkbgroup get name)"
#notify-send -t 1500 -i input-keyboard-symbolic.symbolic "Layout changed: $x"
notify-send -i input-keyboard-symbolic.symbolic "Layout changed: $x"
