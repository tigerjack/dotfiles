#!/bin/sh
readonly to_exec="$(grep '^Exec' "$1" | tail -1 | sed 's/^Exec=//' | sed 's/%.//' | sed 's/^"//g' | sed 's/" *$//g')"
echo "$to_exec"
$to_exec &
