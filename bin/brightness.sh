#!/usr/bin/bash
CURRENT_BRIGHTNESS=$(xrandr --current --verbose | grep -m 1 'Brightness:' | cut -f2- -d:)
CURRENT_BLUE_GAMMA=$(xrandr --current --verbose | grep -m 1 "Gamma" | cut -f4- -d:)
# Note that with a brightness above 1.0 a step below 0.05 doesn't work well
STEP=0.1

#echo $1
#$(echo "$CURRENT_BRIGHTNESS  + $STEP" | bc)
if [[ "$1" == "+" ]] && [ $(echo "$CURRENT_BRIGHTNESS < 1.5" | bc) -eq 1 ]
then
    xrandr --output "LVDS-1" --brightness $(echo "$CURRENT_BRIGHTNESS + $STEP" | bc) --gamma 1:1:$(echo "scale=1; 1.0 / $CURRENT_BLUE_GAMMA" | bc)
elif [ "$1" == "-" ] && [ $(echo "$CURRENT_BRIGHTNESS > 0.0" | bc) -eq 1 ]
then
    xrandr --output "LVDS-1" --brightness $(echo "$CURRENT_BRIGHTNESS - $STEP" | bc) --gamma 1:1:$(echo "scale=1; 1.0 / $CURRENT_BLUE_GAMMA" | bc)
elif [ "$1" == "=" ] && [ $(echo "$2 > 0.0" | bc) -eq 1 ]  && [ $(echo "$2 < 1.5" | bc) -eq 1 ]
then
    xrandr --output "LVDS-1" --brightness "$2" --gamma 1:1:$(echo "scale=1; 1.0 / $CURRENT_BLUE_GAMMA" | bc)
else
    notify-send "Brightness out of range"
fi
