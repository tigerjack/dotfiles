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

#!/usr/bin/env bash
# Usage: ./export-git-repos.sh vc > repos.json

#!/usr/bin/env bash
# Usage: ./export-git-repos.sh vc > repos.json

BASE_DIR="$1"
[[ -z "$BASE_DIR" ]] && { echo "Usage: $0 <vc_folder>"; exit 1; }

echo "["

first_repo=true
find "$BASE_DIR" -type d -name ".git" | while read -r gitdir; do
    repo_dir=$(dirname "$gitdir")
    rel_path="${repo_dir#$BASE_DIR/}"

    # Skip if it's not a valid git repository
    if ! git -C "$repo_dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        continue
    fi

    # Collect all remotes into JSON
    remotes=()
    while read -r name url _; do
        [[ -z "$name" || -z "$url" ]] && continue
        remotes+=("\"$name\":\"$url\"")
    done < <(git -C "$repo_dir" remote -v | awk '!seen[$0]++ {print $1, $2, $3}')

    remotes_json="{}"
    if [[ ${#remotes[@]} -gt 0 ]]; then
        remotes_json="{$(IFS=,; echo "${remotes[*]}")}"
    fi

    [[ "$first_repo" = true ]] && first_repo=false || echo ","
    echo "  {\"path\":\"$rel_path\",\"remotes\":$remotes_json}"
done

echo "]"


