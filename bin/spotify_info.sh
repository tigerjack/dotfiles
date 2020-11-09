#!/bin/bash - 
#===============================================================================
#
#          FILE: spotify_info.sh
# 
#         USAGE: ./spotify_info.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 11/08/2020 12:24
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
notify-send -t 2000 -u low "spotify" "$(sp current)"

