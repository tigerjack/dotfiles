#!/bin/bash
ACTIVE_MONITOR=$(xrandr | grep -E " connected (primary )?[1-9]+" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
CURRENT_BRIGHTNESS=$(xrandr --current --verbose | grep -m 1 'Brightness:' | cut -f2- -d:)
CURRENT_BLUE_GAMMA=$(xrandr --current --verbose | grep -m 1 "Gamma" | cut -f4- -d:)
DEFAULT_BRIGHTNESS="0.2"
DEFAULT_BLUE_GAMMA="2.0" ## Note: it's evaluated as the ratio 1/2

# Note that with a brightness above 1.0 a step below 0.05 doesn't work well
STEP=0.1

if [ -z "$CURRENT_BRIGHTNESS" ]
then
    echo "Hola"
    CURRENT_BRIGHTNESS="$DEFAULT_BRIGHTNESS"
    CURRENT_BLUE_GAMMA="$DEFAULT_BLUE_GAMMA"
fi

if [[ "$1" == "+" ]] && [ "$(echo "$CURRENT_BRIGHTNESS < 1.5" | bc)" -eq 1 ]
then
    echo "Going up"
    xrandr --output "$ACTIVE_MONITOR" --auto --brightness "$(echo "$CURRENT_BRIGHTNESS + $STEP" | bc)" --gamma 1:1:"$(echo "scale=1; 1.0 / $CURRENT_BLUE_GAMMA" | bc)"
elif [ "$1" == "-" ]
then
    if [ "$(echo "$CURRENT_BRIGHTNESS > 0.0" | bc)" -eq 1 ]
    then
	echo "Going down"
	xrandr --output "$ACTIVE_MONITOR" --brightness "$(echo "$CURRENT_BRIGHTNESS - $STEP" | bc)" --gamma 1:1:"$(echo "scale=1; 1.0 / $CURRENT_BLUE_GAMMA" | bc)"
    else
	echo "Going off"
	xrandr --output "$ACTIVE_MONITOR" --off
    fi
elif [ "$1" == "=" ] && [ "$(echo "$2 > 0.0" | bc)" -eq 1 ]  && [ "$(echo "$2 < 1.5" | bc)" -eq 1 ]
then
    xrandr --auto --output "$ACTIVE_MONITOR" --brightness "$2" --gamma 1:1:"$(echo "scale=1; 1.0 / $CURRENT_BLUE_GAMMA" | bc)"
else
    notify-send "Brightness out of range"
fi
