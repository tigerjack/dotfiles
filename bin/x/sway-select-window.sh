#!/usr/bin/env bash
# https://gitlab.com/wef/dotfiles/-/blob/master/bin/sway-select-window
# shellcheck disable=SC2034
TIME_STAMP="20220627.152924"

# Copyright (C) 2019-2021 Bob Hepple <bob dot hepple at gmail dot com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

# CUSTOMISE HERE IF YOU'RE NOT GETTING ALL YOUR ICONS:

# This array contains my most commonly used apps on f34, cached here
# for speed. If they don't work for you, you can either just remove
# these entries and rely on on-the-fly lookup of icons which may be
# slow. Or, for speedier operation, you can:

# 1. get all your common apps running
# 2. remove the entries in the array
# 3. run the script from the CLI
# 4. copy-paste the list of "[app]=icon" lines into the array

# Also, if all else fails, you can hardcode your app here:
declare -A icons=(
    [floating-kitty]=/usr/share/icons/hicolor/256x256/apps/kitty.png
    [kitty]=/usr/share/icons/hicolor/256x256/apps/kitty.png
    [emacs]=/usr/share/icons/hicolor/scalable/apps/emacs.svg
    [firefox]=/usr/share/icons/hicolor/48x48/apps/firefox.png
    [mythfrontend]=/usr/share/pixmaps/mythfrontend.png
    [kitty]=/usr/share/icons/hicolor/256x256/apps/kitty.png
    [Gdcalc]=/usr/share/pixmaps/HP-16C-48.xpm
    [pavucontrol]=/usr/share/icons/gnome/48x48/apps/multimedia-volume-control.png
    [pulseeffects]=/usr/share/icons/hicolor/scalable/apps/pulseeffects.svg
    [blueman-manager]=/usr/share/icons/hicolor/scalable/apps/blueman.svg
    [gnome-system-monitor]=/usr/share/icons/hicolor/scalable/apps/org.gnome.SystemMonitor.svg
    [gnome-disks]=/usr/share/icons/hicolor/scalable/apps/org.gnome.DiskUtility.svg
    [org.gnome.Weather]=/usr/share/icons/hicolor/scalable/apps/org.gnome.Weather.svg
    [xfce4-appfinder]=/usr/share/icons/hicolor/scalable/apps/org.xfce.appfinder.svg
)

KEYBOARD_DEVICE="/dev/input/event4"

PROG=$( basename "$0" )
case "$1" in
    -h|--help)
        echo "Usage: $PROG"
        echo
        echo "show running programs and select one to display (uses wofi)."

        echo "If evtest(1) is installed and sudo is available then you can press"
        echo "Shift-Enter to move the window here rather than move to"
        echo "the windows workspace. You may need to change KEYBOARD_DEVICE above."

        exit 0
        ;;
esac

jq_get_windows='
     # descend to workspace or scratchpad
     .nodes[].nodes[]
     # save workspace name as .w
     | {"w": .name} + (
       if (.nodes|length) > 0 then # workspace
         [recurse(.nodes[])]
       else # scratchpad
         []
       end
       + .floating_nodes
       | .[]
       # select nodes with no children (windows)
       | select(.nodes==[])
     )'

