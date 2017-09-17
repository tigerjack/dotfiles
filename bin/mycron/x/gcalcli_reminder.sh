#!/usr/bin/bash

if [ -x /usr/bin/gcalcli ]; then
  while true; do
     /usr/bin/gcalcli --configFolder='/home/tigerjack/.config/gcalcli/' remind 360 'notify-send -u "critical" %s'
    sleep 21660 # 360 min, as above
  done &
fi
