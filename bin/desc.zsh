#! /bin/zsh

# desc — use heading info to simply describe a script
#
# Useful as input to git commit message, too.

script=${1?Must provide script to describe}

sed -nr 1,5p $script |grep — |sed 's/.*— //'
