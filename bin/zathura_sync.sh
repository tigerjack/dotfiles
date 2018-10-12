#!/bin/sh
# See https://mssun.me/blog/spacemacs-and-latex.html
# Not used anymore
pos="$1"
pdffile="$2"
zathura --synctex-forward "$pos" "$pdffile" || \
    (
        zathura -x "emacsclient --eval '(progn (find-file \"%{input}\") (goto-line %{line}))'" "$pdffile" &
        sleep 1; zathura --synctex-forward "$pos" "$pdffile" )

exit
