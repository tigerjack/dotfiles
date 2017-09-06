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
wicd-gtk -t >~/.startx/wicd-gtk.log 2>&1 &

# To manage clipboards
copyq >~/.startx/copyq.log 2>&1 &

# The pulse audio tray icon
pasystray >~/.startx/pasystray.log 2>&1 &

# To associate shortcuts to events
xbindkeys >~/.startx/xbindkeys.log 2>&1 &

# twmn (notification system) daemon
twmnd >~/.startx/twmnd.log 2>&1 &

# The mail client
thunderbird >~/.startx/thunderbird.log 2>&1 &

## The background
~/bin/change_background.sh >~/.startx/change_wallpaper.log 2>&1 &

# To avoid terminal bell
xset -b

# Start the gnome-keyring-daemon from xinitrc:
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Start the OpenSSH agent, evaluating the environment variables
eval $(ssh-agent)

## One of the two window managers below
exec xmonad
#exec twm
