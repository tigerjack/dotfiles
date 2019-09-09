#!/bin/sh
## Means already in desktop files
# Polkit, started by systemctl
## lxqt-policykit-agent >"$MDIR_LOGS/startx/lxqt_policykit_agent.log$DISPLAY" 2>&1 &

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
## start-pulseaudio-x11 >"$MDIR_LOGS/startx/pulseaudioX11.log$DISPLAY" 2>&1 &

# simple NetworkManager front end with system tray.
# Replaces nm-applet
# nm-tray >"$MDIR_LOGS/startx/nm-tray.log$DISPLAY" 2>&1 &
nm-applet >"$MDIR_LOGS/startx/nm-applet.log$DISPLAY" 2>&1 &

# Copyq manages clipboards.
# I have a different configuration for each DISPLAY
#copyq --session=${DISPLAY//:/_} >"$MDIR_LOGS/startx/copyq.log$DISPLAY" 2>&1 &
## copyq --session="${DISPLAY//:/_}" >"$MDIR_LOGS/startx/copyq.log$DISPLAY" 2>&1 &

# Mailnag to check email accounts
mailnag >"$MDIR_LOGS/startx/mailnag.log$DISPLAY" 2>&1 &

# For swipe and pinch commands
libinput-gestures >"$MDIR_LOGS/startx/libinput-gestures.log$DISPLAY" 2>&1 &

# Execute all my startup X scripts
for file in ~/bin/x/autostart/?*.sh; do
	if [ -x "$file" ]; then
		#name=$(basename -s .sh $file)
		name="$(basename -s .sh "$file")"
		logfile="$MDIR_LOGS/startx/$name.log$DISPLAY"
		($file >"$logfile" 2>&1 & )
	fi
done
unset file

for file in /etc/xdg/autostart/?*.desktop; do
	name="$(basename -s .desktop "$file")"
	logfile="$MDIR_LOGS/startx/$name.log$DISPLAY"
	(dex "$file" >"$logfile" 2>&1 & )
done
unset file

# We should execute also all .desktop files in .config/autostart
# to comply to XDG specifcations
for file in ~/.config/autostart/?*.desktop; do
	name="$(basename -s .desktop "$file")"
	logfile="$MDIR_LOGS/startx/$name.log$DISPLAY"
	(dex "$file" >"$logfile" 2>&1 & )
done
unset file

# Remove previous logs
rm "$MDIR_LINUX_DATA/logs/i3/i3-sensible-terminal.log"
rm "$MDIR_LINUX_DATA/logs/i3/i3-dmenu-desktop.log"
rm "$MDIR_LINUX_DATA/logs/i3/rofi.log"
rm "$MDIR_LINUX_DATA/logs/i3/xfce4-appfinder.log"
