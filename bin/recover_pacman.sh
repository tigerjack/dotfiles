#!/bin/bash - 
#===============================================================================
#
#          FILE: recover_pacman.sh
# 
#         USAGE: ./recover_pacman.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 01/26/2021 12:26
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
#!/bin/bash
set -eu

#------------------------------------------------------------------------------#
#                                Configuration                                 #
#------------------------------------------------------------------------------#

# Default values for command-line arguments.

# Default repos to check. The matching file databases must be present in the
# local sync database or available on the Arch Linux Archive:
# https://archive.archlinux.org/repos/
REPOS=(core extra community)

# The date to use when retrieving databases from the Arch Linux Archive, in the
# format yyyy/mm/dd. If not date is given, then today's date will be used.
DATE=

# Set the system root.
ROOT=/

# The pacman sync db directory to check for existing file databases.
SYNC_DB_DIR=/var/lib/pacman/sync/

# Set match percentage threshold (matching files / total files) for a package to
# be considered a match and printed.
MATCH_THRESHOLD=50

# If true, only print matching package names.
QUIET=false



#------------------------------------------------------------------------------#
#                                  Functions                                   #
#------------------------------------------------------------------------------#

function check_files_db()
{
  local files_db=$1
  local entry
  local pkg
  local pkgname

  bsdtar -tf "$files_db" | while read entry
  do
    if [[ $entry =~ /files$ ]]
    then
      pkg=${entry%/*}
      pkgname=${pkg%-*-*}
      # Invoke bsdtar in a subshell so that we can update a path counter outside
      # of the loop.
      local match=0
      local number=0
      local path
      local pct
      while read path
      do
        # Skip directories.
        if [[ $path =~ /$ ]]
        then
          continue
        fi
        ((number+=1))
        if [[ -e ${ROOT%/}/$path ]]
        then
          ((match+=1))
        fi
      done < <(bsdtar -Oxf "$files_db" "$entry")
      if [[ $match -gt 0 ]]
      then
        pct=$(bc -l <<< "scale=0; 100 * $match / $number")
        if [[ $pct -gt $MATCH_THRESHOLD ]]
        then
          if $QUIET
          then
            echo "$pkgname"
          else
            echo "$pkg ${pct}%"
          fi
        fi
      fi
    fi
  done
}

# Usage: get_files_db <repo> [<yyyy/mm/dd>]
function get_files_db()
{
  local repo=$1
  local date=${2:-$(date +'%Y/%m/%d')}
  local arch=$(uname -m)
  wget -N "https://archive.archlinux.org/repos/$date/$repo/os/$arch/$repo.files"
}



function display_help()
{
  cat <<HELP
ABOUT

This is a tool to help recover the local pacman database. It will check
installed files against paths in the pacman file databases to estimate which
package are probably installed on the system. The matches are based entirely on
matching file paths.

For each package, the percent of matching files is calculated. If it meets the
threshold, the package is printed to stdout.

The list of matching packages is only a starting point for
recovering the local database. Some packages include the same paths so the user
will have to determine which of the matches, if any, are likely to be installed
on the system. Also note that no information about the install reaspon can be
determined by matching paths. It is up to the user to figure out which packages
were installed explicitly and which were installed as dependencies.

Also note that if the installed version of a package does not match the version
in the file database, then all paths that contain the version number
(e.g. /usr/lib/foo-xx.xx/...) will fail to match. It is therefore important to
determine which file database matches the installed files.

Local file databases in the sync directory (/var/lib/pacman/sync by default)
will be consulted first if they exist as they are likely to correspond to the
installed version if everything was synchronized together (pacman -Syu; pacman
-Fy). This can be disabled by passing an empty path to the "-s" option.

If the local file databases do not exist, or the check is disabled, an attempt
will be made to download the file database from the Arch Linux Archive
(https://archive.archlinux.org/repos/). A date may be given in the format
yyyy/mm/dd to select a specific date, otherwise the current date will be used.
If you know the date of your last system upgrade (even approximately), pass it
with the "-d" option.


USAGE

  ${0} [options] [repo repo ...]

If no repos are given, the following will be checked: ${REPOS[@]}


OPTIONS

  -d yyyy/mm/dd
    Set the date for retrieving databases from the Arch Linux Archive.
    Default: today's date

  -r /path/to/root
    The system root in which to match packages.
    Default: "/".

  -s /path/to/sync_db/dir
    The path to the pacman sync database directory to query local file
    databases. These are normally downloaded with "pacman -Fy". See the notes
    above about matching database package versions to installed versions. To
    disable local checks, set this to an empty string.
    Default: /var/lib/pacman/sync

  -t <percent>
    The percent of files per package that must exist on the local system for the
    package to match.
    Default: 50

  -q
    Only print package names. This can be used to create an install list that
    can be piped to pacman. E.g.
    ${0} -q | pacman -S -

HELP
  exit "$1"
}



#------------------------------------------------------------------------------#
#                                     Main                                     #
#------------------------------------------------------------------------------#

while getopts 'hd:r:s:t:q' flag
do
  case "$flag" in
    d) DATE=$OPTARG ;;
    r) ROOT=$OPTARG ;;
    s) SYNC_DB_DIR=$OPTARG ;;
    t) MATCH_THRESHOLD=$OPTARG ;;
    q) QUIET=true ;;
    h) display_help 0 ;;
    *) display_help 1 ;;
  esac
done

shift $((OPTIND - 1))
if [[ $# -gt 0 ]]
then
  REPOS=("$@")
fi

for repo in "${REPOS[@]}"
do
  files_db=
  if [[ ! -z $SYNC_DB_DIR ]]
  then
    # Check for local file databases first.
    files_db=${SYNC_DB_DIR%/}/${repo}.files
  fi
  if [[ -z $files_db || ! -e $files_db ]]
  then
    get_files_db "$repo" "$DATE"
    files_db=${repo}.files
  fi
  if $QUIET
  then
    check_files_db "$files_db"
  else
    date -r "$files_db"  +"$files_db %F %R %Z"
    echo '--------------------'
    check_files_db "$files_db"
    echo ''
  fi
done

