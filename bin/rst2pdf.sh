#! /bin/bash

usage="usage: $0 file_minus_ext"
test -z $1 && { echo $usage; exit 1; }
echo $1 |grep '\.txt$' && { echo $usage; exit 1; }
test -d tex || { mkdir tex; echo 'Created "tex" dir.'; }
rst2latex.py $1.txt >tex/$1.tex || exit 1
cd tex
texi2pdf $1.tex
mv $1.pdf ..
cd ..
rm -rf tex
