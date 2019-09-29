#!/bin/bash - 
#===============================================================================
#
#          FILE: periodic_drive_changes_notifier.sh
# 
#         USAGE: ./periodic_drive_changes_notifier.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 09/22/2019 21:16
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
#inotifywait -m -r -e modify -e delete -e create -e move "$(xdg-user-dir PUBLICSHARE)/drive/Link"*
inotifywait -m -r -e modify -e delete -e create -e move --format '%T> %w %e' --timefmt '%y-%m-%d %H:%M:%S' "$(xdg-user-dir PUBLICSHARE)/drive/Link"* -o "$MDIR_LOGS/inotify/drive/log"
