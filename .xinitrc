#!/bin/bash
. ~/.xprofile
## One of the two window managers below
#exec xmonad
#exec twm
exec i3
# This is also necessary to set $DBUS_SESSION_BUS_ADDRESS
#exec dbus-launch --sh-syntax i3 >"$MDIR_LOGS/startx/i3.log$DISPLAY" 2>&1
#exec dbus-launch --sh-syntax --exit-with-session i3 >"$MDIR_LOGS/startx/i3.log$DISPLAY" 2>&1
#exec i3 -V >> ~/logs/startx/i3log-$(date +'%F-%k-%M-%S') 2>&1
