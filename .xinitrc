## Load X resources, never background them 
[[ -f ~/.Xdefaults ]] && xrdb -merge ~/.Xdefaults
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Source my file with environment variables used by GUI application
[ -f ~/.xmyenv ] && . ~/.xmyenv

xscreensaver -no-splash >~/.startx/xscreensaver.log &
xss-lock -- xscreensaver-command --lock >~/.startx/xss-lock.log &
#conky -p 2 &

# The tray
trayer --edge bottom --align right --SetDockType true --SetPartialStrut true  --expand true --width 10 --widthtype percent --transparent false --tint 0x252525 --height 20 --expand false >~/.startx/trayer.log 2>&1 &

# The network manager tray icon
#wicd-gtk -t >~/.startx/wicd-gtk.log 2>&1 &

# The weather system tray icon (not yet working)
# meteo-qt >~/.startx/meteo-qt 2>&1 &

# To manage clipboards
copyq >~/.startx/copyq.log 2>&1 &

# The pulse audio tray icon
pasystray >~/.startx/pasystray.log 2>&1 &

# To associate shortcuts to events
xbindkeys >~/.startx/xbindkeys.log 2>&1 &

# notification system daemon
#twmnd >~/.startx/twmnd.log 2>&1 &
dunst >~/.startx/dunst.log 2>&1 &

# The mail client
#thunderbird >~/.startx/thunderbird.log 2>&1 &

# To avoid terminal bell
xset -b

# Emacs daemon
emacs --daemon &

# Execute all my periodic X scripts
for file in ~/bin/mycron/x/?*.sh; do
	name=$(basename -s .sh $file)
	logfile="/home/tigerjack/.startx/$name.log"
	#echo "$file $name $logfile"
	( $file > "$logfile" 2>&1 &)
done
unset file

# Execute all scripts inside xinitrc.d
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Change the screen settings
xrandr --output "LVDS-1" --brightness 0.5 --gamma 1:1:0.5

# Activate bloc num
numlockx &

# Start the OpenSSH agent, evaluating the environment variables
eval $(ssh-agent)

## One of the two window managers below
exec xmonad
#exec twm
