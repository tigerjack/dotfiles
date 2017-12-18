directory_stack=/home/tigerjack/.gdir.txt
function gpush() {
    echo $(pwd) >> $directory_stack
    cd $1
}
function gpop() {
    [ ! -s $directory_stack ] && return
    newdir=$(sed -n '$p' $directory_stack)
    sed -i -e '$d' $directory_stack
    cd $newdir
}
