#!/bin/sh

ping -c 1 -q 8.8.8.8 >/dev/null 2>&1
res=$?
if [ $res != 0 ]; then
    # Offline
    exit 1
else
    # Online
    exit 0
fi
