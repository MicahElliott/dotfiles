#! /usr/bin/env zsh

# NAME — DESCRIPTION...

# IDEA: create library of zsh funcs for stat ops

op=${1?Must provide operator}
arg1=${2?Must provide at least one operand}

/usr/bin/r -e "cat($op(as.integer(argv)))" $@[2,-1]

