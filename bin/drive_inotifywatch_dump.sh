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
script="inotify_drive_changes_2"
log="$MDIR_LOGS/startx/$script.log$DISPLAY"
{
    echo "Dump requested, $(date -Iseconds)"
    pkill -f "bash.*$script"
    pkill -f "inotifywatch.*delete.*drive"
    echo "Started again, $(date -Iseconds)" 
} >> "$log"
"$HOME/bin/x/autostart/$script.sh" >> "$log" 2>&1 &
