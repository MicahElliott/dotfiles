#! /bin/zsh

# A simple 'K' script for vim to send through vim-slime

cmd=${1?Must provide command}
cmd="(user/clojuredocs $cmd)"

#print "loading $cmd"
print $cmd |tmux load-buffer -
#print "pasting"
tmux paste-buffer
