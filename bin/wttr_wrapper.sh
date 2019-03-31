#!/bin/bash - 
#===============================================================================
#
#          FILE: wttr_wrapper.sh
# 
#         USAGE: ./wttr_wrapper.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 14/03/2019 09:16
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#connection_check.sh
#online=$?
#if [ $online -eq 0 ]; then
if ! [ "$(route -n | grep -c '^0\.0\.0\.0')" -eq 0 ]; then
    x=$(curl -s http://wttr.in/Milan?format='+%m+%w' | awk '{print $1 $2 "\\u224a"}') && printf "%s""$x"
else 
    printf "\u26a0" 
fi

