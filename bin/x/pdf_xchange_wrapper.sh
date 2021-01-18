#!/bin/sh
BASENAME=$(basename "$1")
source ~/.global_env
source ~/.bash.d/bash_aliases
wn64 /usr/bin/wine "$MDIR_STANDALONE_SW/Windows/Reader/PDF-XChange Editor Plus [6.0.317.1] [crack]/PDFXEdit.exe" "$BASENAME"
#env WINEPREFIX="$MDIR_LINUX_DATA/wine64/" env WINEARCH=win64 /usr/bin/wine "$MDIR_STANDALONE_SW/Windows/Reader/PDF-XChange Editor Plus [6.0.317.1] [crack]/PDFXEdit.exe" "$BASENAME"


# args=""
# winpath="$(env WINEPREFIX="$MDIR_LINUX_DATA/wine64/" env WINEARCH=win64 winepath .)"
# echo "$winpath"
# winpath="Z:/home/simone"
# for arg in $@
# do
#     BASENAME=$(basename "$arg")
#     args+="$winpath/$BASENAME "
# done
# echo $args
# source ~/.global_env
# #env WINEPREFIX="$MDIR_LINUX_DATA/wine64/" env WINEARCH=win64 /usr/bin/wine "$MDIR_STANDALONE_SW/Windows/Reader/PDF-XChange Editor Plus [6.0.317.1] [crack]/PDFXEdit.exe" "$BASENAME"
# env WINEPREFIX="$MDIR_LINUX_DATA/wine64/" env WINEARCH=win64 /usr/bin/wine "$MDIR_STANDALONE_SW/Windows/Reader/PDF-XChange Editor Plus [6.0.317.1] [crack]/PDFXEdit.exe" "$args"
