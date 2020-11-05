for i in *; do 
    echo "$i"
    git --work-tree="$i" --git-dir="$i/.git" status -s
done
