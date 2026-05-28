#!/bin/bash - 
#===============================================================================
#
#          FILE: rsync.sh
# 
#         USAGE: ./rsync.sh <SERVER_NAME> <SERVER_ROOT_DIR>
# 
#   DESCRIPTION: Utility to synchronize files to server using rsync_filter.txt.
#                It is meant to be executed directly from your project root 
#                directory.
# 
#        AUTHOR: Simone Perriello
#  ORGANIZATION: 
#       CREATED: 30/04/2025 14:31
#===============================================================================

set -o nounset                              # Treat unset variables as an error
PROJECT="$(basename "$PWD")"
PROJECT_ROOT="$(dirname "$PWD")"
SERVER=$1
SERVER_ROOT=$2
FILTERS="${3:-$HOME/bin/my_rsync_filter.txt}"
echo "Project: $PROJECT, root: $PROJECT_ROOT, server: $SERVER, root: $SERVER_ROOT, filters: $FILTERS"
#
rsync -avz --info=progress2 \
  --filter="merge $FILTERS" \
  "$PROJECT_ROOT/$PROJECT" "$SERVER":"$SERVER_ROOT"/

