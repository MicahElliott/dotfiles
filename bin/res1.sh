#!/bin/sh

xrandr --newmode 2880x1800  442.00  2880 3104 3416 3952  1800 1803 1809 1865 -hsync +vsync

xrandr --addmode Virtual1 2880x1800

xrandr --output Virtual1 --mode 2880x1800

# xrandr --output Virtual3 --off --output Virtual2 --off --output Virtual1 --primary --mode 2880x1800_60.00 --pos 0x0 --rotate normal --output Virtual7 --off --output Virtual6 --off --output Virtual5 --off --output Virtual4 --off --output Virtual8 --off
