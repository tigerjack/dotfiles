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
echo "$(date -Iseconds)" >>  "$MDIR_LOGS/inotify/drive/log2"
echo "-----------" >> "$MDIR_LOGS/inotify/drive/log2"
inotifywatch -r -e modify -e delete -e create -e move "$(xdg-user-dir PUBLICSHARE)/drive/Link"* >> "$MDIR_LOGS/inotify/drive/log2"
