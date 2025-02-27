source ~/.env_global
export WINEPREFIX="$MDIR_LINUX_DATA/wine64c"
export WINEARCH=win64

# Convert Unix path to Windows path
winpath=$(winepath -w "$1")

# Run PDF-XChange Editor
wine start.exe /Unix "$WINEPREFIX/dosdevices/c:/Program Files/Tracker Software/PDF Editor/PDFXEdit.exe" "$winpath"
