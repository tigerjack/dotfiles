source ~/.env_global
source ~/.bash.d/bash_aliases
filename="z:${1//\//\\}"
# wn64 wine "C:/windows/command/start.exe" /Unix "/mnt/internal/LinuxData/wine64/dosdevices/c:/users/simone/Start Menu/Programs/Tracker Software/PDF-XChange Editor.lnk" "$BASENAME"
WINEARCH=win64 WINEPREFIX=$MDIR_LINUX_DATA/wine64c wine64 start.exe /Unix "/mnt/internal/LinuxData/wine64c/dosdevices/c:/Program Files/Tracker Software/PDF Editor/PDFXEdit.exe" "$filename"
