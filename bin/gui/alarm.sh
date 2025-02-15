#!/bin/sh

sleep "$1"
notify-send -t 3000 -u critical -i "$(xdg-user-dir PICTURES)/NotShotwelled/Images/Icons/alarm.png" "Alarm! Time expired $1"
mpv "$(xdg-user-dir MUSIC)/Alerts/MailAlert/alarm.wav" & 
