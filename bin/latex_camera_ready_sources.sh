set -o nounset                              # Treat unset variables as an error

# mkdir "./processed"
# mkdir "./processed/tikz"
# mkdir "./processed/algs"
# mkdir "./processed/tabs"
# cp tikz/tikz_*.pdf processed/tikz
# cp algs/alg*.tex processed/algs
# cp tabs/tab*.tex processed/tabs
# cp -r ext_data/ processed
# cp -r figures/ processed
# cp main.bib processed
# echo "Cleaning auxiliary files"
# rm *.{aux,log,bbl,blg,synctex.gz}
# echo "Removing main file"
# rm main.pdf
# latex_redacted.py -i "$PWD" -o "processed"
# cd "./processed"
# echo "Removing BOM characters from source files"
# find . -type f -name "*.tex" -exec sed '1s/^\xEF\xBB\xBF//' -i {} \;
# echo "Removing comments and merging into single file"
# latexpand --empty-comments  "main.tex" > "main_stripped.tex"
# sed -i '/^\s*%/d' "main_stripped.tex"
# cat -s "main_stripped.tex" > "main_stripped_squeezed.tex"
# Checking part
echo "---------Checking useless packages"
LaTeXpkges.py --latex pdflatex --bibtex bibtex --parallel "main_stripped_squeezed.tex"
#
latexmk -pdf -pdflatex="pdflatex -shell-escape -interaction=nonstopmode" -use-make main_stripped_squeezed.tex
#
echo "---------Printing unused entries"
checkcites -a -b biber main_stripped_squeezed
# echo "---------Checking bibliography"
# biblatex_check.py -b main.bib -a main_stripped_squeezed.aux
