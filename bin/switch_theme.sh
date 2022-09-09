#!/bin/bash - 
#===============================================================================
#
#          FILE: switch_theme.sh
# 
#         USAGE: ./switch_theme.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Simone Perriello, 
#  ORGANIZATION: 
#       CREATED: 09/17/2020 08:55
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# cfgpath_firefox="$HOME/.mozilla/firefox"
cfgfile_rofi="$HOME/.config/rofi/config"
cfgfile_wofi="$HOME/.config/wofi/config"
cfgfile_vim="$HOME/.config/vim/vimrc"
cfgfile_taskwarrior="$HOME/.config/task/taskrc"
cfgfile_spacemacs="$HOME/.spacemacs"
cfgfile_gtk2="$HOME/.gtkrc-2.0"
cfgfile_gtk3="$HOME/.config/gtk-3.0/settings.ini"
cfgfile_i3="$HOME/.config/i3/config"
cfgfile_qt5="$HOME/.config/qt5ct/qt5ct.conf"
cfgfile_spt="$HOME/.config/spotify-tui/config.yml"
cfgfile_speedcrunch="$HOME/.config/SpeedCrunch/SpeedCrunch.ini"
cfgfile_ranger="$HOME/.config/ranger/rc.conf"
cfgfile_chtsh="$HOME/.config/chtsh/conf"

switchto="${1:-def}"

if [[ $switchto = def ]]; then
    bla=$(grep -E "gtk-theme-name.*Dark" "$cfgfile_gtk2")
    if [ -n "$bla" ]; then
        switchto="light"
    else
        switchto="dark"
    fi
elif [[ $switchto != light ]] && [[ $switchto != dark ]]; then
    echo "Wrong argument"
    exit 1
fi
echo "Switching to $switchto"
if [[ $switchto = light ]]; then
    i3style="park" 
    dmenu1="white" 
    dmenu2="black" 
    dmenu3="blue" 
    #kittystyle="Atom One Light"
    kittystyle="Pencil Light"
    # termitestyle="atom-one-light" 
    alacrittystyle="Google.light"
    osc411style="tango-light"
    gtktheme="\"Arc\"" 
    rofitheme="Arc" 
    dark="false" 
    qt5colors="simple.conf" 
    qt5icons="breeze"
    # deep-space, default, delek +, koehler +, nord, pablo, peachpuff, pyte, zellner +,
    vimscheme="gruvbox" 
    vimbg="light" 
    taskwarriortheme="/usr/share/doc/task/rc/solarized-light-256.theme"
    spacemacsscheme="spacemacs-light" 
    spttheme="light"
    speedcrunch="Light"
    makomode="light"
    spotifytheme="Fluent"
    spotifyscheme="light"
    rangerscheme="solarized"
    chtshstyle="xcode"
else
    i3style="default" 
    dmenu1="black" 
    dmenu2="white" 
    dmenu3="red" 
    alacrittystyle="Google.dark"
    osc411style="tango-dark"
    #kittystyle="Misterioso"
    kittystyle="Pencil Dark"
    # termitestyle="default" 
    gtktheme="\"Arc-Dark\"" 
    rofitheme="Arc-Dark" 
    dark="true" 
    qt5colors="darker.conf" 
    qt5icons="breeze-dark"
    vimscheme="gruvbox" 
    vimbg="dark" 
    taskwarriortheme="/usr/share/doc/task/rc/solarized-dark-256.theme"
    spacemacsscheme="spacemacs-dark" 
    spttheme="dark"
    speedcrunch="Dark"
    makomode="dark"
    spotifytheme="Fluent"
    spotifyscheme="dark"
    rangerscheme="default"
    chtshstyle="native"
fi
### MAIN: gtk, qt5, i3, terminal, 
# The following lines should be put before the reload of i3-style
# sed -i "s/set \$dmenu_options.*/set \$dmenu_options -nb $dmenu1 -nf $dmenu2 -sb $dmenu3/" "$cfgfile_i3"
# i3-style "$i3style" -o "$cfgfile_i3" --reload > /dev/null 2>&1
# echo "i3-style done"

# ALACRITTY
# OFF
# https://github.com/rajasegar/alacritty-themes
# https://github.com/rajasegar/alacritty-themes/tree/master/themes
# alacritty-themes "$alacrittystyle"

