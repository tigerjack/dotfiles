#!/bin/sh
# BASENAME=$(basename "$1")
source ~/.env_global
source ~/.bash.d/bash_aliases
filename="z:${1//\//\\}"
echo "$filename"
# wn64 /usr/bin/wine "$MDIR_STANDALONE_SW/Windows/Reader/PDF-XChange Editor Plus [6.0.317.1] [crack]/PDFXEdit.exe" "$BASENAME"
wn64a wine64 "$MDIR_STANDALONE_SW/Windows/Reader/PDF-XChange Editor Plus [6.0.317.1] [crack]/PDFXEdit.exe" "$filename"
