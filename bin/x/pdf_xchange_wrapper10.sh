source ~/.env_global
source ~/.bash.d/bash_aliases
# wine should work well with namefile only, without absolute path
filename=$(basename "$1")
# The alternative 2 is converting the linux to the windows path
# filename=$(wn64a winepath -w "$1")
# wine64c wine64 start.exe /Unix "/mnt/internal/LinuxData/wine64c/dosdevices/c:/Program Files/Tracker Software/PDF Editor/PDFXEdit.exe" "$filename"
WINEARCH=win64 WINEPREFIX=$MDIR_LINUX_DATA/wine64c wine64 start.exe /Unix "/mnt/internal/LinuxData/wine64c/dosdevices/c:/Program Files/Tracker Software/PDF Editor/PDFXEdit.exe" "$filename"
