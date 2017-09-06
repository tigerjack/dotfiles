#!/bin/sh
#Used to launch cmus (or pause/unpause if it's already running)
# This command will break if you rename it to
# something containing "cmus".

if ! pgrep cmus ; then
  urxvt -e cmus
else
  cmus-remote -u
fi
