#!/bin/sh
BASENAME=$(basename "$1")
env WINEPREFIX=/mnt/internal/LinuxData/wine/q4_64_old/ env WINEARCH=win64 /usr/bin/wine /mnt/internal/FastFiles/ProgrammiStandalone/Windows/Reader/PDF-XChange\ Editor\ Plus\ \[6.0.317.1\]\ \[crack\]/PDFXEdit.exe "$BASENAME"

