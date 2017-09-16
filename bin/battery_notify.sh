#!/bin/bash
battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`

# 
STATUS=$(cat /sys/class/power_supply/BAT0/status)
if [ $battery_level -le 20 ] && [ $STATUS == "Discharging" ]
then
    notify-send -u "critical" -i "battery-low" -c "device" "Bat ${battery_level}%!"
fi
