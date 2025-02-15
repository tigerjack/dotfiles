#!/bin/bash - 
#===============================================================================
#
#          FILE: colorpick.sh
# 
#         USAGE: ./colorpick.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 10/03/2021 15:56
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
# Taken from https://www.reddit.com/r/wayland/comments/fbhiez/color_picker_eyedropper_on_wayland/
grim -g "$(slurp -p)" - -t png -o | convert png:- -format '%[pixel:s]\n' info:- | awk -F '[(,)]' '{printf("#%02x%02x%02x\n",$2,$3,$4)}'
