#!/bin/bash - 
#===============================================================================
#
#          FILE: zathura_store.sh
# 
#         USAGE: ./zathura_store.sh 
# 
#   DESCRIPTION: Store all the files opened by zathura in a temporary file,
#		 in order for you to restore all the files later.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04/10/2024 10:39
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
mkdir -p "$XDG_CACHE_HOME/zathura"
# exclude the zathura spawned by emacs
pgrep -ax zathura | grep -v emacs | awk '{
    quote = 0;
    for(i=2; i<=NF; i++) {
        if ($i == "--") {
            printf "%s ", $i;      # Print the '--' token
            quote = 1;             # Set flag to start quoting
        } else if (quote == 1) {
            printf "\"%s", $i;     # Start quote before the first file path token
            quote = 2;             # Set flag to indicate quoting is active
        } else if (quote == 2) {
            printf " %s", $i;      # Continue printing inside quotes
        } else {
            printf "%s%s", $i, (i==NF?"\n":" ");  # Normal printing before the '--'
        }
    }
    if (quote == 2) printf "\"\n";  # Close the quote at the end of the file path
}' > "$XDG_CACHE_HOME/zathura/zathura_session"

