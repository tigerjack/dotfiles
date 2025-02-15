#!/bin/sh
id=$(xinput | grep PS/2 | awk '{print $6}' |  xinput | grep PS/2 | awk '{print $6}' | sed -e 's#.*=\(\)#\1#')
TOUCH_ENABLED=$(xinput list-props "$id" | grep Device\ Enabled | awk '{ print $4 }')
if [ "$TOUCH_ENABLED" = 0 ]; then
    notify-send -t 2000 -u low "touchpad" "touch enabled"
    xinput set-prop "$id" "Device Enabled" 1
elif [ "$TOUCH_ENABLED" = 1 ]; then
    notify-send -t 2000 -u low "touchpad" "touch disabled"
    xinput set-prop "$id" "Device Enabled" 0
else
    echo "Could not get touchpad status from xinput"
    exit 1
fi
exit 0
