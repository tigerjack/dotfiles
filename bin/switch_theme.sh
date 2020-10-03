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
cfgfile_vim="$HOME/.config/vim/vimrc"
cfgfile_spacemacs="$HOME/.spacemacs"
cfgfile_gtk2="$HOME/.gtkrc-2.0"
cfgfile_gtk3="$HOME/.config/gtk-3.0/settings.ini"
cfgfile_i3="$HOME/.config/i3/config"
cfgfile_qt5="$HOME/.config/qt5ct/qt5ct.conf"

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
### EMACS 
# Warning: this is a toggle, so it doesn't take into account any argument, maybe change
sed -i 's#spacemacs-light#spacemacs-dark#g;t;s#spacemacs-dark#spacemacs-light#g' "$cfgfile_spacemacs"
## VIM
# sed -i 's#colorscheme default#colorscheme morning#g;t;s#colorscheme morning#colorscheme default#g' "$cfgfile_vim"
[[ $switchto = light ]] && i3style="park" || i3style="default"
[[ $switchto = light ]] && termitestyle="solarized-light" || termitestyle="default"
[[ $switchto = light ]] && gtktheme="\"Arc\"" || gtktheme="\"Arc-Dark\""
[[ $switchto = light ]] && rofitheme="Arc" || rofitheme="Arc-Dark"
[[ $switchto = light ]] && dark="false" || dark="true"
[[ $switchto = light ]] && qt5colors="simple.conf" || qt5colors="darker.conf"
[[ $switchto = light ]] && vimscheme="morning" || vimscheme="default"
[[ $switchto = light ]] && vimbg="light" || vimbg="dark"
[[ $switchto = light ]] && spacemacsscheme="spacemacs-light" || spacemacsscheme="spacemacs-dark"
i3-style "$i3style" -o "$cfgfile_i3" --reload > /dev/null 2>&1
termite-color-switcther "$termitestyle"
sed -i "s/^gtk-theme-name.*/gtk-theme-name=$gtktheme/" "$cfgfile_gtk2"
sed -i "s/^gtk-theme-name.*/gtk-theme-name=$rofitheme/" "$cfgfile_gtk3"
sed -i "s/^gtk-application-prefer-dark-theme.*/gtk-application-prefer-dark-theme=$dark/" "$cfgfile_gtk3"
sed -i "s;^color_scheme_path.*;color_scheme_path=/usr/share/qt5ct/colors/$qt5colors;" "$cfgfile_qt5"
sed -i "s;^rofi.theme.*;rofi.theme: $rofitheme;" "$cfgfile_rofi"
sed -i "s/^colorscheme.*/colorscheme $vimscheme/" "$cfgfile_vim"
sed -i "s/^set background.*/set background=$vimbg/" "$cfgfile_vim"

### VIM SERVER
for i in $(vim --serverlist); do 
    vim --servername "$i" --remote-send ":colorscheme $vimscheme<CR>"
done
### EMACS SERVER
bla=$(pgrep -f "emacs --daemon")
if [ -n "$bla" ]; then
    echo "emacs server running"
    t=$(emacsclient -e "(load-theme '$spacemacsscheme)")
    if [[ $t != t ]]; then
	echo "Unable to change theme in spacemacs"
    fi
fi

# Still missing 
# - Firefox: changes to user.js aren't loaded automatically; you can use a plugin to rotate
# - Thunderbird: no easy switch 
# - i3-dmenu-desktop you have to tweak i3 config file directly
