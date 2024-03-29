#!/bin/bash - 
#===============================================================================
#
#          FILE: bash_gpush_pop.sh
# 
#         USAGE: ./bash_gpush_pop.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 25/10/2018 12:20
#      REVISION:  ---
#===============================================================================


#set -o nounset                              # Treat unset variables as an error


directory_stack="$XDG_CACHE_HOME"/gdir
function gpush() {
    a=1
    if [ $# -ge 1 ] ; then
	a=$1
    fi

    i=1
    while [ $i -le "$a" ]; do
	pwd >> "$directory_stack"
	i=$((i+1))
    done
}

function gpop() {
    [ ! -s "$directory_stack" ] && return
    newdir=$(sed -n '$p' "$directory_stack")
    sed -i -e '$d' "$directory_stack"
    cd "$newdir" || exit
}


function gstatus() {
    cat "$directory_stack"
}

gclear ()
{   
    # no-op, just to rewrite
    true > "$directory_stack"
}
