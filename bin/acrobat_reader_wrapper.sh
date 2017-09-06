#!/usr/bin/sh
env WINEARCH=win32 env WINEPREFIX=/mnt/internal/LinuxData/wine/32/ wine '/mnt/internal/LinuxData/wine/32/drive_c/Program Files/Adobe/Acrobat Reader DC/Reader/AcroRd32.exe' "$@"