# KITTY
kitty +kitten themes --reload-in=all  "$kittystyle"
echo "kitty done"

# TERMITE you should first install termite-color-switcher
# OFF
# termite-color-switcher "$termitestyle"
# ALL OSC 4/11 Terminal emulators via theme.sh and bashrc; works only on new instances
# OFF
# theme.sh "$osc411style"

# Others
sed -i "s/^gtk-theme-name.*/gtk-theme-name=$gtktheme/" "$cfgfile_gtk2"
sed -i "s/^gtk-application-prefer-dark-theme.*/gtk-application-prefer-dark-theme=$dark/" "$cfgfile_gtk3"
sed -i "s;^color_scheme_path.*;color_scheme_path=/usr/share/qt5ct/colors/$qt5colors;" "$cfgfile_qt5"
sed -i "s;^icon_theme.*;icon_theme=$qt5icons;" "$cfgfile_qt5"
echo "gtk, qt5 done"

# This work for Firefox, Wofi and Thunderbird; however, the latter doesn't work
# see here https://wiki.archlinux.org/title/Dark_mode_switching#Tools
gsettings set org.gnome.desktop.interface gtk-theme "$gtktheme"
echo "GTK through gsettings done"

qt5ct-refresh
echo "qt5ct-refresh done"

### ROFI
# sed -i "s;^rofi.theme.*;rofi.theme: $rofitheme;" "$cfgfile_rofi"
# sed -i "s/^gtk-theme-name.*/gtk-theme-name=$rofitheme/" "$cfgfile_rofi"
# echo "rofi done"

### VIM
# sed -i "s/^colorscheme.*/colorscheme $vimscheme/" "$cfgfile_vim"
# sed -i "s/\scolorscheme.*/ colorscheme $vimscheme/" "$cfgfile_vim"
# This only works for new instances of vim; it's impossible to change the colorscheme of a running instance
sed -i "s/^set background.*/set background=$vimbg/" "$cfgfile_vim"
### VIM SERVER, this requires a vim installed with gui support
for i in $(vim --serverlist); do 
    echo "vim server(s) running"
    vim --servername "$i" --remote-send ":colorscheme $vimscheme<CR>"
done
echo "vim done"

### EMACS 
# WARN: this is a toggle, so it doesn't take into account any argument, maybe change
sed -i 's#spacemacs-light#spacemacs-dark#g;t;s#spacemacs-dark#spacemacs-light#g' "$cfgfile_spacemacs"
### EMACS SERVER
bla=$(pgrep -f "emacs --daemon")
if [ -n "$bla" ]; then
    echo "emacs server running"
    t=$(emacsclient -e "(load-theme '$spacemacsscheme)")
    if [[ $t != t ]]; then
	echo "Unable to change theme in spacemacs"
    fi
fi
echo "emacs done"

### TASKWARRIOR
sed -i "s;^include.*;include $taskwarriortheme;" "$cfgfile_taskwarrior"
echo "taskwarrior done"

### RANGER
sed -i "s/^set colorscheme .*/set colorscheme=$rangerscheme/" "$cfgfile_ranger"
echo "ranger done"

### SPOTIFY-TUI
# WARN: This overwrite any personalized configuration in yaml
# TODO: A parser of config that preserves non-theme lines
ln -sf "$HOME/.config/spotify-tui/theme_$spttheme.yml" "$cfgfile_spt"
echo "spotify tui done"

### SPEEDCRUNCH
# WARN: doesn't work if already active; on exit, it overwrites changes
sed -i "s;ColorSchemeName.*;ColorSchemeName=Solarized $speedcrunch;" "$cfgfile_speedcrunch"
echo "speedcrunch done"

### ZATHURA
for i in $(pidof zathura); do
    dbus-send --type="method_call" --dest=org.pwmt.zathura.PID-"$i" /org/pwmt/zathura org.pwmt.zathura.ExecuteCommand string:"set recolor"
done
echo "zathura done"

makoctl set-mode "$makomode"
echo "mako done"

spicetify config current_theme "$spotifytheme" color_scheme "$spotifyscheme"
spicetify apply
echo "spicety for spotify"

# cht.sh
sed -i "s;style=.*;style=$chtshstyle\";" "$cfgfile_chtsh"

# Still missing 
# - CopyQ: theme not changeable easily
# - GoldenDict
# - Sway window colors
