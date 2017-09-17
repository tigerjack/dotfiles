#!/usr/bin/bash

for file in ~/bin/mycron/*; do
	name=$(basename -s .sh $file)
	logfile="/home/tigerjack/.startx/$name.log"
	( $file > "logfile" 2>&1 &)
done
