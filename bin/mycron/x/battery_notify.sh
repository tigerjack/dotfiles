#!/bin/bash
#battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`

# 
#STATUS=$(cat /sys/class/power_supply/BAT0/status)
#if [ $battery_level -le 20 ] && [ $STATUS == "Discharging" ]
#then
#    notify-send -u "critical" -i "battery-low" -c "device" "Bat ${battery_level}%!"
#fi


HIGH_BATTERY="40"
LOW_BATTERY="20"
CRITICAL_BATTERY="5"
#sleep time for script
SLEEP_HIGH="900"
SLEEP_NORMAL="600"
SLEEP_LOW="300"
SLEEP_CRITICAL="90"
BAT="BAT0"
ACTION_COUNTDOWN="30"
ACTION_CRITICAL="systemctl hibernate"


#MAX_BATTERY=$(cat /proc/acpi/battery/BAT0/info | grep 'last full' | awk '{print$4}')
#LOW_BATTERY=$(($LOW_BATTERY*$MAX_BATTERY/100))
#CRITICAL_BATTERY=$(($CRITICAL_BATTERY*$MAX_BATTERY/100))

while [ true ]; do
	CURRENT_BATTERY_LEVEL=`acpi -b | grep -P -o '[0-9]+(?=%)'`
	CURRENT_BATTERY_STATUS=$(cat /sys/class/power_supply/"$BAT"/status)
	if [ $CURRENT_BATTERY_LEVEL -le $CRITICAL_BATTERY ]; then
		if [ "$CURRENT_BATTERY_STATUS" == "Discharging" ]; then
			echo "Boooom $CURRENT_BATTERY_LEVEL $CURRENT_BATTERY_STATUS"
			notify-send -u "critical" -i "battery-low" -c "device" "Bat critical level, going to hibernate in $ACTION_COUNTDOWN s!"
			sleep $ACTION_COUNTDOWN
			$ACTION_CRITICAL
		fi
		sleep $SLEEP_CRITICAL
	elif [ $CURRENT_BATTERY_LEVEL -le $LOW_BATTERY ]; then
		if [ "$CURRENT_BATTERY_STATUS" == "Discharging" ]; then
    			notify-send -u "critical" -i "battery-low" -c "device" "Bat ${CURRENT_BATTERY_LEVEL}%!"
		fi
		echo "$(date)"
	        echo "Accuort $CURRENT_BATTERY_LEVEL $CURRENT_BATTERY_STATUS"
		sleep $SLEEP_LOW
	elif [ $CURRENT_BATTERY_LEVEL -le $HIGH_BATTERY ]; then
		echo "$(date)"
		echo "Ttt appo' $CURRENT_BATTERY_LEVEL $CURRENT_BATTERY_STATUS"
		sleep $SLEEP_NORMAL
	else
		echo "$(date)"
	        echo "Fin e munn" $CURRENT_BATTERY_LEVEL $CURRENT_BATTERY_STATUS
		sleep $SLEEP_HIGH
	fi	
done
