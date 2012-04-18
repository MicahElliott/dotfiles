#! /bin/zsh

# Randomly choose a desktop wallpaper.

wallpapers="$HOME/Pictures/wallpapers/*.jpg"

wp=$( print -l $~wallpapers |shuf -n1 )
##print "Wallpaper: $wp"

gconftool -t str -s /desktop/gnome/background/picture_filename $wp
