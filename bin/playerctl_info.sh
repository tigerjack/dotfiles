#!/bin/bash - 
#===============================================================================
#
#          FILE: playerctl_info.sh
# 
#         USAGE: ./playerctl_info.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 11/08/2020 10:58
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
artist=""
title=""
#  | tr -s ' ' | cut -d ' ' -f 2
#  mstr2=${mstr#*Artist}
while IFS= read -r line; do
    # echo "$line"
    field=$(echo "$line" | tr -s ' ' | cut -d ' ' -f 2)
    if [[ $field == *"artist" ]]; then
	echo "EUREKART"
	artist=$(echo "${line#*artist}" | tr -s ' ') 
    elif [[ $field == *"title" ]]; then
	echo "EUREKTIT"
	title=$(echo "${line#*title}" | tr -s ' ') 
    fi
done < <(playerctl -p spotifyd metadata)
echo "$artist"
echo "$title"
notify-send -t 2000 -u low "spotifyd" "$artist-$title"
