#!/bin/sh
env WINEARCH=win64 env WINEPREFIX=/mnt/internal/LinuxData/wine/q4_64_old/ wine '/mnt/internal/LinuxData/wine/q4_64_old/drive_c/Program Files/PDFStudio11/pdfstudio11.exe' "$@"
