#! /bin/zsh

# Other things to try:
# mplayer -vo gif89a yourvideosfilename.flv 

invid="${1:?Must provide input vid}"
outgif=$invid:r.gif
#mkdir vid2gif

echo "Generating $outgif"

# 1. Acquire a video clip (record something with xvidcap.

# 2. Convert to gif with ffmpeg (or probably gifsicle).
# Duration: 4s, Framerate: 5fps
# Quality sucks!
#ffmpeg -y -i $invid -t 4 -r 5 -pix_fmt rgb24 -loop_output 0 bigjunk.gif

# 3. Optimized it for size.
# Optional.
gifsicle --optimize <bigjunk.gif >$outgif

# 4. Clean up.
#rm bigjunk.gif


# ffmpeg -i orig.mp4 -r 10 -t 10 frame%3d.jpg
# convert -delay 5 -loop 0 *.jpg animation.gif
#
# List the possible formats. But ffmpeg sucks for creating GIF so don't
# bother with this.
# ffmpeg -pix_fmt list
#
# ffmpeg -i brainpulse-orig.mp4 -r 4 -t 2.5 -cropright 80 -cropleft 80 frame%3d.jpg
