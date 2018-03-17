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
SLEEP_CRITICAL="60"
BAT="BAT0"
ACTION_COUNTDOWN="60"
#ACTION_CRITICAL="systemctl hybrid-sleep"
ACTION_CRITICAL="systemctl suspend"
# Notify msg
TEST=""

function critical_action() {
		notify-send -u "critical" -i "battery-low" -c "device" "Bat critical level, going to perform $ACTION_CRITICAL in $ACTION_COUNTDOWN s!"
		echo "$(date) Going to perform $ACTION_CRITICAL in $ACTION_COUNTDOWN s"
		sleep $ACTION_COUNTDOWN
		if [ "$(cat /sys/class/power_supply/"$BAT"/status)" == "Discharging" ]; then
			  echo "$(date) Performing $ACTION_CRITICAL"
			  $ACTION_CRITICAL
		fi
}

function critical_action2() {
    systemctl hibernate
}

function send_message() {
    if [ -n "$DISPLAY" ]; then
		    notify-send -u "critical" -i "battery-low" -c "device" "$1"
    else
        #The else part is not used ever ATM
        wall "$1"
    fi
}

while [ true ]; do
	  CURRENT_BATTERY_LEVEL=`acpi -b | grep -P -o '[0-9]+(?=%)'`
	  CURRENT_BATTERY_STATUS=$(cat /sys/class/power_supply/"$BAT"/status)
    SLEEP_TIME=$SLEEP_VLOW
	  if [ $CURRENT_BATTERY_LEVEL -le $CRITICAL_BATTERY ]; then
		    if [ "$CURRENT_BATTERY_STATUS" == "Discharging" ]; then
            if [ -z "$TEST" ]; then
                echo "If branch taken"
                critical_action
                TEST="t"
            else
                #Maybe already set as udev rule
                critical_action2
                echo "Else branch taken"
                TEST=""
            fi
            SLEEP_TIME=30
        else
            SLEEP_TIME=$SLEEP_CRITICAL
		    fi
	  elif [ $CURRENT_BATTERY_LEVEL -le $VLOW_BATTERY ]; then
		    if [ "$CURRENT_BATTERY_STATUS" == "Discharging" ]; then
            NOTIFY_MSG="Bat $CURRENT_BATTERY_LEVEL%!"
		    fi
		    SLEEP_TIME=$SLEEP_VLOW
	  elif [ $CURRENT_BATTERY_LEVEL -le $LOW_BATTERY ]; then
	      if [ "$CURRENT_BATTERY_STATUS" == "Discharging" ]; then
            NOTIFY_MSG="Bat $CURRENT_BATTERY_LEVEL%!"
	      fi
	      SLEEP_TIME=$SLEEP_LOW
	  elif [ $CURRENT_BATTERY_LEVEL -le $HIGH_BATTERY ]; then
		    SLEEP_TIME=$SLEEP_HIGH
	  elif [ $CURRENT_BATTERY_LEVEL -le $VHIGH_BATTERY ]; then
		    SLEEP_TIME=$SLEEP_VHIGH
	  else
		    SLEEP_TIME=$SLEEP_VHIGH
	  fi
		echo "$(date): $CURRENT_BATTERY_LEVEL% $CURRENT_BATTERY_STATUS"
    if [ -n "$NOTIFY_MSG" ]; then
        send_message "$NOTIFY_MSG"
    fi
    NOTIFY_MSG=""
    sleep $SLEEP_TIME
done
