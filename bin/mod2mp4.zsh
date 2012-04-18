#! /bin/zsh

# Convert a .MOD camcorder file to appropriately sized/formatted .mp4.
#
# Standard size for SD camcorders is 480p. There is some disagreement
# on what exactly this means (http://en.wikipedia.org/wiki/480p), but
# safest width is 854.
#
# This is also a commonly supported format by mobile devices,
# projectors, and netbooks:
# http://en.wikipedia.org/wiki/List_of_mobile_phones_with_WVGA_display
# http://en.wikipedia.org/wiki/Wide_VGA#WVGA_.28800.C3.97480.29
#
# Another 16:9 possibility is 720x400. For some reason VLC and Totem
# display MODs as such. They seem confused about displaying though.

mod=${1?Must provide arg}

HandBrakeCLI -i $mod --deinterlace -w 854 -l 480 -o ${mod:r}.mp4

