. ~/.xprofile
## One of the two window managers below
#exec xmonad
#exec twm
exec i3
# If I use the method below, sddm crashes when switching b/w tty
#exec dbus-launch --sh-syntax --exit-with-session i3 >"$MDIR_LOGS/startx/i3.log$DISPLAY" 2>&1
#exec i3 -V >> ~/logs/startx/i3log-$(date +'%F-%k-%M-%S') 2>&1
