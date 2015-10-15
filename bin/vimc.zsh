#! /usr/bin/env zsh

# vimc — run a set of vim commands on a file to in-place edit it
# http://unix.stackexchange.com/a/22564/101165

cmdfile=${1?Must provide command file}
in1=${2?Must provide at least one file to process}

#vim --noplugin -u /dev/null -s ans2vimabbr.vim foo.txt
#print -l $cmdfile $@[2,-1]
vim --noplugin -u /dev/null -s $cmdfile $@[2,-1]
