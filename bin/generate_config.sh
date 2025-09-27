#!/bin/bash - 
#===============================================================================
#
#          FILE: generate_config.sh
# 
#         USAGE: ./generate_config.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 11/02/2025 19:49
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

bin/generate_from_global_env.sh

declare -a arr=("$XDG_CONFIG_HOME/waybar/config");

# Set user directories
for i in "${arr[@]}"; do
    ln -sf "$i.$HOSTNAME" "$i"
done


