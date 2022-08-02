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
if pgrep -x "spotifyd" >/dev/null; then
    process=spotifyd
elif pgrep -x "spotify" >/dev/null; then
    process=spotify
else
    echo "No spotify-related player found"
    exit 1
fi
echo "found player $process"
    
while IFS= read -r line; do
    # echo "$line"
    field=$(echo "$line" | tr -s ' ' | cut -d ' ' -f 2)
    if [[ $field == *"artist" ]]; then
	# echo "EUREKART"
	artist=$(echo "${line#*artist}" | tr -s ' ') 
    elif [[ $field == *"title" ]]; then
	# echo "EUREKTIT"
	title=$(echo "${line#*title}" | tr -s ' ') 
    fi
done < <(playerctl -p $process metadata)
echo "$artist"
echo "$title"
notify-send -t 3000 -u low "$process" "$artist-$title"
