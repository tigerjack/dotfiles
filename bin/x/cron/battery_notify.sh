#!/bin/bash

# Battery ranges
VHIGH_BATTERY="60"
HIGH_BATTERY="45"
LOW_BATTERY="25"
VLOW_BATTERY="10"
CRITICAL_BATTERY="5"
#sleep time for script
SLEEP_VHIGH="1500"
SLEEP_HIGH="900"
SLEEP_LOW="300"
SLEEP_VLOW="150"
SLEEP_CRITICAL="90"
BAT="BAT0"
ACTION_COUNTDOWN="60"
ACTION_CRITICAL="systemctl hybrid-sleep"
# Notify msg
NOTIFY_MSG=""

function critical_action() {
		notify-send -u "critical" -i "battery-low" -c "device" "Bat critical level, going to perform $ACTION_CRITICAL in $ACTION_COUNTDOWN s!"
		echo "$(date) Going to perform $ACTION_CRITICAL in $ACTION_COUNTDOWS s"
		sleep $ACTION_COUNTDOWN
		if [ "$(cat /sys/class/power_supply/"$BAT"/status)" == "Discharging" ]; then
			  echo "$(date) Performing $ACTION_CRITICAL"
			  $ACTION_CRITICAL
		fi
}

while [ true ]; do
	  CURRENT_BATTERY_LEVEL=`acpi -b | grep -P -o '[0-9]+(?=%)'`
	  CURRENT_BATTERY_STATUS=$(cat /sys/class/power_supply/"$BAT"/status)
    SLEEP_TIME=$SLEEP_VLOW
	  if [ $CURRENT_BATTERY_LEVEL -le $CRITICAL_BATTERY ]; then
        SLEEP_TIME=$SLEEP_CRITICAL
		    if [ "$CURRENT_BATTERY_STATUS" == "Discharging" ]; then
            critical_action
		    fi
	  elif [ $CURRENT_BATTERY_LEVEL -le $VLOW_BATTERY ]; then
		    SLEEP_TIME=$SLEEP_VLOW
		    if [ "$CURRENT_BATTERY_STATUS" == "Discharging" ]; then
            NOTIFY_MSG="Bat ${CURRENT_BATTERY_LEVEL}%!"
		    fi
	  elif [ $CURRENT_BATTERY_LEVEL -le $LOW_BATTERY ]; then
	      SLEEP_TIME=$SLEEP_LOW
	      if [ "$CURRENT_BATTERY_STATUS" == "Discharging" ]; then
            NOTIFY_MSG="Bat ${CURRENT_BATTERY_LEVEL}%!"
	      fi
	  elif [ $CURRENT_BATTERY_LEVEL -le $HIGH_BATTERY ]; then
		    SLEEP_TIME=$SLEEP_HIGH
	  elif [ $CURRENT_BATTERY_LEVEL -le $VHIGH_BATTERY ]; then
		    SLEEP_TIME=$SLEEP_VHIGH
	  else
		    SLEEP_TIME=$SLEEP_VHIGH
	  fi
		echo "$(date): $CURRENT_BATTERY_LEVEL $CURRENT_BATTERY_STATUS"
    sleep $SLEEP_TIME
    if [ -n $NOTIFY_MSG ]; then
       if [ -n $DISPLAY ]; then
		      notify-send -u "critical" -i "battery-low" -c "device" "$NOTIFY_MSG"
       else
           #The else part is not used ever ATM
           wall "$NOTIFY_MSG"
       fi
    fi
    NOTIFY_MSG=""
done
