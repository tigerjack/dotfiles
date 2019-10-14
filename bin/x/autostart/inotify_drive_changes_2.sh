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
var=$(inotifywatch -r -e modify -e delete -e create -e move "$(xdg-user-dir PUBLICSHARE)/drive/"* | tee -a "$MDIR_LOGS/inotify/drive/log2" "$MDIR_LOGS/inotify/drive/log4")
if [ -n "$var" ]; then
    task add project:drive tags:"$HOSTNAME,to_push" -- drive sync
    ID=$(task +LATEST ids)

    note=$(echo "$var" | awk '{print $5}' | grep -v filename)
    task "$ID" annotate "$note"
    task sync

    # echo "$note" >> "$MDIR_LOGS/inotify/drive/log3"
    # # Add id after
    # echo "task_id=$ID" >> "$MDIR_LOGS/inotify/drive/log3"
fi
