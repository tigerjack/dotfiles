#!/bin/sh
# BASENAME=$(basename "$1")
source ~/.env_global
source ~/.bash.d/bash_aliases
filename="z:${1//\//\\}"
# wn64 /usr/bin/wine "$MDIR_STANDALONE_SW/Windows/Reader/PDF-XChange Editor Plus [6.0.317.1] [crack]/PDFXEdit.exe" "$BASENAME"
wn64 /usr/bin/wine "$MDIR_STANDALONE_SW/Windows/Reader/PDF-XChange Editor Plus [6.0.317.1] [crack]/PDFXEdit.exe" "$filename"
#env WINEPREFIX="$MDIR_LINUX_DATA/wine64/" env WINEARCH=win64 /usr/bin/wine "$MDIR_STANDALONE_SW/Windows/Reader/PDF-XChange Editor Plus [6.0.317.1] [crack]/PDFXEdit.exe" "$BASENAME"
