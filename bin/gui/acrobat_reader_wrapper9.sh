#!/bin/sh
source ~/.env_global
export WINEPREFIX="$MDIR_LINUX_DATA/wines/wine32a"
export WINEARCH=win32

winpath=$(winepath -w "$1")

wine start.exe /Unix "$WINEPREFIX/dosdevices/c:/Program Files/Adobe/Reader 9.0/Reader/AcroRd32.exe" "$winpath"
