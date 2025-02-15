#!/bin/bash
while true; do
    # We sleep first bcz in the beginning the background is set to the old wallpaper
    sleep 30m
    # echo "Changing background"
    # feh --randomize --bg-fill -r "$(xdg-user-dir PICTURES)/NotShotwelled/Images/Astronomy/"*
    # feh --randomize --bg-fill $(xdg-user-dir PICTURES)/NotShotwelled/Images/Astromomy/hubble_3/imagecollection/*
    # execute set random and take the command executed, which is in the form `swaymsg output * bg ...`
    setrandom -v "$(xdg-user-dir PICTURES)/NotShotwelled/Backgrounds/esahubble-top100" | grep swaymsg | cut -d' ' -f2- > ~/.config/sway/conf.d/wallpaper.conf
done
