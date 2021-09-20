#!/bin/bash - 
#===============================================================================
#
#          FILE: sway_launch.sh
# 
#         USAGE: ./sway_launch.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 11/04/2020 12:25
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
source ~/.env_global
source ~/.env_gui
# exec /usr/bin/sway
# D-Bus session bus is started automatically, but if you want to have multiple simultaneous sessions for the same user on the same machine, you may want to create own bus for each session and therefore explicitly invoke dbus-run-session
# exec dbus-run-session /usr/bin/sway
exec dbus-run-session /usr/bin/sway -d 2>~/sway.log

