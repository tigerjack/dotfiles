#!/bin/sh
MINUTES=$(less ~/.xscreensaver | grep timeout | cut -f3 -d:)
while true; do
	xscreensaver-command -deactivate >/dev/null
	sleep "$MINUTES"m
done
