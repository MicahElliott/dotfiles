#! /usr/bin/env zsh

# gifanimate — DESCRIPTION...

print '
THIS IS A RECIPE.

cl https://github.com/z24/tty2gif

# fire up new big window with larger font
# needs to be big to force slow enough capture

rm foo.raw && ./tty2gif foo.raw foo.gif
# do some neat stuff to show off
x (logout)

# open in gimp: crop and remove front/end frames

# optimize and speed up playback
gifsicle -O3 --delay 10 <foo.gif >small.gif

eog small.gif
'
