#! /bin/zsh

# Better behavior for pdftotext
# * multiple files
# * prints to stdout
# * cleans up .txt files
# * injects file name into output

x=${1?Must provide at least one .pdf file}

for p in $argv; do
  print "\n=${p:r}"
  pdftotext $p
  cat $p:r.txt
  rm $p:r.txt
done
