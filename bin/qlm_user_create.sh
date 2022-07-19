#!/bin/bash - 
#===============================================================================
#
#          FILE: qlm_user_create.sh
# 
#         USAGE: ./qlm_user_create.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 05/30/2022 10:35
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if [ "$#" != "2" ]; then
    echo "You must provide two args, username and pub ssh key path."
fi

NEWUSER=$1

mkdir /home/"$NEWUSER"
sudo adduser -m -s /bin/bash -g "$NEWUSER" -G polimi "$NEWUSER"
chown -R "$NEWUSER":"$NEWUSER" /home/"$NEWUSER"

PASSWD=$(date | md5sum | cut -c1-8)
echo "$PASSWD" | passwd --expire "$NEWUSER"
echo "Password for new user is $PASSWD"

mkdir /home/"$NEWUSER"/.ssh/
ssh-copy-id -i "$1" > /home/"$NEWUSER"/.ssh/authorized_keys

chown -R "$NEWUSER":"$NEWUSER" /home/"$NEWUSER"/.ssh
chmod 700 /home/"$NEWUSER"/.ssh
chmod 600 /home/"$NEWUSER"/.ssh/authorized_keys
