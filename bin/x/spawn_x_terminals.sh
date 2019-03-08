#!/bin/bash

echo "$1"
i=1
while [ "$i" -le "$1" ]; do
	i3-sensible-terminal &
	i=$((i+1))
done
