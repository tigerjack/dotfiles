#!/bin/sh
env WINEARCH=win32 env WINEPREFIX=/mnt/internal/LinuxData/wine/q4_32/ wine '/mnt/internal/LinuxData/wine/q4_32/drive_c/Program Files/Adobe/Acrobat Reader DC/Reader/AcroRd32.exe' "$@"
