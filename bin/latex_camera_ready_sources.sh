set -o nounset                              # Treat unset variables as an error

echo "Cleaning auxiliary files"
rm *.{aux,log,bbl,blg,synctex.gz}
echo "Removing main file"
rm main.pdf
echo "Removing BOM characters from source files"
find . -type f -name "*.tex" -exec sed '1s/^\xEF\xBB\xBF//' -i {} \;
echo "Removing comments and merging into single file"
latexpand --empty-comments  "main.tex" > "main_stripped.tex"
sed -i '/^\s*%/d' "main_stripped.tex"
cat -s "main_stripped.tex" > "main_stripped_squeezed.tex"
# Checking part
echo "---------Checking useless packages"
LaTeXpkges.py --latex pdflatex --bibtex bibtex --parallel "main_stripped_squeezed.tex"
echo "---------Checking bibliography"
biblatex_check.py -b biblio.bib 
