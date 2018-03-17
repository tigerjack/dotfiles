#!/bin/bash
while [ "$select" != "Reboot" -a "$select" != "Shutdown" -a "$select" != "Exit" ]; do
    select=$(echo -e 'Reboot\nShutdown\nExit' | dmenu -nb '#151515' -nf '#999999' -sb '#f00060' -sf '#000000' -fn '-*-*-medium-r-normal-*-*-*-*-*-*-100-*-*' -i -p "Select your choice")
    [ -z "$select" ] && exit 0
done

if [ "$select" = "Reboot" ]; then
    systemctl reboot
else if [ "$select" = "Shutdown" ]; then
         systemctl poweroff
     else if [ "$select" = "Exit" ]; then
              i3-msg exit
          fi
     fi
fi

