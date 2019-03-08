#!/bin/bash - 
#===============================================================================
#
#          FILE: spawn_x_terminals_into_pwd.sh
# 
#         USAGE: ./spawn_x_terminals_into_pwd.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 08/03/2019 19:19
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
# check https://stackoverflow.com/a/2013589/2326627 or https://unix.stackexchange.com/a/122848/85082 for this syntax
n="${1:-1}"
i=1
while [ "$i" -le "$n" ]; do
    urxvt -e sh -c "cd $PWD; $SHELL" &
    i=$((i+1))
done
