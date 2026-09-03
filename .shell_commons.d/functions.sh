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

    gstatus
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


#### rclone specific
# --- Shared safety wrapper -------------------------------------------------
# Every rclone_* function below takes --live to actually execute;
# without it, everything runs as --dry-run and just shows you what would happen.
_rclone_run() {
  local live=0
  local args=()
  for a in "$@"; do
    if [[ "$a" == "--live" ]]; then
      live=1
    else
      args+=("$a")
    fi
  done
  if [[ $live -eq 1 ]]; then
    rclone "${args[@]}"
  else
    echo "[DRY RUN — pass --live to actually execute]"
    rclone "${args[@]}" --dry-run
  fi
}

# --- polimi (OneDrive) ------------------------------------------------------

# Safe: copy only, never deletes on either side
rclone_polimi_pull() {
  _rclone_run copy --copy-links --create-empty-src-dirs --local-case-sensitive -v \
    polimi: "$MDIR_PUBLIC_DATA/onedrive/polimi_wsl/" \
    --filter-from ~/.config/rclone/polimi_filters.txt "$@"
}
rclone_polimi_push() {
  _rclone_run copy --copy-links --create-empty-src-dirs --local-case-sensitive -v \
    "$MDIR_PUBLIC_DATA/onedrive/polimi_wsl/" polimi: \
    --filter-from ~/.config/rclone/polimi_filters.txt "$@"
}

# Destructive: mirrors, will delete on the destination — named explicitly
rclone_polimi_pull_sync() {
  _rclone_run sync --copy-links --create-empty-src-dirs --local-case-sensitive -v \
    polimi: "$MDIR_PUBLIC_DATA/onedrive/polimi_wsl/" \
    --filter-from ~/.config/rclone/polimi_filters.txt "$@"
}
rclone_polimi_push_sync() {
  _rclone_run sync --copy-links --create-empty-src-dirs --local-case-sensitive -v \
    "$MDIR_PUBLIC_DATA/onedrive/polimi_wsl/" polimi: \
    --filter-from ~/.config/rclone/polimi_filters.txt "$@"
}

# Two-way — if filters.txt ever changed since the last run, add --resync
rclone_polimi_bisync() {
  _rclone_run bisync "$MDIR_PUBLIC_DATA/onedrive/polimi_wsl/" polimi: \
    --filters-file ~/.config/rclone/polimi_filters.txt \
    --copy-links --create-empty-src-dirs -MvP "$@"
}

# --- proton (Proton Drive) --------------------------------------------------

rclone_proton_pull() {
  _rclone_run copy proton: "$MDIR_PUBLIC_DATA/protondrive/" \
    --copy-links --create-empty-src-dirs \
    --filter-from ~/.config/rclone/proton_filters.txt -MvP "$@"
}
rclone_proton_push() {
  _rclone_run copy "$MDIR_PUBLIC_DATA/protondrive/" proton: \
    --copy-links --create-empty-src-dirs \
    --filter-from ~/.config/rclone/proton_filters.txt -MvP "$@"
}

rclone_proton_pull_sync() {
  _rclone_run sync proton: "$MDIR_PUBLIC_DATA/protondrive/" \
    --copy-links --create-empty-src-dirs \
    --filter-from ~/.config/rclone/proton_filters.txt -MvP "$@"
}
rclone_proton_push_sync() {
  _rclone_run sync "$MDIR_PUBLIC_DATA/protondrive/" proton: \
    --copy-links --create-empty-src-dirs \
    --filter-from ~/.config/rclone/proton_filters.txt -MvP "$@"
}

# Remember: if proton_filters.txt changed since the last successful bisync,
# run once with --resync before trusting this.
rclone_proton_bisync() {
  _rclone_run bisync "$MDIR_PUBLIC_DATA/protondrive/" proton: \
    --copy-links --create-empty-src-dirs \
    --filter-from ~/.config/rclone/proton_filters.txt \
    --checkers=4 --transfers=2 -MvP "$@"
}

# --- gdrive_promethence (shared folder, editor access only — copy-only) ----
# Deliberately no sync/bisync variant for this remote. 
# I don't own this folder, deletions land in the owner's trash, not mine.

rclone_gd4prom_pull() {
  _rclone_run copy promethence_gdrive: "$MDIR_PUBLIC_DATA/gdrive_promethence" --copy-links -MvP "$@"
}

rclone_gd4prom_pull_sync() {
  _rclone_run sync promethence_gdrive: "$MDIR_PUBLIC_DATA/gdrive_promethence" --copy-links -MvP "$@"
}

rclone_gd4prom_push() {
  _rclone_run copy "$MDIR_PUBLIC_DATA/gdrive_promethence" promethence_gdrive: --copy-links -MvP "$@"
}
