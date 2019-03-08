#!/bin/sh
find "$1" -type d -printf '%d:%p\n' | sort -n | tail -1

# Test 1
#dir_depth() {
#  cd "$1"
#  maxdepth=0
#  for d in */.; do
#    [ -d "$d" ] || continue
#    depth=`dir_depth "$d"`
#    maxdepth=$(($depth > $maxdepth ? $depth : $maxdepth))
#  done
#  echo $((1 + $maxdepth))
#}
#
#dir_depth "$@"

# Test 2
#dir_depth(){
#
#    # don't need olddir and counter needs to be "global"
#    local dir
#    cd -- "$1"    # the -- protects against dirnames that start with -
#
#    # do this out here because we're counting depth not visits
#    ((counter++))
#
#    for dir in */.
#    do
#      if [ -d "$dir" ]
#      then
#        # we want to descend from where we are rather than where we started from
#        dir_depth "$dir"
#      fi
#    done
#    if ((counter > max))
#    then
#        max=$counter      # these are what we're after
#        maxdir=$PWD
#    fi
#    ((counter--))    # decrement and test to see if we're back where we started
#    if (( counter == 0 ))
#    then
#        echo $max $maxdir    # ta da!
#        unset counter        # ready for the next run
#    else
#        cd ..   # go up one level instead of "olddir"
#    fi
#}
