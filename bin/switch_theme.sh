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
cfgfile_taskwarrior="$HOME/.config/taskwarrior/taskrc"
echo "$cfgfile_taskwarrior"
cfgfile_spacemacs="$HOME/.spacemacs"
cfgfile_gtk2="$HOME/.gtkrc-2.0"
cfgfile_gtk3="$HOME/.config/gtk-3.0/settings.ini"
cfgfile_i3="$HOME/.config/i3/config"
cfgfile_qt5="$HOME/.config/qt5ct/qt5ct.conf"
cfgfile_spt="$HOME/.config/spotify-tui/config.yml"
cfgfile_speedcrunch="$HOME/.config/SpeedCrunch/SpeedCrunch.ini"

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
    # termitestyle="atom-one-light" 
    alacrittystyle="Google.light"
    gtktheme="\"Arc\"" 
    rofitheme="Arc" 
    dark="false" 
    qt5colors="simple.conf" 
    # deep-space, default, delek +, koehler +, nord, pablo, peachpuff, pyte, zellner +,
    # vimscheme="koehler" 
    vimbg="light" 
    taskwarriortheme="/usr/share/doc/task/rc/solarized-light-256.theme"
    spacemacsscheme="spacemacs-light" 
    spttheme="light"
    speedcrunch="Light"
else
    i3style="default" 
    dmenu1="black" 
    dmenu2="white" 
    dmenu3="red" 
    alacrittystyle="Google.dark"
    # termitestyle="default" 
    gtktheme="\"Arc-Dark\"" 
    rofitheme="Arc-Dark" 
    dark="true" 
    qt5colors="darker.conf" 
    # vimscheme="default" 
    vimbg="dark" 
    taskwarriortheme="/usr/share/doc/task/rc/solarized-dark-256.theme"
    spacemacsscheme="spacemacs-dark" 
    spttheme="dark"
    speedcrunch="Dark"
fi
### MAIN: gtk, qt5, i3, terminal, 
# The following lines should be put before the reload of i3-style
sed -i "s/set \$dmenu_options.*/set \$dmenu_options -nb $dmenu1 -nf $dmenu2 -sb $dmenu3/" "$cfgfile_i3"
i3-style "$i3style" -o "$cfgfile_i3" --reload > /dev/null 2>&1
# ALACRITTY
# https://github.com/rajasegar/alacritty-themes
# https://github.com/rajasegar/alacritty-themes/tree/master/themes
alacritty-themes "$alacrittystyle"
# TERMITE you should first install termite-color-switcher
# OFF
# termite-color-switcher "$termitestyle"
# Others
sed -i "s/^gtk-theme-name.*/gtk-theme-name=$gtktheme/" "$cfgfile_gtk2"
sed -i "s/^gtk-theme-name.*/gtk-theme-name=$rofitheme/" "$cfgfile_gtk3"
sed -i "s/^gtk-application-prefer-dark-theme.*/gtk-application-prefer-dark-theme=$dark/" "$cfgfile_gtk3"
sed -i "s;^color_scheme_path.*;color_scheme_path=/usr/share/qt5ct/colors/$qt5colors;" "$cfgfile_qt5"

### ROFI
# sed -i "s;^rofi.theme.*;rofi.theme: $rofitheme;" "$cfgfile_rofi"
### VIM
# sed -i "s/^colorscheme.*/colorscheme $vimscheme/" "$cfgfile_vim"
sed -i "s/^set background.*/set background=$vimbg/" "$cfgfile_vim"
### VIM SERVER, this requires a vim installed with gui support
for i in $(vim --serverlist); do 
    vim --servername "$i" --remote-send ":colorscheme $vimscheme<CR>"
done
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
### TASKWARRIOR
sed -i "s;^include.*;include $taskwarriortheme;" "$cfgfile_taskwarrior"

### SPOTIFY-TUI
# WARN: This overwrite any personalized configuration in yaml
# TODO: A parser of config that preserves non-theme lines
ln -sf "$HOME/.config/spotify-tui/theme_$spttheme.yml" "$cfgfile_spt"
### SPEEDCRUNCH
# WARN: doesn't work if already active; on exit, it overwrites changes
sed -i "s;ColorSchemeName.*;ColorSchemeName=Solarized $speedcrunch;" "$cfgfile_speedcrunch"

# Still missing 
# - Firefox: changes to user.js aren't loaded automatically; you can use a plugin to rotate
#   b/w themes with Alt+Shift+R
# - Thunderbird: no easy switch 
# - CopyQ: theme not changeable easily
# - GoldenDict
# - Wofi
