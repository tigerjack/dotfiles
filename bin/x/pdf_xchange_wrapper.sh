#!/bin/sh
BASENAME=$(basename "$1")
env WINEPREFIX="$MDIR_LINUX_DATA/wine64/" env WINEARCH=win64 /usr/bin/wine "$MDIR_STANDALONE_SW/Windows/Reader/PDF-XChange Editor Plus [6.0.317.1] [crack]/PDFXEdit.exe" "$BASENAME"
