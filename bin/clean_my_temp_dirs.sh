#!/bin/sh
#Delete files older than 5 days
#echo "$(xdg-user-dir PICTURES)/NotShotwelled/Screenshots" > $HOME/none.txt
find $(xdg-user-dir PICTURES)/NotShotwelled/Screenshots -mtime +5 -type f -delete
