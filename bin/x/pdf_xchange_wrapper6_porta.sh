#!/bin/sh
source ~/.env_global
source ~/.bash.d/bash_aliases
# Warning. It seems that wine has problems
# with directory having a . in their name
#
# wine should work well with namefile only, without absolute path
filename=$(basename "$1")
# The alternative 2 is converting the linux to the windows path
# filename=$(wn64a winepath -w "$1")
#
echo "$filename"
wn64a wine64 "$MDIR_STANDALONE_SW/Windows/Reader/PDF-XChange Editor Plus [6.0.317.1] [crack]/PDFXEdit.exe" "$filename"
