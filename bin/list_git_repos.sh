#!/bin/bash - 
#===============================================================================
#
#          FILE: list_git_repos.sh
# 
#         USAGE: ./list_git_repos.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 20/09/2025 16:28
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#!/usr/bin/env bash
# Usage: ./export-git-repos.sh vc > repos.json
# vc = folder containing all git projects

BASE_DIR="$1"
[[ -z "$BASE_DIR" ]] && { echo "Usage: $0 <vc_folder>"; exit 1; }

echo "["

first=true
find "$BASE_DIR" -type d -name ".git" | while read -r gitdir; do
    repo_dir=$(dirname "$gitdir")
    rel_path="${repo_dir#$BASE_DIR/}"

    # Collect all remotes
    remotes_json=$(git -C "$repo_dir" remote -v | awk '{print $1" "$2}' | \
        awk '!seen[$0]++' | \
        awk '{printf "\"%s\":\"%s\"", $1, $2}' ORS=',' | sed 's/,$//')

    # Skip repos without remotes
    [[ -z "$remotes_json" ]] && remotes_json="{}"

    [[ "$first" = true ]] && first=false || echo ","
    echo "  {\"path\":\"$rel_path\",\"remotes\":{$remotes_json}}"
done

echo "]"


