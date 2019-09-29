#!/bin/bash - 
#===============================================================================
#
#          FILE: drive_inotifywatch_dump.sh
# 
#         USAGE: ./drive_inotifywatch_dump.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 09/29/2019 13:00
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
# Killing the process effectively dumps the statistics
echo "Dump requested, $(date -Iseconds)" >> "$MDIR_LOGS/startx/periodic_drive_changes_notifier_2.log$DISPLAY"
pkill -f drive_changes_notifier_2
echo "Started again, $(date -Iseconds)" >> "$MDIR_LOGS/startx/periodic_drive_changes_notifier_2.log$DISPLAY"
"$HOME/bin/x/autostart/periodic_drive_changes_notifier_2.sh" >> "$MDIR_LOGS/startx/periodic_drive_changes_notifier_2.log$DISPLAY" 2>&1 &
