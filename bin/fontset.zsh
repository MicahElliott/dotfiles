#! /bin/zsh

# change font on the fly -- don't use this

# https://bbs.archlinux.org/viewtopic.php?id=44121
#
# Should do autocompletion of font names based on file in:
# /usr/share/kbd/consolefonts/
# /usr/share/fonts/TTF/
# /usr/share/fonts/...
#
# `xlsfonts` to see all?
# pickyfont

#font=${1?Must provide font name}
#size=${2?Must provide size}

font=${1?Must provide font name}
if [[ $font == big ]]; then
  font='Ubuntu Mono'
  size=18
  ubuspec="xft:Ubuntu Mono:pixelsize=18"
  #printf '\33]50;%s\007' $ubuspec
  printf '\033]710;xft:Ubuntu Mono:pixelsize=18\007'
  printf '\033]711;xft:Ubuntu Mono:pixelsize=18:bold\007'
  printf '\033]712;xft:Ubuntu Mono:pixelsize=18:italic\007'
  printf '\033]713;xft:Ubuntu Mono:pixelsize=18:italic\007'
else
  printf '\033]710;-misc-orp-medium-r-*-*-12-*-75-75-*-60-iso10646-*\007'
  printf '\033]711;-misc-orp-bold-r-*-*-*-*-*-*-*-*-iso10646-1\007'
  printf '\033]712;-misc-orp-*-i-*-*-*-*-*-*-*-*-iso10646-1\007'
  printf '\033]713;-misc-orp-*-i-*-*-*-*-*-*-*-*-iso10646-1\007'
fi
