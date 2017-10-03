#!/bin/bash

# Battery ranges
VHIHG_BATTERY="60"
HIGH_BATTERY="40"
LOW_BATTERY="20"
VLOW_BATTERY="10"
CRITICAL_BATTERY="5"
#sleep time for script
SLEEP_VHIGH="1500"
SLEEP_HIGH="900"
SLEEP_LOW="300"
SLEEP_VLOW="150"
SLEEP_CRITICAL="90"
BAT="BAT0"
ACTION_COUNTDOWN="30"
ACTION_CRITICAL="systemctl hibernate"

while [ true ]; do
	CURRENT_BATTERY_LEVEL=`acpi -b | grep -P -o '[0-9]+(?=%)'`
	CURRENT_BATTERY_STATUS=$(cat /sys/class/power_supply/"$BAT"/status)
	if [ $CURRENT_BATTERY_LEVEL -le $CRITICAL_BATTERY ]; then
		if [ "$CURRENT_BATTERY_STATUS" == "Discharging" ]; then
			echo "$(date)"
			echo "Boooom $CURRENT_BATTERY_LEVEL $CURRENT_BATTERY_STATUS"
			notify-send -u "critical" -i "battery-low" -c "device" "Bat critical level, going to hibernate in $ACTION_COUNTDOWN s!"
			sleep $ACTION_COUNTDOWN
			$ACTION_CRITICAL
		fi
		sleep $SLEEP_CRITICAL
	elif [ $CURRENT_BATTERY_LEVEL -le $VLOW_BATTERY ]; then
		if [ "$CURRENT_BATTERY_STATUS" == "Discharging" ]; then
		    echo "$(date)"
		    echo "Fujii $CURRENT_BATTERY_LEVEL $CURRENT_BATTERY_STATUS"
    		    notify-send -u "critical" -i "battery-low" -c "device" "Bat ${CURRENT_BATTERY_LEVEL}%!"
		fi
		sleep $SLEEP_CRITICAL
	elif [ $CURRENT_BATTERY_LEVEL -le $LOW_BATTERY ]; then
	    if [ "$CURRENT_BATTERY_STATUS" == "Discharging" ]; then
    		notify-send -u "critical" -i "battery-low" -c "device" "Bat ${CURRENT_BATTERY_LEVEL}%!"
	    fi
	    echo "$(date)"
	    echo "Accuort $CURRENT_BATTERY_LEVEL $CURRENT_BATTERY_STATUS"
	    sleep $SLEEP_VLOW
	elif [ $CURRENT_BATTERY_LEVEL -le $HIGH_BATTERY ]; then
		echo "$(date)"
		echo "Ttt appo' $CURRENT_BATTERY_LEVEL $CURRENT_BATTERY_STATUS"
		sleep $SLEEP_LOW
	elif [ $CURRENT_BATTERY_LEVEL -le $VHIHG_BATTERY ]; then
		echo "$(date)"
		echo "Fin e munn' $CURRENT_BATTERY_LEVEL $CURRENT_BATTERY_STATUS"
		sleep $SLEEP_HIGH
	else
		echo "$(date)"
	        echo "E che miserj" $CURRENT_BATTERY_LEVEL $CURRENT_BATTERY_STATUS
		sleep $SLEEP_VHIGH
	fi	
done
