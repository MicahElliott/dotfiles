#! /bin/zsh

# vimcat — colorfully dump html to console; useful for vim-syntax-colored file

# Nice options:
# * -d delete .html file
# * -b fire up html in $BROWSER

orig=${1?Must provide html file}

# Would be better to fire up vim in new window so as not to clear existing
# v $orig -c ':TOhtml|w|q|q'
vim $orig -c ':TOhtml|w|q|q'
clear

# Stoopid elinks puts an space at the front of everything, inside a double
# colorcode.
elinks -dump -dump-color-mode 3 -no-references -no-numbering $orig.html |sed -r 's/\s//'

rm $orig.html
