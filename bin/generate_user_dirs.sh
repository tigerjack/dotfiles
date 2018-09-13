#!/bin/sh
INPUT_FILE=~/.config/user-dirs.conf
OUTPUT_FILE=~/.config/user-dirs.dirs
BACKUP_FILE=~/.config/user-dirs.bak
FIRST_LINE="#AUTOGENERATED WITH generate_user_dirs.sh\n"

cp $OUTPUT_FILE $BACKUP_FILE
sed -e 's@\$MDIR_GLOBAL_DATA@'"$MDIR_GLOBAL_DATA"'@g' $INPUT_FILE > $OUTPUT_FILE
sed -i -e 's@\$MDIR_LINUX_DATA@'"$MDIR_LINUX_DATA"'@g' $OUTPUT_FILE
sed -i '1s;^;'"$FIRST_LINE"'\n;' $OUTPUT_FILE
