#!/bin/bash - 
#===============================================================================
#
#          FILE: pacrecover.sh
# 
#         USAGE: ./pacrecover.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 01/26/2021 13:29
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
#!/bin/bash -e

. /etc/makepkg.conf

PKGCACHE=$((grep -m 1 '^CacheDir' /etc/pacman.conf || echo 'CacheDir = /var/cache/pacman/pkg') | sed 's/CacheDir = //')

pkgdirs=("$@" "$PKGDEST" "$PKGCACHE")

while read -r -a parampart; do
  pkgname="${parampart[0]}-${parampart[1]}-*.pkg.tar.{xz,zst}"
  for pkgdir in ${pkgdirs[@]}; do
    pkgpath="$pkgdir"/$pkgname
    [ -f $pkgpath ] && { echo $pkgpath; break; };
  done || echo ${parampart[0]} 1>&2
done

