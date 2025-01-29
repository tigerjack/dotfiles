#!/bin/bash - 
#===============================================================================
#
#          FILE: zathura_session_restore.sh
# 
#         USAGE: ./zathura_session_restore.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/10/2024 11:00
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
while read -r cmd; do
    echo "# executing $cmd"
    eval "$cmd" > /dev/null &
    disown
    sleep 0.5
done < "$XDG_CACHE_HOME/zathura/zathura_session"




