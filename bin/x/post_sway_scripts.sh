#!/bin/bash - 
#===============================================================================
#
#          FILE: post_sway_scripts.sh
# 
#         USAGE: ./post_sway_scripts.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 11/04/2020 15:42
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# dex /usr/share/applications/com.github.hluk.copyq.desktop

# for file in "$HOME/.config/autostart/"{copyq,gnome-keyring-ssh}".desktop"; do
# 	name="$(basename -s .desktop "$file")"
# 	logfile="$MDIR_LOGS/sway/$name.log$DISPLAY"
# 	(/usr/bin/dex $file >"$logfile" 2>&1 & )
# done
# unset file

# for file in ~/bin/x/autostart/?*.sh; do
# 	echo "$file" >> ~/tmp/loga
# 	if [ -x "$file" ]; then
# 		#name=$(basename -s .sh $file)
# 		name="$(basename -s .sh "$file")"
# 		logfile="$MDIR_LOGS/sway/$name.log$DISPLAY"
# 		($file >"$logfile" 2>&1 & )
# 	fi
# done
# unset file

# Remove previous useless logs
declare -a arr=("$MDIR_LINUX_DATA/logs/i3/i3-sensible-terminal.log" "$MDIR_LINUX_DATA/logs/i3/i3-dmenu-desktop.log" "$MDIR_LINUX_DATA/logs/i3/rofi.log" "$MDIR_LINUX_DATA/logs/i3/xfce4-appfinder.log");
for i in "${arr[@]}";
do
    if [ -f "$i" ]; then
	rm "$i"
    fi
done
unset i
