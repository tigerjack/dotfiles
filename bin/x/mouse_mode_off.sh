#!/bin/bash - 
#===============================================================================
#
#          FILE: mouse_mode_off.sh
# 
#         USAGE: ./mouse_mode_off.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 28/10/2018 22:45
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
pcmanfm-qt --desktop-off
killall mate-panel

