#!/bin/sh
xrandr --output DP2 --off --output DP1 --off --output TV1 --off --output HDMI1 --off --output LVDS1 --mode 1920x1080 --pos 0x1080 --rotate normal --output VGA1 --mode 1920x1080 --pos 0x0 --rotate normal

# And turn off mousepad
mt.zsh
