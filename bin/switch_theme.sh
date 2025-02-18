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

switchto="${1:-def}"

# Determine the target theme if not provided, assuming gtk-2 has the source of truth
if [[ $switchto = def ]]; then
    if grep -q "gtk-theme-name=.*Dark" "$HOME/.gtkrc-2.0"; then
        switchto="light"
    else
        switchto="dark"
    fi
elif [[ $switchto != light ]] && [[ $switchto != dark ]]; then
    echo "Wrong argument"
    exit 1
fi

echo "Switching to $switchto"


# SED based Apply the configuration based on the selected theme
CONFIG_FILE="$HOME/.config/themes_config.cfg"
echo "# Sed based"

declare -A processed_files
# Iterate over the config file and process each line
while IFS=: read -r name file pattern light_value dark_value; do
    # Skip empty lines and comments
    [[ -z "$name" || "$name" =~ ^# ]] && continue

    eval "expanded_file=\"$file\""
    if [[ ! -f "$expanded_file" ]]; then
	echo "ERROR: File '$expanded_file' not found."
	continue
    fi

    # Output file (remove the '@theme' suffix)
    out_file="${expanded_file%.@theme}"

    # Collect patterns for the current file (skip first time)
    if [[ ! ${processed_files["$out_file"]+_} ]]; then
        # Copy the source file to the output file once
        cp "$expanded_file" "$out_file"
        # Mark the file as processed
        processed_files["$out_file"]=1
    fi

    # Choose the value based on target theme
    value=$([ "$switchto" = "light" ] && echo "$light_value" || echo "$dark_value")

    # Apply the sed operation for this pattern to the output file
    sed -E -i "s|($pattern).*|\1$value|" "$out_file"
    echo "Applied pattern to $out_file."
done < "$CONFIG_FILE"

echo "Theme switching complete."

qt5ct-refresh
echo "qt5ct-refresh done"

echo "# Others"
# cfgpath_firefox="$HOME/.mozilla/firefox"
cfgfile_wofi_stylesheet="$HOME/.config/wofi/style.css"
cfgfile_spt="$HOME/.config/spotify-tui/config.yml"
if [[ $switchto = light ]]; then
    kittystyle="Pencil Light"
    spttheme="light"
    makomode="light"
    spotifytheme="Ziro"
    spotifyscheme="purple-light"
    gtktheme=$(grep "^gtk2:" "$CONFIG_FILE" | awk -F: '{print $4}')
    spacemacs=$(grep "^spacemacs:" "$CONFIG_FILE" | awk -F: '{print $4}' | sed -n 's/.*(\([^ ]*\) .*/\1/p')
    zathura_recolor=$(grep "^zathura:" "$CONFIG_FILE" | awk -F: '{print $4}')
    tty_term_fg="black"
    tty_term_bg="white"
else # dark theme
    kittystyle="Pencil Dark"
    spttheme="dark"
    makomode="dark"
    spotifytheme="Ziro"
    spotifyscheme="purple-dark"
    gtktheme=$(grep "^gtk2:" "$CONFIG_FILE" | awk -F: '{print $5}')
    spacemacs=$(grep "^spacemacs:" "$CONFIG_FILE" | awk -F: '{print $5}' | sed -n 's/.*(\([^ ]*\) .*/\1/p')
    zathura_recolor=$(grep "^zathura:" "$CONFIG_FILE" | awk -F: '{print $5}')
    tty_term_fg="white"
    tty_term_bg="black"
fi

#setterm --inversescreen on
# setterm -clear all  -foreground "$tty_term_fg" -background "$tty_term_bg" -store
# echo "set terminal (tty)"


# KITTY
# cache age is there to not use internet
kitty +kitten themes --reload-in=all --cache-age -1 "$kittystyle"
echo "kitty done"

# This work for Firefox, Wofi and Thunderbird; however, the latter doesn't work
# see here https://wiki.archlinux.org/title/Dark_mode_switching#Tools
gsettings set org.gnome.desktop.interface gtk-theme "$gtktheme"
gsettings set org.gnome.desktop.interface color-scheme prefer-"$switchto"
echo "GTK through gsettings done"

### WOFI
if [[ $switchto == light ]]; then
  if [[ -e $cfgfile_wofi_stylesheet ]]; then
    rm "$cfgfile_wofi_stylesheet"
  fi
elif [[ $switchto == dark ]]; then
  ln -sf  "$XDG_CONFIG_HOME/wofi/themes/themes/gruvbox.css" "$XDG_CONFIG_HOME/wofi/style.css"
fi


### VIM
### VIM SERVER, this requires a vim installed with gui support, that unfortunately relies on X
# for i in $(vim --serverlist); do 
#     echo "vim server(s) running"
#     vim --servername "$i" --remote-send ":colorscheme $vimscheme<CR>"
# done
# echo "vim done"

### EMACS 
bla=$(pgrep -f "emacs --daemon")
if [ -n "$bla" ]; then
    echo "emacs server running"
    t=$(emacsclient -e "(load-theme '$spacemacs)")
    if [[ $t != t ]]; then
	echo "Unable to change theme in spacemacs"
    fi
fi
echo "emacs done"


### SPOTIFY-TUI
# WARN: This overwrite any personalized configuration in yaml
# TODO: A parser of config that preserves non-theme lines
ln -sf "$HOME/.config/spotify-tui/theme_$spttheme.yml" "$cfgfile_spt"
echo "spotify tui done"

### ZATHURA
# for already opened ones
for i in $(pidof zathura); do
    dbus-send --type="method_call" --dest=org.pwmt.zathura.PID-"$i" /org/pwmt/zathura org.pwmt.zathura.ExecuteCommand string:"set recolor $zathura_recolor"
done
echo "zathura done"

### MAKO
pgrep -x mako > /dev/null && makoctl set-mode "$makomode" && echo "mako done"

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
echo "spicety for spotify"

# Still missing 
# - CopyQ: theme not changeable easily; UP: now it seems to respect qt5 styles
# - Sway window colors
