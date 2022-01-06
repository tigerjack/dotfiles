#!/bin/bash
while true; do
	echo "Background changed"
	# feh --randomize --bg-fill -r "$(xdg-user-dir PICTURES)/NotShotwelled/Images/Astronomy/"*
	# feh --randomize --bg-fill $(xdg-user-dir PICTURES)/NotShotwelled/Images/Astromomy/hubble_3/imagecollection/*
	setrandom -v "$(xdg-user-dir PICTURES)/NotShotwelled/Backgrounds/esahubble-top100"
	sleep 30m
done
