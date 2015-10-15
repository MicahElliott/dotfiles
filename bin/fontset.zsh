#! /bin/zsh

# change font on the fly -- don't use this

# hard to use since every new shell still gets settings from .Xdefaults

# https://bbs.archlinux.org/viewtopic.php?id=44121
#
# Should do autocompletion of font names based on file in:
# /usr/share/kbd/consolefonts/
# /usr/share/fonts/TTF/
# /usr/share/fonts/...
#
# `xlsfonts` to see all?
# pickyfont (won't install)
# xfontsel

# Decent fonts:
# - profont-22
# - terminus-16-32
# - tamzen-17
# - tamzen-20

# Not working:
# - gohufont-14
# - erusfont-11
# - artwiz
# - ohsnap

#font=${1?Must provide font name}
#size=${2?Must provide size}

font=${1?Must provide font name}
if [[ $font == big ]]; then
  font='Ubuntu Mono'
  size=18
  ubuspec="xft:Ubuntu Mono:pixelsize=18"
  #printf '\33]50;%s\007' $ubuspec

  # /usr/share/fonts/TTF/SourceCodePro-Medium.ttf
  # Not enough difference between bold and med, and a little too wide.
  # printf '\033]710;xft:Source Code Pro:pixelsize=24:style=regular\007'
  # printf '\033]711;xft:Source Code Pro:pixelsize=24:style=bold\007'
  # printf '\033]712;xft:Source Code Pro:pixelsize=24:style=italic\007'
  # printf '\033]713;xft:Source Code Pro:pixelsize=24:style=bold italic\007'


  # https://github.com/bjin/dotfiles/blob/master/.Xdefaults
  # printf '\033]710;xft:Source Code Pro for Powerline:pixelsize=24\007'
  # printf '\033]711;xft:Source Code Pro for Powerline:style=Semibold:pixelsize=24\007'
  # printf '\033]712;xft:Source Code Pro for Powerline:italic:pixelsize=24\007'
  # printf '\033]713;xft:Source Code Pro for Powerline:style=bold:italic:pixelsize=24\007'




  # printf '\033]710;xft:CtrlD:style=Regular:pixelsize=16\007'
  # printf '\033]711;xft:CtrlD:style=Bold:pixelsize=16\007'
  # printf '\033]712;xft:CtrlD:style=Italic:pixelsize=16\007'
  # printf '\033]713;xft:CtrlD:style=Bold Italic:pixelsize=16\007'

  # printf '\033]710;xft:CtrlD:style=Regular:pixelsize=13\007'
  # printf '\033]711;xft:CtrlD:style=Bold:pixelsize=13\007'
  # printf '\033]712;xft:CtrlD:style=Italic:pixelsize=13\007'
  # printf '\033]713;xft:CtrlD:style=Bold Italic:pixelsize=13\007'

  # printf '\033]710;xft:CtrlD:style=Regular:pixelsize=10\007'
  # printf '\033]711;xft:CtrlD:style=Bold:pixelsize=10\007'
  # printf '\033]712;xft:CtrlD:style=Regular:pixelsize=10\007'
  # printf '\033]713;xft:CtrlD:style=Bold:pixelsize=10\007'

  # printf '\033]710;xft:Source Code Pro for Powerline:style=regular:pixelsize=24\007'
  # printf '\033]711;xft:Source Code Pro for Powerline:style=bold:pixelsize=24\007'
  # printf '\033]712;xft:Source Code Pro for Powerline:style=italic:pixelsize=24\007'
  # printf '\033]713;xft:Source Code Pro for Powerline:style=Bold:italic:pixelsize=24\007'

  # printf '\033]710;xft:Ubuntu Mono:pixelsize=32style=regular\007'
  # printf '\033]711;xft:Ubuntu Mono:pixelsize=32:style=bold\007'
  # printf '\033]712;xft:Ubuntu Mono:pixelsize=32:style=italic\007'
  # printf '\033]713;xft:Ubuntu Mono:pixelsize=32:style=bold italic\007'
  # printf '\033]710;xft:Droid Sans Mono:pixelsize=16\007'
  # printf '\033]711;xft:Droid Sans Mono:pixelsize=16:bold\007'
  # printf '\033]712;xft:Droid Sans Mono:pixelsize=16:italic\007'
  # printf '\033]713;xft:Droid Sans Mono:style=bold italic:pixelsize=16\007'
  printf '\033]710;xft:PT Mono:pixelsize=20\007'
  printf '\033]711;xft:PT Mono:pixelsize=20:bold\007'
  printf '\033]712;xft:PT Mono:pixelsize=20:italic\007'
  printf '\033]713;xft:PT Mono::style=bold italicpixelsize=20\007'

  # printf "\033]710;-*-profont-medium-r-*-*-22-*-*-*-*-*-iso8859-*\007"
  # printf "\033]711;-*-profont-bold-*-*-*-22-*-*-*-*-*-iso8859-*\007"
  # printf "\033]712;-*-profont-*-i-*-*-*-*-*-*-*-*-iso8859-1\007"
  # printf "\033]713;-*-profont-*-i-*-*-*-*-*-*-*-*-iso8859-1\007"

  # printf "\033]710;-*-gohufont-medium-r-*-*-14-*-*-*-*-*-iso8859-*\007"
  # printf "\033]711;-*-gohufont-bold-*-*-*-14-*-*-*-*-*-iso8859-*\007"
  # printf "\033]712;-*-gohufont-*-i-*-*-*-*-*-*-*-*-iso8859-1\007"
  # printf "\033]713;-*-gohufont-*-i-*-*-*-*-*-*-*-*-iso8859-1\007"

  # printf "\033]710;-*-terminus-medium-r-*-*-32-*-*-*-*-*-iso8859-*\007"
  # printf "\033]711;-*-terminus-bold-*-*-*-32-*-*-*-*-*-iso8859-*\007"
  # printf "\033]712;-*-terminus-*-i-*-*-*-*-*-*-*-*-iso8859-1\007"
  # printf "\033]713;-*-terminus-*-i-*-*-*-*-*-*-*-*-iso8859-1\007"

  # GOOD
  # printf "\033]710;-*-tamzen-medium-r-*-*-20-*-*-*-*-*-iso8859-*\007"
  # printf "\033]711;-*-tamzen-bold-*-*-*-20-*-*-*-*-*-iso8859-*\007"
  # printf "\033]712;-*-tamzen-*-i-*-*-*-*-*-*-*-*-iso8859-1\007"
  # printf "\033]713;-*-tamzen-*-i-*-*-*-*-*-*-*-*-iso8859-1\007"

else
  printf '\033]710;-misc-orp-medium-r-*-*-12-*-75-75-*-60-iso10646-*\007'
  printf '\033]711;-misc-orp-bold-r-*-*-*-*-*-*-*-*-iso10646-1\007'
  printf '\033]712;-misc-orp-*-i-*-*-*-*-*-*-*-*-iso10646-1\007'
  printf '\033]713;-misc-orp-*-i-*-*-*-*-*-*-*-*-iso10646-1\007'

fi
