#!/bin/bash - 
#===============================================================================
#
#          FILE: bash_remote_jupyter.sh
# 
#         USAGE: ./bash_remote_jupyter.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 07/30/2019 10:29
#      REVISION:  ---
#===============================================================================

# https://ljvmiranda921.github.io/notebook/2018/01/31/running-a-jupyter-notebook/
function jpt() {
    # Should be put on the server
    # Fires-up a Jupyter notebook by supplying a specific port
    jupyter-notebook --no-browser --port="$1"
}

function jptt(){
    # Forwards port $2 opened on machine $1 into port $2 on localhost and listens to it
    ssh -N -f -L localhost:"$3":localhost:"$2" simone@$1
    echo "Remember to kill the server-side notebook and the port-forwarding process using sudo netstat -lpn | grep 'local port number'"
}

