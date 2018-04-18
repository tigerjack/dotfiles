#!/bin/bash
while [ "$select" != "Shutdown" -a "$select" != "Reboot" -a "$select" != "Exit" ]; do
    select=$(echo -e 'Shutdown\nReboot\nExit' | dmenu -nb '#151515' -nf '#999999' -sb '#f00060' -sf '#000000' -fn '-*-*-medium-r-normal-*-*-*-*-*-*-100-*-*' -i -p "Select your choice")
    [ -z "$select" ] && exit 0
done
if [ "$select" = "Shutdown" ]; then
    systemctl poweroff
else if [ "$select" = "Reboot" ]; then
         systemctl reboot
     else if [ "$select" = "Exit" ]; then
              i3-msg exit
          fi
     fi
fi
