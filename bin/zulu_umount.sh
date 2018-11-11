#!/bin/bash - 
#===============================================================================
#
#          FILE: zulu_umount.sh
# 
#         USAGE: ./zulu_umount.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 09/11/2018 11:34
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

u=`zuluCrypt-cli -L`

while read -r line; do
    if [ -z "$line" ]
    then
	a=($line) #bogus line
    else
	a=($line)
        echo "Trying to close $a"
	zuluCrypt-cli -q -d "$a"
    fi
done <<< "$u"
