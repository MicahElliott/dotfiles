#!/bin/sh

# xrandr --newmode 2880x1800  442.00  2880 3104 3416 3952  1800 1803 1809 1865 -hsync +vsync
# xrandr --addmode Virtual1 2880x1800
# xrandr --output Virtual1 --mode 2880x1800

xrandr --newmode "3840x2160" 712.75 3840 4160 4576 5312 2160 2163 2168 2237 -hsync +vsync
xrandr --addmode Virtual1 3840x2160
xrandr --output Virtual1 --mode 3840x2160
