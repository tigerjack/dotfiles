#!/bin/bash - 
#===============================================================================
#
#          FILE: drive_sync.sh
# 
#         USAGE: ./drive_sync.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 10/13/2019 13:41
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
file="$MDIR_LOGS/inotify/drive/log3"
while read -r line; do 
    if [[ ! "$line" == *"task_id"* ]]; then 
	drive push -no-prompt "$line"
    else
	id=cut -d "=" -f 2 <<< "$line"
	task "$id" modify +pushed
    fi; 
done < "$file"
echo "" > "$file" 

