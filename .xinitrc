#!/bin/bash

#----------
# copied by xinitrc
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#----------
# Other start programs
#----------
# Source my files with environment variables used by all applications...
# [ -f ~/.global_env ] && . ~/.global_env > "$MDIR_LOGS/startx/global_env.log$DISPLAY" 2>&1
# actually they are sourced via bashrc
# ... and GUI applications
[ -f ~/.xmyenv ] && . ~/.xmyenv > "$MDIR_LOGS/startx/xmyenv.log$DISPLAY" 2>&1

# To avoid terminal bell
xset -b

# Start the OpenSSH agent, evaluating the environment variables. It exports SSH_AUTH_SOCK
eval $(ssh-agent -s &) >"$MDIR_LOGS/startx/ssh_agent.log$DISPLAY" 2>&1

# Gnome key ring, with ssh agent disabled bcz using ssh-agent and gpg disabled bcz gpg-agent started by systemctl --user
## eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets) >"$MDIR_LOGS/startx/gnome_keyring.log$DISPLAY" 2>&1
#export SSH_AUTH_SOCK

# Change the screen settings
#xrandr --output "Screen 0" --brightness 0.5 --gamma 1:1:0.5
xrandr --output $(xrandr | grep -E " connected (primary )?[1-9]+" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/") --brightness 0.5 --gamma 1:1:0.5 > "$MDIR_LOGS/startx/xrandr.log$DISPLAY" 2>&1

# Activate bloc num
numlockx &

# Set us layout for keyboard
setxkbmap -layout us,it > "$MDIR_LOGS/startx/setxkbmap.log$DISPLAY" 2>&1
# To remap keys, see http://www.economyofeffort.com/2014/08/11/beyond-ctrl-remap-make-that-caps-lock-key-useful/
setxkbmap -option 'caps:ctrl_modifier' >> "$MDIR_LOGS/startx/setxkbmap.log$DISPLAY" 2>&1 
xcape -e 'Caps_Lock=Escape;Control_L=Escape' > "$MDIR_LOGS/startx/xcape.log$DISPLAY" 2>&1

# Alternative method to swap CapsLock and Ctrl key
# xmodmap ~/.config/xmodmap/speedswapper

# Repeat delay (100-1000) and repeat interval (10-200) of keyboard
xset r rate 250 60
# Disable slow-keys
xkbset -sl
# Disable accessibility so slow-keys won't turn back on
xkbset -a

#----------
## One of the window managers below
#----------
#exec xmonad
#exec twm
exec i3
# This is also necessary to set $DBUS_SESSION_BUS_ADDRESS
#exec dbus-launch --sh-syntax i3 >"$MDIR_LOGS/startx/i3.log$DISPLAY" 2>&1
#exec dbus-launch --sh-syntax --exit-with-session i3 >"$MDIR_LOGS/startx/i3.log$DISPLAY" 2>&1
#exec i3 -V >> ~/logs/startx/i3log-$(date +'%F-%k-%M-%S') 2>&1
