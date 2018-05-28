#!/bin/sh

#echo "$1"
t=$(file -b --mime-type "$1")
#echo $t
#cat "$1" | xclip -selection c -t "$t"
xclip -selection c -t "$t" -i "$1"
#xclip -selection c -t "$t" < "$1"
#copyq write $t - < $1 && copyq select 0
