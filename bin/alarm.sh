#!/bin/sh

sleep $@
notify-send -t 3000 -u critical -i "/mnt/internal/Data/PersonalFolder/Pictures/NotShotwelled/Images/Icons/alarm.png" "Alarm! Time expired $@"
mpv /mnt/internal/Data/PersonalFolder/Music/Alerts/MailAlert/alarm.wav & 
