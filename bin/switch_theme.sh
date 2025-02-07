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
cfgfile_rofi="$HOME/.config/rofi/config.rasi"
cfgfile_wofi="$HOME/.config/wofi/config"
cfgfile_wofi_stylesheet="$HOME/.config/wofi/style.css"
cfgfile_vim="$HOME/.config/vim/vimrc"
cfgfile_taskwarrior="$HOME/.config/task/taskrc"
cfgfile_spacemacs="$HOME/.spacemacs"
cfgfile_gtk2="$HOME/.gtkrc-2.0"
cfgfile_gtk3="$HOME/.config/gtk-3.0/settings.ini"
cfgfile_i3="$HOME/.config/i3/config"
cfgfile_qt5="$HOME/.config/qt5ct/qt5ct.conf"
cfgfile_qt6="$HOME/.config/qt6ct/qt6ct.conf"
cfgfile_spt="$HOME/.config/spotify-tui/config.yml"
cfgfile_speedcrunch="$HOME/.config/SpeedCrunch/SpeedCrunch.ini"
cfgfile_ranger="$HOME/.config/ranger/rc.conf"
cfgfile_chtsh="$HOME/.config/chtsh/conf"
cfgfile_bat="$HOME/.config/bat/config"
cfgfile_zathura="$HOME/.config/zathura/zathurarc"

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
    zathura_recolor="false"
    battheme="OneHalfLight"
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
    preferdark="false" 
    qt5colors="simple.conf" 
    qt5icons="breeze"
    qt5style="kvantum"
    # deep-space, default, delek +, koehler +, nord, pablo, peachpuff, pyte, zellner +,
    vimscheme="gruvbox" 
    vimbg="light" 
    taskwarriortheme="/usr/share/doc/task/rc/solarized-light-256.theme"
    spacemacsscheme="spacemacs-light" 
    spttheme="light"
    speedcrunch="Light"
    makomode="light"
    spotifytheme="Ziro"
    spotifyscheme="purple-light"
    rangerscheme="solarized"
    chtshstyle="xcode"
else # dark theme
    zathura_recolor="true"
    battheme="OneHalfDark"
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
    preferdark="true" 
    qt5colors="darker.conf" 
    qt5icons="breeze-dark"
    qt5style="kvantum-dark"
    vimscheme="gruvbox" 
    vimbg="dark" 
    taskwarriortheme="/usr/share/doc/task/rc/solarized-dark-256.theme"
    spacemacsscheme="spacemacs-dark" 
    spttheme="dark"
    speedcrunch="Dark"
    makomode="dark"
    spotifytheme="Ziro"
    spotifyscheme="purple-dark"
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
# cache age is there to not use internet
kitty +kitten themes --reload-in=all --cache-age -1 "$kittystyle"
echo "kitty done"

# TERMITE you should first install termite-color-switcher
# OFF
# termite-color-switcher "$termitestyle"
# ALL OSC 4/11 Terminal emulators via theme.sh and bashrc; works only on new instances
# OFF
# theme.sh "$osc411style"

# GTK/QT
sed -i "s/^gtk-theme-name.*/gtk-theme-name=$gtktheme/" "$cfgfile_gtk2"
sed -i "s/^gtk-theme-name.*/gtk-theme-name=$gtktheme/" "$cfgfile_gtk3"
sed -i "s/^gtk-application-prefer-dark-theme.*/gtk-application-prefer-dark-theme=$preferdark/" "$cfgfile_gtk3"
echo "gtk done"
sed -i "s;^color_scheme_path.*;color_scheme_path=/usr/share/qt5ct/colors/$qt5colors;" "$cfgfile_qt5"
sed -i "s;^icon_theme.*;icon_theme=$qt5icons;" "$cfgfile_qt5"
sed -i "s;^icon_theme.*;icon_theme=$qt5icons;" "$cfgfile_qt5"
sed -i "s;^style.*;style=$qt5style;" "$cfgfile_qt5"
echo "qt5 done"
sed -i "s;^color_scheme_path.*;color_scheme_path=/usr/share/qt6ct/colors/$qt5colors;" "$cfgfile_qt6"
sed -i "s;^icon_theme.*;icon_theme=$qt5icons;" "$cfgfile_qt6"
sed -i "s;^icon_theme.*;icon_theme=$qt5icons;" "$cfgfile_qt6"
sed -i "s;^style.*;style=$qt5style;" "$cfgfile_qt6"
echo "qt6 done"

# This work for Firefox, Wofi and Thunderbird; however, the latter doesn't work
# see here https://wiki.archlinux.org/title/Dark_mode_switching#Tools
gsettings set org.gnome.desktop.interface gtk-theme "$gtktheme"
gsettings set org.gnome.desktop.interface color-scheme prefer-"$switchto"
echo "GTK through gsettings done"

qt5ct-refresh
echo "qt5ct-refresh done"

### ROFI
sed -i 's|/usr/share/rofi/themes/[^.]*|/usr/share/rofi/themes/'"$rofitheme"'|' "$cfgfile_rofi"
echo "rofi done"

### WOFI
if [[ $switchto == light ]]; then
  if [[ -e $cfgfile_wofi_stylesheet ]]; then
    rm $cfgfile_wofi_stylesheet
  fi
elif [[ $switchto == dark ]]; then
  ln -sf  "$XDG_CONFIG_HOME/wofi/themes/themes/gruvbox.css" "$XDG_CONFIG_HOME/wofi/style.css"
fi


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

# ### EMACS 
# # WARN: this is a toggle, so it doesn't take into account any argument, maybe change
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
# for new instances
sed -i "s;set recolor .*;set recolor \"$zathura_recolor\";;" "$cfgfile_zathura"
# for already opened ones
for i in $(pidof zathura); do
    dbus-send --type="method_call" --dest=org.pwmt.zathura.PID-"$i" /org/pwmt/zathura org.pwmt.zathura.ExecuteCommand string:"set recolor $zathura_recolor"
done
echo "zathura done"

### MAKO
pgrep -x mako > /dev/null && makoctl set-mode "$makomode" && echo "mako done"

### cht.sh
sed -i "s;style=.*;style=$chtshstyle\";" "$cfgfile_chtsh"

### BAT
sed -i "s;^--theme=.*;--theme=\"$battheme\";" "$cfgfile_bat"

echo -n "Spicetify "
if command -v spicetify &>/dev/null; then
    spicetify config current_theme "$spotifytheme" color_scheme "$spotifyscheme"
    if pgrep -x spotify>/dev/null; then 
        spicetify apply
        # sleep 2s && playerctl -p spotify play
        echo " ... done"
    else
        spicetify apply -n
        echo " ... skipped"
    fi
else
    echo "... not found"
fi
# echo "spicety for spotify"

# Still missing 
# - CopyQ: theme not changeable easily; UP: now it seems to respect qt5 styles
# - GoldenDict
# - Sway window colors
