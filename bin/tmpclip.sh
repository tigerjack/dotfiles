#!/bin/bash - 
#===============================================================================
#
#          FILE: tmpclip.sh
# 
#         USAGE: ./tmpclip.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 10/01/2020 11:11
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
FILE=/tmp/xclipfile
xclip -sel clip -o > "$FILE"
# To return the file name 
echo "$FILE"
