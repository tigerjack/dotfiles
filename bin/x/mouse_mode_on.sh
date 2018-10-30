#!/bin/bash - 
#===============================================================================
#
#          FILE: mouse_mode_on.sh
# 
#         USAGE: ./mouse_mode_on.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 28/10/2018 22:42
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
pcmanfm-qt --desktop &
mate-panel &
