#!/bin/bash
battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`

# 
STATUS=$(cat /sys/class/power_supply/BAT0/status)
if [ $battery_level -le 20 ] && [ $STATUS == "Discharging" ]
then
    /usr/bin/twmnc -t "Battery low" -c "Bat ${battery_level}%!"
fi
