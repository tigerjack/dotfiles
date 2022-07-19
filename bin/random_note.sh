#!/bin/bash - 
#===============================================================================
#
#          FILE: random_note.sh
# 
#         USAGE: ./random_note.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 06/21/2022 10:12
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
NOTES=(A A# Bb B C C# Db D D# Eb E F F# Gb G G# Ab)
TYPE=(Maj Min 7)

size_n=${#NOTES[@]}
size_t=${#TYPE[@]}
# echo "$size"
idx_n=$((RANDOM % size_n))
idx_t=$((RANDOM % size_t))
# echo "$index"
echo "${NOTES[$idx_n]} ${TYPE[$idx_t]}"

