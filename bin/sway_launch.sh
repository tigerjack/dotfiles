#!/bin/bash - 
#===============================================================================
#
#          FILE: sway_launch.sh
# 
#         USAGE: ./sway_launch.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 11/04/2020 12:25
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
source .xmyenv
exec /usr/bin/sway

