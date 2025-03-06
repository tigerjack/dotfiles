#!/bin/sh
source ~/.env_global
export WINEPREFIX="$MDIR_LINUX_DATA/wines/wine64a"
export WINEARCH=win64

winpath=$(winepath -w "$1")
wine "$MDIR_STANDALONE_SW/Windows/Reader/PDF-XChange Editor Plus [6.0.317.1] [crack]/PDFXEdit.exe" "$winpath"
