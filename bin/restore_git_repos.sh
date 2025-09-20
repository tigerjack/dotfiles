#!/bin/bash - 
#===============================================================================
#
#          FILE: restore_git_repos.sh
# 
#         USAGE: ./restore_git_repos.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 20/09/2025 16:31
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
#!/usr/bin/env bash
# Usage: ./restore-git-repos.sh repos.json vc
LIST_FILE="$1"
BASE_DIR="$2"

[[ -z "$LIST_FILE" || -z "$BASE_DIR" ]] && { echo "Usage: $0 <repos.json> <vc>"; exit 1; }

mkdir -p "$BASE_DIR"

jq -c '.[]' "$LIST_FILE" | while read -r repo; do
    path=$(echo "$repo" | jq -r '.path')
    target="$BASE_DIR/$path"
    mkdir -p "$(dirname "$target")"

    # Skip if already exists
    if [[ -d "$target/.git" ]]; then
        echo "Skipping $path (already exists)"
        continue
    fi

    origin=$(echo "$repo" | jq -r '.remotes.origin // empty')
    if [[ -z "$origin" ]]; then
        echo "No origin for $path, skipping clone"
        continue
    fi

    echo "Cloning $origin into $target"
    git clone "$origin" "$target"

    # Add other remotes
    jq -r '.remotes | to_entries[] | select(.key != "origin") | "\(.key) \(.value)"' <<< "$repo" | \
    while read -r name url; do
        git -C "$target" remote add "$name" "$url"
        echo "  Added remote $name -> $url"
    done
done