jq_windows_to_tsv='
    [
      (.id | tostring),
      # remove markup and index from workspace name, replace scratch with "[S]"
      (.w | gsub("<[^>]*>|:$"; "") | sub("__i3_scratch"; "[S]")),
      # get app name (or window class if xwayland)
      (.app_id // .window_properties.class),
      (.name),
      (.pid)
    ]
    | @tsv'

get_fs_win_in_ws() {
    id="${1:?}"

    swaymsg -t get_tree |
    jq -e -r --argjson id "$id" "
    [ $jq_get_windows  ]
    | (.[]|select(.id == \$id)) as \$selected_workspace
    | .[]
    | select( .w == \$selected_workspace.w and .fullscreen_mode == 1 )
    | $jq_windows_to_tsv
    "
}

get_hardcoded_icon() {
    icon="${icons[$1]}"
    echo "$icon"
}

get_desktop() {
    app="$1"
    p="/usr/share/applications"

    # fast and easy cases first:
    for prefix in "" org.kde. org.gnome. org.freedesktop.; do
        d="$p/$prefix$app.desktop"
        [[ -r "$d" ]] && echo "$d" && return
    done

    # maybe lowercase
    for prefix in "" org.kde. org.gnome. org.freedesktop.; do
        d="$p/$prefix${app,,}.desktop"
        [[ -r "$d" ]] && echo "$d" && return
    done

    # this is fairly reliable but slow:
    # look for a .desktop file with Exec=$app eg
    # gnome-disks (but exclude gnome-disk-image-writer.desktop)
    # gnome-font-viewer
    GREP='egrep -r'
    type rg &>/dev/null && GREP=rg
    d=$( $GREP -il "^exec=$app( %u)*[[:space:]]*$" $p | head -n 1)
    [[ -r "$d" ]] && echo "$d" && return

    # desperation - weird apps like com.github.wwmm.pulseeffects.desktop!!
    # shellcheck disable=SC2012
    d=$( ls "$p/"*".$app.desktop" | head -n 1 )
    [[ -r "$d" ]] && echo "$d" && return
}

get_icon() {
    icon_locations=(
        icons/hicolor/scalable/apps
        icons/hicolor/48x48/apps
        icons/hicolor/256x256/apps
        icons/gnome/48x48/apps
        icons/gnome/48x48/devices
        pixmaps
    )

    app="$1"

    icon=$( get_hardcoded_icon "$app_name" )
    [[ "$icon" && -r "$icon" ]] && echo "$icon" && return

    # let's go poke in the .desktop files:
    icon_name=""
    dt=$( get_desktop "$app" )

    # sometimes we get the 'class' rather than the exe - so try this:
    [[ "$dt" ]] || {
        app=$( tr '\0' '\n' < "/proc/$pid/cmdline" | head -n 1 )
        dt=$( get_desktop "$( basename "$app" )" )
    }

    [[ "$dt" ]] && {
        icon_name=$( awk -v IGNORECASE="set" -F"=" '/^icon/ {print $2}' "$dt" )
        [[ "$icon_name" ]] && {
            for d in "${icon_locations[@]}"; do
                for s in .svg .png ""; do
                    icon=/usr/share/$d/$icon_name$s
                    [[ -r $icon ]] && echo "$icon" && return
                done
            done
        }
    }

    # desperation street:
    icon=$( find /usr/share/icons /usr/share/pixmaps | grep -E -i "/$app.(png|svg)" | head -n 1 )
    [[ "$icon" && -r "$icon" ]] && echo "$icon" && return

    # failed:
    echo "/usr/share/icons/gnome/48x48/status/image-missing.png"
}

focus_window() {
    id="${1:?}"
    ws_name="${2:?}"
    app_name="${3:?}"
    win_title="${4:?}"

    printf "focusing window (in workspace %s): [%s] (%s) \`%s\`\n" "$ws_name" "$win_id" "$app_name" "$win_title" >&2

    # look for fullscreen among other windows in selected window's workspace
    if fs_win_tsv="$( get_fs_win_in_ws "$id" )" ; then
        read -r win_id ws_name app_name win_title <<<"$fs_win_tsv"
        if [ "$win_id" != "$id" ] ; then
            printf 'found fullscreen window in target workspace (%s): [%s] (%s) "%s"\n' "$ws_name" "$win_id" "$app_name" "$win_title" >&2
            swaymsg "[con_id=$win_id] fullscreen disable"
        fi
    fi

    swaymsg "[con_id=$id]" focus
}

unset markup # set markup, if you want this:

if [[ "$markup" ]]; then
    id_fmt='<span stretch="ultracondensed" size="xx-small">%s</span>'
    ws_fmt='<span size="small">%s</span>'
    app_fmt='<span weight="bold">%s</span>'
    title_fmt='<span style="italic">%s</span>'
else
    id_fmt='%s'
    ws_fmt='%s'
    app_fmt='%s'
    title_fmt='%s'
fi

TMP=$( mktemp )
trap 'rm $TMP' EXIT

swaymsg -t get_tree |
# get list of windows as tab-separated columns
jq -r "$jq_get_windows | $jq_windows_to_tsv" |
# align columns w/ spaces (keep tab as separator)
column -s $'\t' -o $'\t' -t |
# pango format the window list
while IFS=$'\t' read -r win_id ws_name app_name win_title pid; do
    icon=$( get_icon "$app_name" "$pid" )
    printf "[%s]=%s\n" "$app_name" "$icon" >&2
    # shellcheck disable=SC2059
    printf "img:$icon:text:${id_fmt}\t${app_fmt}\t${ws_fmt}\t${title_fmt}\n" \
           "$win_id" \
           "$app_name" \
           "$ws_name" \
           "$win_title"
done |
# sort by workspace name and then app_name:
sort -k3 -k2 |
# defeat the initial cache in order to preserve the order:
wofi --cache-file=/dev/null  -m --insensitive --allow-images --show dmenu --prompt='Focus a window' |

{
    FS=$'\t' read -r win_id ws_name app_name win_title

    # use evtest (if installed) to detect the state of the left shift
    # key and if it's 'down' then move to window here rather than mve
    # to the window's workspace. Should be safe if evtest or sudo are
    # not available.
    type evtest && sudo evtest --query $KEYBOARD_DEVICE EV_KEY KEY_LEFTSHIFT
    SHIFT_STATE=$?
    if (( SHIFT_STATE == 10 )); then
        # bring the window here
        swaymsg "[con_id=$win_id] move window to workspace current; focus $win_id"
    else
        focus_window "$win_id" "$ws_name" "$app_name" "$win_title"
    fi
}

exit 0

# this is the example documented in 'man 7 wofi' but it doesn't understand the scratchpad:
swaymsg -t get_tree |
jq -r '.nodes[].nodes[] | if .nodes then [recurse(.nodes[])] else [] end +  .floating_nodes  |  .[]  |  select(.nodes==[]) | ((.id | tostring) + " " + .name)' |
wofi --show dmenu | {
    read -r id name
    swaymsg "[con_id=$id]" focus
}

# Local Variables:
# mode: shell-script
# time-stamp-pattern: "4/TIME_STAMP=\"%:y%02m%02d.%02H%02M%02S\""
# eval: (add-hook 'before-save-hook 'time-stamp)
# End:
