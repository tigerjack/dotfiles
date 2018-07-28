#!/bin/sh
# Polkit, started by systemctl
lxqt-policykit-agent >"$MDIR_LOGS/startx/lxqt_policykit_agent.log$DISPLAY" 2>&1 &

# Xscreeensaver manages screensaver, xss-lock respond to suspend/hibernate event locking screen
xscreensaver -no-splash >"$MDIR_LOGS/startx/xscreensaver.log$DISPLAY" 2>&1 &
xss-lock -- xscreensaver-command --lock >"$MDIR_LOGS/startx/xss-lock.log$DISPLAY" 2>&1 &

# To associate shortcuts to events
xbindkeys >"$MDIR_LOGS/startx/xbindkeys.log$DISPLAY" 2>&1 &

# notification system daemon
#twmnd >~/logs/startx/twmnd.log 2>&1 &
# Should be launched automatically on new notification
dunst >"$MDIR_LOGS/startx/dunst.log$DISPLAY" 2>&1 &

# PulseAudio
start-pulseaudio-x11 >"$MDIR_LOGS/startx/pulseaudioX11.log$DISPLAY" 2>&1 &

# Execute all my startup X scripts
for file in ~/bin/x/autostart/?*.sh; do
	if [ -x "$file" ]; then
		name=$(basename -s .sh $file)
		logfile="$MDIR_LOGS/startx/$name.log$DISPLAY"
		($file >"$logfile" 2>&1 & )
	fi
done
unset file
