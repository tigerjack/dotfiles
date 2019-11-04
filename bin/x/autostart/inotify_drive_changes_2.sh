#!/bin/bash - 
#===============================================================================
#
#          FILE: periodic_drive_changes_notifier_2.sh
# 
#         USAGE: ./periodic_drive_changes_notifier_2.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 09/29/2019 12:40
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
{
    echo "-----------"
    date -Iseconds
    echo "-----------"
} >> "$MDIR_LOGS/inotify/drive/log2"
var=$(inotifywatch -r -e modify -e delete -e create -e move "$(xdg-user-dir PUBLICSHARE)/drive/"* | tee -a "$MDIR_LOGS/inotify/drive/log2")
if [ -n "$var" ]; then
    drive_dir="$(xdg-user-dir PUBLICSHARE)/drive/"

    task add project:drive tags:"$HOSTNAME""_to_push" -- drive sync
    ID=$(task +LATEST ids)

    note=$(echo "$var" | awk '{ 
        for(i=1;i<=NF;i++){
            if($i~/^\/mnt/){
		sub("'"$drive_dir"'","",$i);
		print $i
            }}}')
    task "$ID" annotate "$note"
    task sync
fi
