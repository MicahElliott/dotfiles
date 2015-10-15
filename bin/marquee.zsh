#! /usr/bin/env zsh

# marquee — scrolling intro screen for screencasts

text=${1?Must provide arg}
brand=Code4Real
speed=0.2

autoload -U colors
colors

repeat 10; print '\n'

toilet --gay -t -f univers " $text"
print "$fg_bold[white]\t(A Screencast by $brand)"

repeat 3; print '\n'
repeat 35; do print; sleep $speed; done
