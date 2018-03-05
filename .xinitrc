## Load X resources, never background them 
[[ -f ~/.Xdefaults ]] && xrdb -merge ~/.Xdefaults
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Source my file with environment variables used by GUI application
[ -f ~/.xmyenv ] && . ~/.xmyenv

xscreensaver -no-splash >~/logs/startx/xscreensaver.log &
xss-lock -- xscreensaver-command --lock >~/logs/startx/xss-lock.log &
#conky -p 2 &

# To manage clipboards
copyq >~/logs/startx/copyq.log 2>&1 &

# To associate shortcuts to events
xbindkeys >~/logs/startx/xbindkeys.log 2>&1 &


# To remap keys, see this blog http://www.economyofeffort.com/2014/08/11/beyond-ctrl-remap-make-that-caps-lock-key-useful/
setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape' >~/logs/startx/xcape.log 2>&1 &


# notification system daemon
#twmnd >~/logs/startx/twmnd.log 2>&1 &
dunst >~/logs/startx/dunst.log 2>&1 &

# To avoid terminal bell
xset -b

# Polkit, started by systemctl
lxqt-policykit-agent &

# Execute all my periodic X scripts
for file in ~/bin/mycron/x/?*.sh; do
	name=$(basename -s .sh $file)
	logfile="/home/tigerjack/logs/startx/$name.log"
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
#exec xmonad
#exec twm
#exec i3
exec dbus-launch --sh-syntax --exit-with-session i3 >"/home/tigerjack/logs/startx/i3.log$DISPLAY" 2>&1
#exec i3 -V >> ~/logs/startx/i3log-$(date +'%F-%k-%M-%S') 2>&1
